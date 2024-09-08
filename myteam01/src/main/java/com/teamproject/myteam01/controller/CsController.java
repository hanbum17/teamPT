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

    @GetMapping("/Center")
    public String csList(Model model) {
        model.addAttribute("CsList", csService.csList());
        return "csCenter";
    }

    @GetMapping("/register")
    public String showFaqRegisterForm() {
        return "CsRegister";
    }

    @PostMapping("/registerProc")
    public String regiFAQ(CsVO faq) {
        csService.regiFAQ(faq);
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


}
