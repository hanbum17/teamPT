package com.teamproject.myteam01.security;

import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationFailureHandler;
import org.springframework.stereotype.Component;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@Component
public class CustomAuthenticationFailureHandler extends SimpleUrlAuthenticationFailureHandler {

    @Override
    public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
                                        org.springframework.security.core.AuthenticationException exception)
            throws IOException, ServletException {

        // 예외 타입 및 메시지 확인
        System.out.println("Authentication failed: " + exception.getClass().getName() + " - " + exception.getMessage());

        if (exception instanceof BadCredentialsException) {
            request.getSession().setAttribute("error", "아이디 또는 비밀번호가 잘못되었습니다.");
        } else {
            request.getSession().setAttribute("error", "회원탈퇴한 계정입니다. 관리자에게 문의해주세요.");
        }

        // 로그인 페이지로 리다이렉트
        response.sendRedirect("/user/login");
    }
}
