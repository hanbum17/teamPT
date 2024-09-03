package com.teamproject.myteam01.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.teamproject.myteam01.domain.CsVO;
import com.teamproject.myteam01.service.CsService;

import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/cs")
@Tag(name = "CsController", description = "Customer Service")
public class CsController {
	
	private final CsService csService ;
	
	/*
	 * @GetMapping("/Center") 
	 * public String CsCenter() { return "csCenter"; }
	 */
	
	
	  @GetMapping("/Center") 
	  public String csList(Model model) {
		  model.addAttribute("CsList", csService.csList()); 
		  return "csCenter";
	  }
	 

    
	//고객센터의 FAQ 등록 페이지를 반환하는 메서드
    @GetMapping("/register")
    public String showFaqRegisterForm() {
        return "CsRegister"; // 
    }

    // 고객센터의 FAQ 등록 요청을 처리하는 메서드
    @PostMapping("/registerProc")
    public String regiFAQ(CsVO faq) {
    	System.out.println("컨트롤러: FAQ 등록 처리" + faq); 
        csService.regiFAQ(faq);
        return "redirect:/cs/Center"; // 등록 후 고객센터 메인 페이지로 리다이렉트
    }
}//end



