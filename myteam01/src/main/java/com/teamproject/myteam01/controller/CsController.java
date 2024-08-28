package com.teamproject.myteam01.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

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
		  System.out.println("컨트롤러: 고객센터 메인 페이지"); 
		  model.addAttribute("CsList", csService.csList()); 
		  return "csCenter";
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


