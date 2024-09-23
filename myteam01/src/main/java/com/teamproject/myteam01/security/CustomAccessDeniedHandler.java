package com.teamproject.myteam01.security;

import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.web.access.AccessDeniedHandler;
import org.springframework.stereotype.Component;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@Component
public class CustomAccessDeniedHandler implements AccessDeniedHandler {

    @Override
    public void handle(HttpServletRequest request, HttpServletResponse response, AccessDeniedException accessDeniedException) throws IOException, ServletException {
        // 메시지와 함께 로그인 페이지로 리다이렉트
        request.getSession().setAttribute("errorMessage", "이미 로그인된 계정입니다.");
        response.sendRedirect("/user/main");  // 원하는 페이지로 리다이렉트 (예: 메인 페이지)
    }
}
