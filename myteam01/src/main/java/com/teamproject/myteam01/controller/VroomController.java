package com.teamproject.myteam01.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.teamproject.myteam01.domain.RestaurantVO;
import com.teamproject.myteam01.domain.RestaurantsReviewVO;
import com.teamproject.myteam01.service.RestaurantService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/vroom")
public class VroomController {
	
	public final RestaurantService restService;

	//Vroom의 메인페이지
	@GetMapping("/main")
	public String main() {

		return "vroom/vroomMain" ; 
	}
	

	
	@GetMapping("/restaurant")
	public String restMain(Model model) {
		model.addAttribute("restList", restService.getRestList());
		return "main_restaurant";
	}
	
	@GetMapping("/getRestaurantDetails")
	@ResponseBody
	public RestaurantVO getRestaurantDetail(@RequestParam("fno") Long fno,Model model) {
	    System.out.println("전달된 fno 값: " + fno); 
	    RestaurantVO detail = restService.restaurantDetail(fno);
	    model.addAttribute("Reviews", restService.selectReviews(fno));
	    System.out.println("컨트롤러 값 확인"+ detail);
	    return detail;
	}
	
	@PostMapping("/restregisterReview")
	public String restregisterReview(Model model, RestaurantsReviewVO restReviewVO) {
		restService.registerReview(restReviewVO);
		System.out.println("리뷰컨트롤러에 전달된 값: "+restReviewVO);
		return "redirect:/vroom/restaurant";
	}

	
	
	
	@GetMapping("/event")
	public String vroomEvent() {
		return "vroom/vroomEvent";

	}
	
	
}
