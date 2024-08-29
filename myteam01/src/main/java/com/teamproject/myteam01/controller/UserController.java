package com.teamproject.myteam01.controller;

import com.teamproject.myteam01.domain.UserVO;
import com.teamproject.myteam01.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class UserController {

    @Autowired
    private UserService userService;

    @GetMapping("/user/registerSelect")
    public String showRegisterSelectPage() {
        return "user/registerSelect";
    }
    
    @GetMapping("/user/register")
    public String showRegisterForm(@RequestParam("role") String role, Model model) {
        System.out.println("Received role: " + role);
        model.addAttribute("role", role);
        return "user/register";
    }

    @PostMapping("/user/register")
    public String registerUser(UserVO user, @RequestParam("role") String role, Model model) {
        // 사용자 ID 중복 확인
        if (userService.isUserIdDuplicate(user.getUserId())) {
            model.addAttribute("error", "이미 사용 중인 ID입니다.");
            return "user/register";  // 회원가입 페이지로 다시 이동
        }

        // 사용자 등록
        userService.registerUser(user);

        // 사용자 역할 설정
        userService.registerUserRole(user.getUserId(), role);
        
        model.addAttribute("message", "회원가입이 성공적으로 완료되었습니다.");
        return "redirect:/user/login";
    }

    @GetMapping("/user/login")
    public String showLoginForm() {
        return "user/login";
    }
    
    
    @GetMapping("/user/userMain")
    public String userPage(@AuthenticationPrincipal UserDetails userDetails, Model model) {
        // 현재 로그인된 사용자 정보를 모델에 추가할 수 있습니다.
        model.addAttribute("username", userDetails.getUsername());
        
        return "user_main/user_menu/user_detail";
    }
    
 // 사용자 상세 정보 페이지로 이동
    @GetMapping("/user/user_detail")
    public String userDetailPage() {
        return "user_main/user_menu/user_detail";
    }

    // 즐겨찾기 목록 페이지로 이동
    @GetMapping("/user/user_fav")
    public String userFavPage() {
        return "user_main/user_menu/user_fav_lists";
    }

    // 여행 계획 세우기 페이지로 이동
    @GetMapping("/user/user_trip")
    public String userTripPage() {
        return "user_main/user_menu/user_trip";
    }

    // 등록한 행사 및 음식점 페이지로 이동
    @GetMapping("/user/user_register")
    public String userRegisterPage() {
        return "user_main/user_menu/user_register";
    }

    // 등록한 리뷰 내역 페이지로 이동
    @GetMapping("/user/user_review")
    public String userReviewPage() {
        return "user_main/user_menu/user_review";
    }

    // 예약 내역 페이지로 이동
    @GetMapping("/user/user_reservation")
    public String userReservationPage() {
        return "user_main/user_menu/user_reservation";
    }

    // 결제 내역 페이지로 이동
    @GetMapping("/user/user_pay")
    public String userPayPage() {
        return "user_main/user_menu/user_pay";
    }

    // 문의 내역 페이지로 이동
    @GetMapping("/user/user_inquiry")
    public String userInquiryPage() {
        return "user_main/user_menu/user_inquiry";
    }

    // 비지니스 - 등록된 사업 정보 페이지로 이동 (ADMIN, BUSINESS 권한만)
    @GetMapping("/user/user_business")
    public String userBusinessPage(@AuthenticationPrincipal UserDetails userDetails) {
        if (userDetails.getAuthorities().stream()
                .anyMatch(auth -> auth.getAuthority().equals("ROLE_ADMIN") || auth.getAuthority().equals("ROLE_BUSINESS"))) {
            return "user_main/user_menu/user_business";
        }
        return "redirect:/accessDenied"; // 권한이 없는 경우 접근 불가 페이지로 리다이렉트
    }

    // 회원탈퇴 페이지로 이동 (또는 실제 회원탈퇴 처리)
    @GetMapping("/user/deleteAccount")
    public String deleteAccountPage() {
        return "user_main/user_menu/deleteAccount"; // 실제 회원탈퇴 로직은 서비스에서 처리
    }

}
