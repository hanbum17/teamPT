package com.teamproject.myteam01.controller;

import com.teamproject.myteam01.domain.UserVO;
import com.teamproject.myteam01.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class UserController {

    @Autowired
    private UserService userService;

    @GetMapping("/user/register")
    public String showRegistrationForm() {
        return "user/register";
    }

    @PostMapping("/user/register")
    public String registerUser(UserVO user, Model model) {
        // 사용자 ID 중복 확인
        if (userService.isUserIdDuplicate(user.getUserId())) {
            model.addAttribute("error", "이미 사용 중인 ID입니다.");
            return "user/register";  // 회원가입 페이지로 다시 이동
        }

        userService.registerUser(user);
        model.addAttribute("message", "회원가입이 성공적으로 완료되었습니다.");
        return "redirect:/user/login";
    }

    @GetMapping("/user/login")
    public String showLoginForm() {
        return "user/login";
    }
    

}
