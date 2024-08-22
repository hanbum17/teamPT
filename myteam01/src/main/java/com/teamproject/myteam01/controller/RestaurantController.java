package com.teamproject.myteam01.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.teamproject.myteam01.domain.AttachFileDTO;
import com.teamproject.myteam01.domain.RestaurantVO;
import com.teamproject.myteam01.domain.RestaurantsReviewVO;
import com.teamproject.myteam01.service.RestaurantService;

import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;

@Tag(name = "RestautantController", description = "Restautant")
@Controller
@RequiredArgsConstructor
@RequestMapping("/restaurant")
public class RestaurantController {

	private final RestaurantService restaurantService ;
	
	
	//록귀 파트
	@GetMapping("/detail")
	public String eventDetail(@RequestParam("fno")Long fno, Model model) {
		RestaurantVO restaurantVO = restaurantService.restaurantDetail(fno);
		if(restaurantVO != null) {
			model.addAttribute("Restaurant", restaurantVO);
			model.addAttribute("Reviews", restaurantService.selectReviews(fno));
			return "restaurantDetail";
		} else {
			return "redirect:/list";
		}
		
	}
	
	@PostMapping("/registerReview")
	public String registerReview(Model model, RestaurantsReviewVO restReviewVO) {
		restaurantService.registerReview(restReviewVO);
		return "redirect:/restaurant/detail?fno=" + restReviewVO.getFno() ;
	}
	
	@PostMapping("/deleteReview")
    @ResponseBody  // 이 어노테이션은 JSON이나 텍스트 데이터를 응답으로 보내기 위해 사용됩니다.
    public String deleteReview(@RequestParam("frno") Long frno) {
		restaurantService.copyReview(frno);
		restaurantService.deleteReview(frno);
        // 성공적인 처리 후 응답 메시지를 반환
        return "리뷰 삭제 처리 완료";  // 클라이언트에게 전송될 응답
    }
	
	//윤정 파트
		@GetMapping("/rest_register")
	    public String restaurantRegister() {
	        return "rest_register"; // JSP 페이지로 이동
	    }
		
		
		@PostMapping("/rest_register")
	    public String restaurantRegister(RestaurantVO rest, RedirectAttributes redirectAttr,AttachFileDTO attach) {
	        System.out.println("식당 등록 컨트롤러: " + rest);
	        List<AttachFileDTO> attachFileList=rest.getAttachFileList();
	        
	        if(attachFileList != null) {
	        	attachFileList.forEach(attachFile -> System.out.println("첨부파일 확인: "+attachFile.toString())) ;
	        }else {
	            System.out.println("controller:첨부파일 없음 ");
	        }

	        Long fno = restaurantService.registerRest(rest, attachFileList.get(0));
	        System.out.println("등록된 식당 번호: " + fno);
	        redirectAttr.addFlashAttribute("result", fno);
	        return "redirect:/restaurant/rest_register";
	    }
	
	
	
}
