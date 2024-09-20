
package com.teamproject.myteam01.service;

import com.teamproject.myteam01.domain.UserVO;
import com.teamproject.myteam01.mapper.UserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class UserService {

	 @Autowired
    private UserMapper userMapper;
	 
	 
	 
	 private PasswordEncoder passwordEncoder() {
	        return new BCryptPasswordEncoder();
	    }

    // PasswordEncoder를 바로 호출
    public void registerUser(UserVO user) {
        String encodedPassword = passwordEncoder().encode(user.getUserPw());
        user.setUserPw(encodedPassword);
        userMapper.insertUser(user);
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
        return userMapper.findByUsername(userId);
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
}

