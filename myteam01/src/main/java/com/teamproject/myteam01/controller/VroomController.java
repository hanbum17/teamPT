package com.teamproject.myteam01.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
    public String restMain(@AuthenticationPrincipal UserDetails userDetails, Model model) {
        // 현재 로그인된 사용자의 ID를 이용해 사용자 정보 조회
        if (userDetails != null) {
            String userId = userDetails.getUsername();
            UserVO user = userService.findByUsername(userId);
            model.addAttribute("user", user);
        }
        
        // 식당 목록 추가
        model.addAttribute("restList", restService.getRestList());

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
	
	@PostMapping("/updateReview")
    public String updateReview(RestaurantsReviewVO review, RedirectAttributes redirectAttributes) {
        int result = restService.modifyreview(review);

        return "redirect:/vroom/restaurant"; 
    }



	 
	 @PostMapping("/deleteReview")
	    @ResponseBody
	    public Map<String, Object> deleteReview(@RequestParam Long frno) {
	        Map<String, Object> result = new HashMap<>();
	        try {
	            int deleteResult = restService.deleteReview(frno);
	            if (deleteResult > 0) {
	                result.put("success", true);
	            } else {
	                result.put("success", false);
	            }
	        } catch (Exception e) {
	            result.put("success", false);
	            result.put("message", e.getMessage());
	        }
	        return result;
	    }
	 
	 @GetMapping("/reviews/{fno}")
	 public String getReviews(@PathVariable("fno") Long fno, Model model, @AuthenticationPrincipal UserDetails userDetails) {
	     List<RestaurantsReviewVO> reviews = restService.selectReviews(fno);
	     model.addAttribute("reviews", reviews);

	     String userId = userDetails.getUsername();
	     Integer roleId = userService.findUserRoleId(userId); // roleId가 Integer형이라고 가정
	     boolean isAdmin = roleId != null && roleId == 1;
	     model.addAttribute("isAdmin", isAdmin);

	     return "reviews/reviewList";
	 }
	
	


	 


	
	
	
	@GetMapping("/event")
	public String vroomEvent() {
		return "vroom/vroomEvent";

	}
	
	
}
