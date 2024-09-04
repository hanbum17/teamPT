package com.teamproject.myteam01.controller;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.teamproject.myteam01.domain.EventReviewVO;
import com.teamproject.myteam01.domain.EventVO;
import com.teamproject.myteam01.domain.RestaurantVO;
import com.teamproject.myteam01.domain.RestaurantsReviewVO;
import com.teamproject.myteam01.domain.UserVO;
import com.teamproject.myteam01.service.EventService;
import com.teamproject.myteam01.service.RestaurantService;
import com.teamproject.myteam01.service.UserService;

import io.swagger.v3.oas.annotations.parameters.RequestBody;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/vroom")
public class VroomController {


	public final RestaurantService restService;
	public final UserService userService;
    private final EventService eventService;

    @GetMapping("/main")
    public String main() {
        return "vroom/vroomMain";
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
	    RestaurantVO detail = restService.restaurantDetail(fno);
	    detail.setReivewsList(restService.selectReviews(fno)); // 리뷰 리스트를 세팅
	    return detail;
	}

//삭제예정
//	@GetMapping("/getRestaurantReviews")
//	@ResponseBody
//	public List<RestaurantsReviewVO> getRestaurantReviews(@RequestParam("fno") Long fno, Model model) {
//	    List<RestaurantsReviewVO> reviews = restService.selectReviews(fno);
//	    return reviews;
//	}
	

	@GetMapping("/getRestaurantReviews")
	@ResponseBody
	public List<RestaurantsReviewVO> getRestaurantReviews(@RequestParam("fno") Long fno, Model model) {
	    List<RestaurantsReviewVO> reviews = restService.selectReviews(fno);
	    System.out.println("리뷰리스트 : "+reviews);
	    return reviews;
	}

	
	@PostMapping("/restregisterReview")
	@ResponseBody
	public Map<String, Object> restregisterReview(@RequestBody RestaurantsReviewVO restReviewVO) {
	    Map<String, Object> response = new HashMap<>();
	    try {
	        restService.registerReview(restReviewVO);
	        response.put("success", true);
	        response.put("message", "리뷰가 성공적으로 등록되었습니다.");
	    } catch (Exception e) {
	        response.put("success", false);
	        response.put("message", "리뷰 등록 중 오류가 발생했습니다.");
	    }
	    return response;
	}


	
	@PostMapping("/updateReview")
	@ResponseBody
	public Map<String, Object> updateReview(RestaurantsReviewVO review) {
	    Map<String, Object> response = new HashMap<>();
	    try {
	        List<RestaurantsReviewVO> result = restService.modifyreview(review);
	        response.put("success", true);
	        response.put("message", "리뷰가 성공적으로 수정되었습니다.");
	        response.put("data", result);
	    } catch (Exception e) {
	        response.put("success", false);
	        response.put("message", "리뷰 수정에 실패했습니다.");
	        e.printStackTrace(); // 로그에 에러 출력
	    }
	    return response;
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
	

	
//	@GetMapping("/event")
//	public String vroomEvent() {
//		return "vroom/vroomEvent";
//	}



	@GetMapping("/event")
	public String vroomEvent(Model model) {
	    List<EventVO> events = eventService.eventList();
	    try {
	        String eventsJson = new ObjectMapper().writeValueAsString(events);
	        model.addAttribute("eventsJson", eventsJson);
	        return "vroom/vroomEvent";
	    } catch (JsonProcessingException e) {
	        e.printStackTrace();
	        return "error";
	    }
	}


    @GetMapping("/api/events")
    @ResponseBody
    public List<EventVO> getEvents() {
        return eventService.eventList();
    }

    @GetMapping("/api/events/{eno}")
    @ResponseBody
    public EventVO eventDetail(@PathVariable Long eno) {
        return eventService.eventDetail(eno);
    }

    @GetMapping("/api/events/{eno}/reviews")
    @ResponseBody
    public List<EventReviewVO> getEventReviews(@PathVariable Long eno) {
        return eventService.selectReviews2(eno);
    }
}
