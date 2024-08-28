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
    
    
    @GetMapping("/user/userPage")
    public String userPage(@AuthenticationPrincipal UserDetails userDetails, Model model) {
        // 현재 로그인된 사용자 정보를 모델에 추가할 수 있습니다.
        model.addAttribute("username", userDetails.getUsername());
        
        // userPage.jsp로 이동
        return "user_main/userPage";
    }

}
