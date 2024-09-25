package com.teamproject.myteam01.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.security.core.userdetails.UserDetails;

import com.teamproject.myteam01.domain.UserVO;

@Mapper
public interface UserMapper {
	
	List<UserVO> selectUserList();

    // 사용자의 ID로 사용자 정보를 조회
    UserVO findByUsername(String username);

    // 사용자의 ID로 역할(Role)을 조회
    List<String> findRolesByUserId(String userId);
    
    Integer findUserRoleId(String userId);

    // 사용자 정보를 데이터베이스에 삽입
    void insertUser(UserVO userVO);

    // 사용자 역할을 데이터베이스에 삽입
    void insertUserRole(@Param("userId") String userId, @Param("roleName") String roleName);

    // 사용자 계정의 활성화 상태를 업데이트
    void updateAccountStatus(@Param("userId") String userId, @Param("accountStatus") int accountStatus);

    // 마지막 로그인 날짜를 업데이트
    void updateLastLoginDate(String userId);
    
    // 사용자 비밀번호 업데이트
    void updateUserPassword(UserVO user);

    // 사용자 정보를 업데이트
    void updateUser(UserVO userVO);
    
    //영범 
    //성별 통계
    List<UserVO> userGenderCount();
    //신규회원 활동 저장
    void userRegisterActivity(UserVO userVO);
    //현재 로그인 정보 db에 저장 (파이썬넘기기위해)
    void deleteUserActivity();
    void userIdInsert(String user);
    
}
