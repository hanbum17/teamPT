package com.teamproject.myteam01.security;

import com.teamproject.myteam01.domain.UserVO;
import com.teamproject.myteam01.mapper.UserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class CustomUserDetailsService implements UserDetailsService {

    private final UserMapper userMapper;

    @Autowired
    public CustomUserDetailsService(UserMapper userMapper) {
        this.userMapper = userMapper;
    }

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        UserVO user = userMapper.findByUsername(username);

        if (user == null) {
            throw new UsernameNotFoundException("User not found with username: " + username);
        } 

        // 계정이 비활성화된 상태인지 확인
        if (user.getAccountStatus() == 1) { // 1은 비활성화된 상태라고 가정
            throw new DisabledException("회원탈퇴한 계정입니다. 관리자에게 문의해주세요.");
        }

        // 권한 정보를 데이터베이스에서 조회하여 UserVO 객체에 설정
        List<String> roles = userMapper.findRolesByUserId(user.getUserId());
        user.setRoles(roles);

        // UserVO의 roles를 GrantedAuthority 리스트로 변환
        List<GrantedAuthority> authorities = roles.stream()
                .map(role -> new SimpleGrantedAuthority("ROLE_" + role))
                .collect(Collectors.toList());

        // UserDetails 객체로 변환하여 반환
        return org.springframework.security.core.userdetails.User.builder()
                .username(user.getUserId())
                .password(user.getUserPw()) // 암호화된 비밀번호
                .authorities(authorities) // 권한 설정
                .build();
    }

}
