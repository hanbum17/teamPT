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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.teamproject.myteam01.domain.EventReviewVO;
import com.teamproject.myteam01.domain.EventVO;
import com.teamproject.myteam01.domain.RestaurantVO;
import com.teamproject.myteam01.domain.RestaurantsReviewVO;
import com.teamproject.myteam01.service.EventService;

import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;

@Tag(name = "EventController", description = "Event")
@Controller
@RequiredArgsConstructor
@RequestMapping("/event")
public class EventController {

	private final EventService eventService ;
	
	//테스트
	@GetMapping("/test")
	public String test() {
//		for(EventVO event : eventList) {
//			eventService.updateEventCoord(event);
//		}
		return "test" ;
	}
	
	@GetMapping("ehost")
	@ResponseBody
	public List<String> getEhost(Model model) {
		List<String> hostList = eventService.selectEHOST();
		model.addAttribute("hostList", hostList);
		return hostList;
	}
	
	
	@PostMapping("updateEventCoord")
	public ResponseEntity<Void> updateEventCoodr(@RequestParam("excoord")String excoord, @RequestParam("eycoord")String eycoord, @RequestParam("ehost")String ehost) {
		System.out.println("updateEventCoord 컨트롤러 실행됨");
		List<EventVO> eventList = eventService.eventList();
		
		for(EventVO event : eventList) {
			eventService.updateEventCoord(event);
		}
		return ResponseEntity.ok().build();
	}
	
	//록귀 파트
	@GetMapping("/detail")
	public String eventDetail(@RequestParam("eno")Long eno, Model model) {
		EventVO event = eventService.eventDetail(eno);
		if(event != null) {
			model.addAttribute("Event", event);
			model.addAttribute("Reviews", eventService.selectReviews(eno));
			return "event/eventDetail";
		} else {
			return "redirect:/list";
		}
		
	}
	
	@PostMapping("/registerReview")
	public String registerReview(Model model, EventReviewVO eventReview) {
		eventService.registerReview(eventReview);
		return "redirect:/event/detail?eno=" + eventReview.getEno() ;
	}
	
	@PostMapping("/deleteReview")
    @ResponseBody
    public String deleteReview(@RequestParam("erno") Long erno) {
		System.out.println("erno");
		eventService.copyReview(erno);
		eventService.deleteReview(erno);
        // 성공적인 처리 후 응답 메시지를 반환
        return "리뷰 삭제 처리 완료";  // 클라이언트에게 전송될 응답
    }
	
	
	
	
	
	
	
	//_________________________희준 파트
	
		
		
}
