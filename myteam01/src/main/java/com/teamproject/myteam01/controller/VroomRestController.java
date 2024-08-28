package com.teamproject.myteam01.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.teamproject.myteam01.domain.EventReviewVO;
import com.teamproject.myteam01.domain.EventVO;
import com.teamproject.myteam01.service.EventService;

@RestController
@RequestMapping("/api")
public class VroomRestController {

    @Autowired
    private EventService eventService;

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




}
