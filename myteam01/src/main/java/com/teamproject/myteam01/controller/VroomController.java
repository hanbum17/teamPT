package com.teamproject.myteam01.controller;


import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.teamproject.myteam01.domain.EventVO;
import com.teamproject.myteam01.service.EventService;
import com.teamproject.myteam01.service.RestaurantService;

import lombok.RequiredArgsConstructor;



@Controller
@RequiredArgsConstructor
@RequestMapping("/vroom")
public class VroomController {
	
	public final RestaurantService restService;
	public final EventService eventService;
	
	//Vroom의 메인페이지
	@GetMapping("/main")
	public String main() {

		return "vroom/vroomMain" ; //테스트(삭제안되어있으면 해당 주석 삭제해주세용22)
	}
	

	
	@GetMapping("/restaurant")
	public String restMain(Model model) {
		model.addAttribute("restList", restService.getRestList());
		return "main_restaurant";
	}
	
	 @GetMapping("/event")
	    public String vroomEvent(Model model) {
	        List<EventVO> events = eventService.eventList();
	        model.addAttribute("eventsJson", new ObjectMapper().writeValueAsString(events));
	        return "vroom/vroomEvent";
	    }
	

	
//    @GetMapping("/event/data")
//    public String getEventData(Model model) {
//        List<EventVO> events = eventService.eventList();
//        model.addAttribute("events", events);
//        return "eventData"; // eventData.jsp (또는 Thymeleaf 템플릿)
//    }
	
}
