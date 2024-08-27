package com.teamproject.myteam01.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/cs")
@Tag(name = "CsController", description = "Customer Service")
public class CsController {

    @GetMapping("/Center")
    public String csCenter() {
        return "csCenter"; // 고객센터 메인 페이지
    }

    @GetMapping("/inquiry")
    public String inquiry() {
        return "inquiry"; // 문의사항 페이지
    }

    @GetMapping("/faq")
    public String faq() {
        return "faq"; // 자주 묻는 질문 페이지
    }

    @GetMapping("/feedback")
    public String feedback() {
        return "feedback"; // 고객의 소리 페이지
    }

}


