package com.teamproject.myteam01.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.teamproject.myteam01.domain.EventVO;
import com.teamproject.myteam01.service.EventService;

import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;

@Tag(name = "EventController", description = "Event")
@Controller
@RequiredArgsConstructor
@RequestMapping("/event")
public class EventController {

	private final EventService eventService ;
	
	
	
	
	
	//________________________록귀 파트
	
//	@GetMapping("/detail")
//	public String eventDetail(@RequestParam("eno")String eno, Model model) {
//		model.addAttribute("Event", eventService.eventDetail(eno));
//		System.out.println(eventService.eventDetail(eno));
//		return "eventDetail";
//	}
	
	
	
	
	
	
	
	
	
	//_________________________희준 파트
	//행사 목록
	@GetMapping("/list")
	public void viewEventList(Model model) {
		System.out.println("컨트롤러 : 이벤트 리스트 호출");
		model.addAttribute("eventList", eventService.eventList());
	}
	
	//행사 등록 - 호출
	@GetMapping("/register")
	public void EventRegister() {
		System.out.println("컨트롤러 : 이벤트 등록 페이지 호출");
	}
	
	//행사 등록 - 처리
	@PostMapping("/register")
	public String regiEvent(EventVO event, RedirectAttributes redirAttr) {
		System.out.println("컨트롤러 : 이벤트 등록 처리" + event);
		
		Long eno = eventService.regiEvent(event);
		System.out.println("등록된 이벤트 eno : " + eno);
		
		redirAttr.addAttribute("result", eno);
		
		return "redirect:/event/list" ;
	}
	
	//행사 수정 - 호출
	@GetMapping("/modify")
	public void modiEvent(Long eno, Model model) {
		System.out.println("컨트롤러 : 이벤트 수정 페이지 호출");
		model.addAttribute("event", eventService.getEvent(eno));
		System.out.println("컨트롤러 : 화면 밖으로 전달할 모델 " + model);
	}
	
	//행사 수정 - 처리
	@PostMapping("/modify")
	public String modifyEvent(EventVO event, RedirectAttributes redirAttr) {
		System.out.println("컨트롤러 : 이벤트 수정 처리");
		
		if (eventService.modifyEvent(event)) {
			redirAttr.addFlashAttribute("result", "수정 성공");
		}
		return "redirect:/event/list?bno=" + event.getEno();
	}
	
	//행사 삭제
	@PostMapping("/remove")
	public String removeEvent(Long eno, RedirectAttributes redirAttr) {
		System.out.println("컨트롤러 : 이벤트 삭제 처리" + eno + "번 행사");
		
		if(eventService.removeEvent(eno)) {
			redirAttr.addFlashAttribute("result", "삭제 성공");
		}
		return "redirect:/event/list";
	}
		
		
}
