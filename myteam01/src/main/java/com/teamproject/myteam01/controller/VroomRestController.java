package com.teamproject.myteam01.controller;

import java.util.List;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.teamproject.myteam01.domain.EventVO;
import com.teamproject.myteam01.domain.RestaurantVO;
import com.teamproject.myteam01.domain.RestaurantsReviewVO;
import com.teamproject.myteam01.domain.UserVO;
import com.teamproject.myteam01.service.EventService;
import com.teamproject.myteam01.service.RestaurantService;
import com.teamproject.myteam01.service.UserService;

import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api")
public class VroomRestController {

	public final UserService userService;
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
    public List<RestaurantsReviewVO> getRestaurantReviews( @RequestParam Long fno,
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

    //스크롤시 추가 데이터 보내기
    @GetMapping("/restaurant")
    public List<RestaurantVO> restMain(@AuthenticationPrincipal UserDetails userDetails, 
                           @RequestParam(value = "page", defaultValue = "1") Long page, 
                           @RequestParam(value = "pageSize", defaultValue = "12") Long pageSize,
                           Model model) {
        // 현재 로그인된 사용자의 ID를 이용해 사용자 정보 조회
        if (userDetails != null) {
            String userId = userDetails.getUsername();
            UserVO user = userService.findByUsername(userId);
            model.addAttribute("user", user);
        }
        System.out.println("테스트1");
        // 식당 목록 추가
        List<RestaurantVO> restList = restService.getRestList(page, pageSize);
        

        return restList ;
    }
    
    

}
