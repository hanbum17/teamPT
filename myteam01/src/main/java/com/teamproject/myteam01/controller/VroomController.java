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
    public String main(@AuthenticationPrincipal UserDetails userDetails, Model model) {
    	
    	boolean user;
    	
    	if (userDetails != null) {
            user = true;
    		model.addAttribute("user", user);
             // 로그인된 사용자에게 보여줄 페이지
        } else {
        	user = false;
        	model.addAttribute("user", user);
        }
        return "vroom/vroomMain";
    }

    @GetMapping("/restaurant/details")
    public String restaurantDetails(@RequestParam("fno") Long fno, Model model, @AuthenticationPrincipal UserDetails userDetails) {
        RestaurantVO restaurant = restService.restaurantDetail(fno);
        restaurant.setReivewsList(restService.selectReviews(fno));
        model.addAttribute("restaurant", restaurant);
        if (userDetails != null) {
            String userId = userDetails.getUsername();
            UserVO user = userService.findByUsername(userId);
            model.addAttribute("user", user);
        }
        return "restaurantDetails";
    }



    @GetMapping("/restaurant")
    public String restMain(@AuthenticationPrincipal UserDetails userDetails, @RequestParam(required = false) String guName, Model model) {
        boolean userBoolean;
        
        // 현재 로그인된 사용자의 ID를 이용해 사용자 정보 조회
        if (userDetails != null) {
            userBoolean = true;
            String userId = userDetails.getUsername();
            UserVO user = userService.findByUsername(userId);
            model.addAttribute("user", user);
            model.addAttribute("userBoolean", userBoolean);
        } else {
            userBoolean = false;
            model.addAttribute("userBoolean", userBoolean);
        }
        
        // 식당 목록 추가
        Long restPage = 0L; // 0-based offset
        Long restPageSize = 10L;

        List<RestaurantVO> restList;
        
        // Map으로 파라미터 묶기
        Map<String, Object> params = new HashMap<>();
        params.put("guName", guName);
        params.put("offset", restPage);
        params.put("pageSize", restPageSize);

        if (guName != null && !guName.isEmpty()) {
            // 특정 구의 식당 목록을 가져옴
            restList = restService.getRestListByGuName(params);
        } else {
            // 전체 식당 목록을 가져옴
            restList = restService.getRestList(restPage, restPageSize);
        }

        model.addAttribute("restList", restList);
        System.out.println("컨트롤러에 전달된 restaurantList 값: " + restList);
        System.out.println("전달받은 guName: " + guName);
        

        return "restaurantList";
    }



	
	
    @GetMapping("/getRestaurantDetails")
    @ResponseBody
    public RestaurantVO getRestaurantDetail(@RequestParam("fno") Long fno) {
        RestaurantVO detail = restService.restaurantDetail(fno);
        detail.setReivewsList(restService.selectReviews(fno));
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
    public String eventMain(@AuthenticationPrincipal UserDetails userDetails,  Model model) {
        
    	boolean userBoolean;
    	
    	if (userDetails != null) {
    		userBoolean = true;
    		model.addAttribute("userBoolean", userBoolean);
             // 로그인된 사용자에게 보여줄 페이지
        } else {
        	userBoolean = false;
        	model.addAttribute("userBoolean", userBoolean);
        }
    	// 현재 로그인된 사용자의 ID를 이용해 사용자 정보 조회
        if (userDetails != null) {
            String userId = userDetails.getUsername();
            UserVO user = userService.findByUsername(userId);
            model.addAttribute("user", user);
        }
        
        // 식당 목록 추가
        Long restPage = 1L;
        Long restPageSize = 10L;
        List<EventVO> eventList = eventService.getEventList(restPage, restPageSize);
        model.addAttribute("eventList", eventList);
        
        List<RestaurantVO> restList = restService.getRestList(restPage, restPageSize);

        return "vroom/vroomEvent";
    }

    
    @GetMapping("/getEventDetails")
    @ResponseBody
    public EventVO getEventDetails(@RequestParam("eno") Long eno) {
    	EventVO detail = eventService.eventDetail(eno);
        detail.setReviewsList(eventService.selectReviews2(eno));
        return detail;
    }

    
    @GetMapping("/event/details")
    public String eventDetails(@RequestParam("eno") Long eno, Model model, @AuthenticationPrincipal UserDetails userDetails) {
        
        EventVO event = eventService.eventDetail(eno);
        event.setReviewsList(eventService.selectReviews2(eno));
        model.addAttribute("event", event);
        
        
        
        if (userDetails != null) {
            String userId = userDetails.getUsername();
            UserVO user = userService.findByUsername(userId);
            model.addAttribute("user", user);
        }
        return "vroom/vroomEventDetail";
    }
	

	@PostMapping("/updateReviewEvent")
	@ResponseBody
	public Map<String, Object> updateReviewEvent(EventReviewVO review) {
	    Map<String, Object> response = new HashMap<>();
	    try {
	        List<EventReviewVO> result = eventService.modifyreview(review);
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
    

	@GetMapping("/getEventReviews")
	@ResponseBody
	public List<EventReviewVO> getEventReviews(@RequestParam("eno") Long eno, Model model) {
		List<EventReviewVO> reviews = eventService.selectReviews2(eno);
	    return reviews;
	}
	
	@PostMapping("/deleteReviewEvent")
	@ResponseBody
	public Map<String, Object> deleteReviewEvent(@RequestParam Long erno) {
	    Map<String, Object> result = new HashMap<>();
	    try {
	        int deleteResult = eventService.deleteReview(erno);
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
	
	@PostMapping("/eventregisterReview")
	@ResponseBody
	public Map<String, Object> eventregisterReview(@RequestBody EventReviewVO eventReviewVO) {
	    Map<String, Object> response = new HashMap<>();
	    try {
	        eventService.registerReview(eventReviewVO);
	        response.put("success", true);
	        response.put("message", "리뷰가 성공적으로 등록되었습니다.");
	    } catch (Exception e) {
	        response.put("success", false);
	        response.put("message", "리뷰 등록 중 오류가 발생했습니다.");
	    }
	    return response;
	}
	
	@GetMapping("/policy")
	public String getService() {
		return "vroom/vroomPolicy";
	}
	
	
	
	
}
