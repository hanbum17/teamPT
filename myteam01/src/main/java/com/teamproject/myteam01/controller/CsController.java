package com.teamproject.myteam01.controller;

import java.util.List;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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

        model.addAttribute("FAQList", csService.csList()); // FAQ 목록
        model.addAttribute("feedbackList", csService.csFBList()); // 고객의 소리 목록
        model.addAttribute("inquiryList", csService.csInList()); // 1:1 문의 내역 목록
        return "csCenter";
    }

    @GetMapping("/register")
    public String showFaqRegisterForm() {
        return "CsRegister";
    }

 // 문의/건의사항 등록 처리
    @PostMapping("/registerProc")
    public String regiFAQ(@RequestParam(value = "type") String type, CsVO csvo, @AuthenticationPrincipal UserDetails userDetails, RedirectAttributes redirectAttributes) {
        String userId = userDetails.getUsername(); // 로그인된 사용자의 ID 가져오기
        csvo.setUserid(userId); // 문의나 건의사항에 USERID 추가

        if ("faq".equals(type)) {
            csService.regiFAQ(csvo);
        } else if ("feedback".equals(type)) {
            csService.regiFB(csvo); // 고객의 소리 등록
        } else if ("inquiry".equals(type)) {
            csService.regiIn(csvo); // 1:1 문의 등록
        }
        
        redirectAttributes.addFlashAttribute("message", "등록이 성공적으로 완료되었습니다.");
        return "redirect:/cs/Center";
    }

    @GetMapping("/edit")
    public String showCsEditForm(@RequestParam(value = "type") String type, @RequestParam(value = "faqno", required = false) Long faqno, 
                                 @RequestParam(value = "fbno", required = false) Long fbno, 
                                 @RequestParam(value = "ino", required = false) Long ino, Model model) {
        CsVO cs = null;

        if ("faq".equals(type) && faqno != null) {
            cs = csService.getFAQ(faqno);
        } else if ("feedback".equals(type) && fbno != null) {
            cs = csService.getFB(fbno);
        } else if ("inquiry".equals(type) && ino != null) {
            cs = csService.getIn(ino);
        }

        model.addAttribute("cs", cs);
        model.addAttribute("type", type);
        return "CsEdit";
    }

    @PostMapping("/editProc")
    public String editProc(@RequestParam("type") String type, CsVO cs) {
        boolean success = false;
        
        if ("faq".equals(type)) {
            success = csService.modifyFAQ(cs);
        } else if ("feedback".equals(type)) {
            success = csService.modifyFB(cs);
        } else if ("inquiry".equals(type)) {
            success = csService.modifyIn(cs);
        }

        if (success) {
            return "redirect:/cs/Center"; // 수정 성공 시
        } else {
            // 수정 실패 시 타입에 따라 리다이렉트
            if ("faq".equals(type)) {
                return "redirect:/cs/edit?faqno=" + cs.getFaqno();
            } else if ("feedback".equals(type)) {
                return "redirect:/cs/edit?fbno=" + cs.getFbno();
            } else if ("inquiry".equals(type)) {
                return "redirect:/cs/edit?ino=" + cs.getIno();
            }
        }
        return "redirect:/cs/Center"; // 기본 리다이렉트 (예외 처리)
    }


    @PostMapping("/deleteProc")
    public String deleteProc(@RequestParam("type") String type, @RequestParam("no") Long no) {
        if (type.equals("faq")) {
            csService.removeFAQ(no);
        } else if (type.equals("feedback")) {
            csService.removeFB(no);
        } else if (type.equals("inquiry")) {
            csService.removeIn(no);
        }
        return "redirect:/cs/Center"; // 삭제 후 리다이렉트
    }


} //end


