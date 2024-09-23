package com.teamproject.myteam01.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.teamproject.myteam01.domain.CsVO;
import com.teamproject.myteam01.service.CsService;

import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/cs")
@Tag(name = "CsController", description = "Customer Service")
public class CsController {
    
    private final CsService csService;

//    @GetMapping("/Center")
//    public String csList(Model model) {
//        model.addAttribute("CsList", csService.csList());
//        return "csCenter";
//    }
    
    @GetMapping("/Center")
    public String csList(Model model) {
        model.addAttribute("CsList", csService.csList()); // FAQ 목록

        model.addAttribute("feedbackList", csService.csFBList()); // 고객의 소리 목록

        model.addAttribute("inquiryList", csService.csInList()); // 1:1 문의 내역 목록

        return "csCenter";
    }


    @GetMapping("/register")
    public String showFaqRegisterForm() {
        return "CsRegister";
    }

//    @PostMapping("/registerProc")
//    public String regiFAQ(CsVO faq) {
//        csService.regiFAQ(faq);
//        return "redirect:/cs/Center";
//    }
    
    @PostMapping("/registerProc")
    public String regiFAQ(@RequestParam(value = "type") String type, CsVO csvo) {
        if ("faq".equals(type)) {
            csService.regiFAQ(csvo);
        } else if ("feedback".equals(type)) {
            csService.regiFB(csvo); // 고객의 소리 등록 메서드 추가
        } else if ("inquiry".equals(type)) {
            csService.regiIn(csvo); // 1:1 문의 등록 메서드 추가
        }
        return "redirect:/cs/Center";
    }

    
    @GetMapping("/edit")
    public String showFaqEditForm(@RequestParam("faqno") Long faqno, Model model) {
        CsVO faq = csService.getFAQ(faqno);
        model.addAttribute("faq", faq);
        return "CsEdit";
    }

    @PostMapping("/editProc")
    public String editFAQ(CsVO faq) {
        boolean success = csService.modifyFAQ(faq);
        return success ? "redirect:/cs/Center" : "redirect:/cs/edit?faqno=" + faq.getFaqno();
    }

 // 고객의 소리 목록 조회
 //   List<CsVO> feedbackList = csService.selectFeedbackList();
 //   model.addAttribute("feedbackList", feedbackList);

    // 1:1 문의 목록 조회
 //   List<CsVO> inquiryList = csService.selectInquiryList();
 //   model.addAttribute("inquiryList", inquiryList);


}
