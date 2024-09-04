package com.teamproject.myteam01.controller;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.teamproject.myteam01.domain.EventReviewVO;
import com.teamproject.myteam01.domain.EventVO;
import com.teamproject.myteam01.domain.RestaurantVO;
import com.teamproject.myteam01.domain.RestaurantsReviewVO;
import com.teamproject.myteam01.service.EventService;
import com.teamproject.myteam01.service.RestaurantService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/vroom")
public class VroomController {

    private final RestaurantService restService;
    private final EventService eventService;

    @GetMapping("/main")
    public String main() {
        return "vroom/vroomMain";
    }



	
	@GetMapping("/restaurant")
	public String restMain(Model model) {
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
	

	
	@PostMapping("/restregisterReview")
	public String restregisterReview(Model model, RestaurantsReviewVO restReviewVO) {
		restService.registerReview(restReviewVO);
		return "redirect:/vroom/restaurant";
	}



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
