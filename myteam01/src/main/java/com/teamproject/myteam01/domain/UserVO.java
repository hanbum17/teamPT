package com.teamproject.myteam01.domain;

import java.sql.Timestamp;
import java.util.Collection;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class UserVO implements UserDetails {
    private Long userNo;
    private String userId;
    private String userPw;
    private String userName;
    private char userGender;
    private String userCall;
    private String userAddress;
    private String userEmail;
    private int userType;
    private int accountStatus; // 0: 활성화, 1: 비활성화
    private Timestamp joinDate; 
    private Timestamp lastLoginDate; 
    private List<String> roles; 

    // Spring Security의 UserDetails에서 제공하는 메서드
    @Override
    public boolean isEnabled() {
        return accountStatus == 0; // 0이면 계정이 활성화됨
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return roles.stream()
                .map(role -> new SimpleGrantedAuthority("ROLE_" + role))
                .collect(Collectors.toList());
    }

    @Override
    public String getUsername() {
        return this.userId;
    }

    @Override
    public String getPassword() {
        return this.userPw;
    }
}
