package com.teamproject.myteam01.controller;

import java.util.List;

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
import com.teamproject.myteam01.domain.UserVO;
import com.teamproject.myteam01.service.RestaurantService;
import com.teamproject.myteam01.service.UserService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/vroom")
public class VroomController {
	
	public final RestaurantService restService;
	public final UserService userService;

	//Vroom의 메인페이지
	@GetMapping("/main")
	public String main() {

		return "vroom/vroomMain" ; //테스트(삭제안되어있으면 해당 주석 삭제해주세용22)
	}
	

	
	@GetMapping("/restaurant")
	public String restMain(HttpSession session, Model model) {
	    // 세션에서 현재 로그인한 사용자 정보 가져오기
	    UserVO loggedInUser = (UserVO) session.getAttribute("loggedInUser");

	    // 로그인한 사용자 정보가 세션에 없다면 (로그인되지 않은 상태)
	    if (loggedInUser == null) {
	        // 로그인 페이지로 리다이렉트하거나 적절한 처리를 합니다.
	        return "redirect:/login";
	    }

	    // 레스토랑 목록을 가져와서 모델에 추가
	    model.addAttribute("restList", restService.getRestList());

	    // 로그인한 사용자 정보를 모델에 추가
	    model.addAttribute("loggedInUser", loggedInUser);

	    // JSP 페이지로 이동
	    return "main_restaurant";
	}
	
	@GetMapping("/getRestaurantDetails")
	@ResponseBody
	public RestaurantVO getRestaurantDetail(@RequestParam("fno") Long fno) {
	    System.out.println("전달된 fno 값: " + fno); 
	    RestaurantVO detail = restService.restaurantDetail(fno);
	    detail.setReivewsList(restService.selectReviews(fno)); // 리뷰 리스트를 세팅
	    System.out.println("컨트롤러 값 확인: " + detail);
	    return detail;
	}
	
	@GetMapping("/getRestaurantReviews")
	@ResponseBody
	public List<RestaurantsReviewVO> getRestaurantReviews(@RequestParam("fno") Long fno, Model model) {
	    List<RestaurantsReviewVO> reviews = restService.selectReviews(fno);
	    System.out.println("리뷰리스트 : "+reviews);
	    return reviews;
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
