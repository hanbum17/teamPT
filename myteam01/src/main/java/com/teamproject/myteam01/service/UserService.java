
package com.teamproject.myteam01.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.teamproject.myteam01.domain.EventVO;
import com.teamproject.myteam01.domain.RestaurantVO;
import com.teamproject.myteam01.domain.UserActivityVO;
import com.teamproject.myteam01.domain.UserVO;
import com.teamproject.myteam01.mapper.EventMapper;
import com.teamproject.myteam01.mapper.RestaurantMapper;
import com.teamproject.myteam01.mapper.UserMapper;

@Service
public class UserService {

    @Autowired
    private UserMapper userMapper;
    @Autowired
    private EventMapper eventMapper;
    @Autowired
    private RestaurantMapper restMapper;
	 
	public List<UserVO> selectUserList(){
		List<UserVO> userList = userMapper.selectUserList();
		for(UserVO username : userList) {
			username.setRoles(userMapper.findRolesByUserId(username.getUserId()));
		}
		return userList ;
	}
	
	 
	 private PasswordEncoder passwordEncoder() {
	        return new BCryptPasswordEncoder();
	    }

    // PasswordEncoder를 바로 호출
    public void registerUser(UserVO user) {
        String encodedPassword = passwordEncoder().encode(user.getUserPw());
        user.setUserPw(encodedPassword);
        userMapper.insertUser(user);
        userMapper.userRegisterActivity(user);
    }

    public void registerUserRole(String userId, String role) {
        userMapper.insertUserRole(userId, role);
    }
    
    // 현재 비밀번호 확인
    public boolean checkPassword(UserVO user, String currentPassword) {
        return passwordEncoder().matches(currentPassword, user.getUserPw());
    }

    // 새 비밀번호로 변경
    public void changePassword(UserVO user, String newPassword) {
        String encodedPassword = passwordEncoder().encode(newPassword);
        user.setUserPw(encodedPassword);
        userMapper.updateUserPassword(user);
    }

    
    // 사용자 ID 중복 여부 확인
    public boolean isUserIdDuplicate(String userId) {
        return userMapper.findByUsername(userId) != null;
    }

    public UserVO findByUsername(String userId) {
    	UserVO userVO = userMapper.findByUsername(userId);
    	userVO.setRoles(userMapper.findRolesByUserId(userId));
        return userVO;
    }
    
    public void updateUser(UserVO userVO) {
    	userMapper.updateUser(userVO);
    	changePassword(userVO, userVO.getPassword());
    }

    public void updateLastLoginDate(String userId) {
        userMapper.updateLastLoginDate(userId);
    }
    

    public Integer findUserRoleId(String userId) {
        return userMapper.findUserRoleId(userId);
    }
    
    public boolean isUserAdmin(String userId) {
        Integer roleId = userMapper.findUserRoleId(userId);
        return roleId != null && roleId == 1;
    }

    public void deactivateAccount(String userId) {
        userMapper.updateAccountStatus(userId, 1); // 1로 업데이트하여 계정을 비활성화
    }
    
    
    
    //영범
    //성별 통계
    public UserVO countGender() {
    	List<UserVO> genderCount = userMapper.userGenderCount();
    	UserVO result = new UserVO(); // 초기화
    	for (UserVO user : genderCount) {
            if (user.getUserGender() == 'M') {
                result.setMaleCnt(result.getMaleCnt() + 1L); 
            } else if (user.getUserGender() == 'F') {
                result.setFemaleCnt(result.getFemaleCnt() + 1L);
            }
        }
    	return result;
    }
    //메인화면 접속시 로그인 되어있으면 파이썬에 아이디 넘기기 위해 db에 넣기
    public void userIdInsert(String user) {
    	userMapper.deleteUserActivity();
    	userMapper.userIdInsert(user);
    }
    //사용자에게 추천할 행사 정보 리스트
    public List<EventVO> recomendEvent(String user) {
    	
        List<UserActivityVO> recomendList = userMapper.selectRecommend(user);
        List<EventVO> eventList = new ArrayList<>(); // 이벤트 리스트 생성
        
        for (UserActivityVO recomend : recomendList) {
            if (recomend.getEno() != null && recomend.getEno() != 0L) { // 조건 수정
                EventVO event = eventMapper.eventDetail(recomend.getEno());
                event.setEtype(recomend.getType());
                if (event != null) {
                    eventList.add(event); // 이벤트를 리스트에 추가
                }
            } 
        }
        
        return eventList; // 리스트 반환
    }
    //상용자에게 추천할 행사 정보 리스트
    public List<RestaurantVO> recomendRest(String user){
    	List<UserActivityVO> recomendList = userMapper.selectRecommend(user);
    	List<RestaurantVO> restList = new ArrayList<>();
    	
    	for(UserActivityVO recomend : recomendList) {
    		if(recomend.getFno() != null && recomend.getFno() != 0L) {
    			RestaurantVO rest = restMapper.restaurantDetail(recomend.getFno());
    			System.out.println("_______________________________"+restMapper.restaurantDetail(recomend.getFno()));
    			System.out.println("_______________________________"+rest);
    			rest.setType(recomend.getType());
    			if(rest != null) {
    				restList.add(rest);
    			}
    		}
    	}
    	return restList;
    }
    public Map<String, Long> getNewUserCountByDate() {
        // UserActivityVO 리스트 가져오기
        List<Date> activities = userMapper.selectNewUserForCnt();
        System.out.println("88888888888888888888888888888888888" + activities);
        // 날짜별 개수를 저장할 맵
        Map<String, Long> dateCountMap = new HashMap<>();
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd"); // 날짜 형식 정의
        
        // activities 리스트가 비어있는지 체크
        if (activities == null || activities.isEmpty()) {
            System.out.println("No user activities found.");
            return dateCountMap; // 빈 맵 반환
        }

        // regDate를 기준으로 개수 세기
        for (Date activity : activities) {
            if (activity != null) { // activity가 null인지 확인
                Date regDate = activity;
                if (regDate != null) {
                    String formattedDate = dateFormat.format(regDate); // 날짜 포맷팅
                    dateCountMap.put(formattedDate, dateCountMap.getOrDefault(formattedDate, 0L) + 1);
                    System.out.println("+++++++++++++++++++++++++++++++"+formattedDate);
				} /*
					 * else {
					 * 
					 * System.out.println("Activity regDate is null for activity: " + activity); }
					 */
            } else {
            	
            }
        }

        
        return dateCountMap; // 날짜별 개수 반환
    }

    //오늘 신규 회원 수 조회
    public Long getTodayNewUserCount() {
    	return userMapper.todayNewUser();
    }
    
    
    
}

