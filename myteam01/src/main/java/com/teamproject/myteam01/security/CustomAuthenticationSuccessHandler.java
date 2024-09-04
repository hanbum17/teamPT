package com.teamproject.myteam01.security;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import com.teamproject.myteam01.service.UserService;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;

import java.io.IOException;
import java.util.Set;

@Component
@RequiredArgsConstructor
public class CustomAuthenticationSuccessHandler implements AuthenticationSuccessHandler {

    private final UserService userService;

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
                                        Authentication authentication) throws IOException, ServletException {
        String userId = authentication.getName();

        // 로그인 성공 시 마지막 로그인 날짜 업데이트
        userService.updateLastLoginDate(userId);

        // 사용자의 권한을 가져옴
        Set<String> roles = AuthorityUtils.authorityListToSet(authentication.getAuthorities());

        // 사용자 권한에 따라 리다이렉트할 페이지 설정
        if (roles.contains("ROLE_ADMIN")) {
            response.sendRedirect("/admin/main");
        } else if (roles.contains("ROLE_USER") || roles.contains("ROLE_BUSINESS")) {
            response.sendRedirect("/user/userMain");
        } else {
            // 기본 성공 페이지로 리다이렉트 (혹은 에러 페이지로 보낼 수 있음)
            response.sendRedirect("/vroom/main");
        }
    }
}
