package com.teamproject.myteam01.security;


import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import com.teamproject.myteam01.service.UserService;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;

import java.io.IOException;

@Component
@RequiredArgsConstructor
public class CustomAuthenticationSuccessHandler implements AuthenticationSuccessHandler {

    private final UserService userService;

    
    	
    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
                                        Authentication authentication) throws IOException, ServletException {
    	System.out.println("onAuthenticationSuccess triggered"); 
        String userId = authentication.getName();

        System.out.println("User ID: " + userId);
        // 로그인 성공 시 마지막 로그인 날짜 업데이트
        userService.updateLastLoginDate(userId);
        System.out.println("Last login date updated for: " + userId);
        // 기본 성공 페이지로 리다이렉트
        response.sendRedirect("/list");
    }
}
