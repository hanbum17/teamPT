package com.teamproject.myteam01.controller;

import java.util.List;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.teamproject.myteam01.domain.EventVO;
import com.teamproject.myteam01.domain.RestaurantsReviewVO;
import com.teamproject.myteam01.service.EventService;
import com.teamproject.myteam01.service.RestaurantService;

import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api")
public class VroomRestController {

    
    private final EventService eventService;
    private final RestaurantService restService;
    
    @GetMapping("/events")
    public List<EventVO> getEvents() {
        return eventService.eventList();
    }

//    @GetMapping("/reviews")
//    public String getEventReviews() {
//    	List<EventReviewVO> eventReviews = eventService.selectReviews();
//    }
    
    @GetMapping("/eventsPage")
    public String getEventsPage(Model model) {
        try {
            List<EventVO> events = eventService.eventList();
            String eventsJson = new ObjectMapper().writeValueAsString(events);
            System.out.println("Serialized JSON: " + eventsJson); // 직렬화된 JSON 로그
            model.addAttribute("eventsJson", eventsJson);
            return "vroom/vroomEvent"; // JSP 파일 이름
        } catch (JsonProcessingException e) {
            e.printStackTrace();
            System.out.println("Serialized JSON: 오류");
            return "error"; // 오류가 발생한 경우에 대한 처리
        }
    }
    
    //test
//  	@GetMapping("/getRestaurantReviews2")
//  	@ResponseBody
//  	public List<RestaurantsReviewVO> getRestaurantReviews2(@RequestParam("fno") Long fno,
//  														   @RequestParam("page") Long page,
//  														   @RequestParam("pageSize") Long pageSize,
//  														   Model model) {
//  		List<RestaurantsReviewVO> reviews = restService.selectReviews(fno);
//  	    return reviews;
//  	}

    @GetMapping("/getRestaurantReviews")
    public List<RestaurantsReviewVO> getRestaurantReviews2( @RequestParam Long fno,
            												@RequestParam Long page,
            												@RequestParam Long pageSize) {
        
        RestaurantsReviewVO restReviewVO = new RestaurantsReviewVO();
        restReviewVO.setFno(fno);
        restReviewVO.setPage(page);
        restReviewVO.setPageSize(pageSize);
        // 데이터 조회 로직
        List<RestaurantsReviewVO> reviews = restService.selectMoreReviews(restReviewVO);
        
        return reviews;
    }


}
