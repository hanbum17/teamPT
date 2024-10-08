package com.teamproject.myteam01.controller;

import java.util.Collection;
import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.GrantedAuthority;
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

import com.teamproject.myteam01.domain.EventReviewVO;
import com.teamproject.myteam01.domain.EventVO;
import com.teamproject.myteam01.service.EventService;
import com.teamproject.myteam01.service.UserRegistrationService;

import io.swagger.v3.oas.annotations.parameters.RequestBody;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;

@Tag(name = "EventController", description = "Event")
@Controller
@RequiredArgsConstructor
@RequestMapping("/event")
public class EventController {

	private final EventService eventService ;
    private final UserRegistrationService userRegistrationService;
	
	//테스트
	@GetMapping("/test")
	public String test() {
//		for(EventVO event : eventList) {
//			eventService.updateEventCoord(event);
//		}
		return "test" ;
	}
	
	
//	@PostMapping("updateEventCoord")
//	@ResponseBody
//	public ResponseEntity<Void> updateEventCoord(@RequestParam(value = "list") List<EventVO> list) {
//		System.out.println("updateEventCoord 컨트롤러 실행됨");
//		System.out.println(list);
//		List<EventVO> eventList = eventService.eventList();
//		
//		for(EventVO event : eventList) {
//			eventService.updateEventCoord(event);
//		}
//		return new ResponseEntity<> (HttpStatus.OK);
//	}
	
	//록귀 파트
	@GetMapping("/detail")
	public String eventDetail(@RequestParam("eno")Long eno, Model model, 
							  @RequestParam(value = "pageNum", defaultValue = "1") int pageNum) {
		EventVO event = eventService.eventDetail(eno);
		if(event != null) {
			model.addAttribute("Event", event);
			model.addAttribute("PageNum", pageNum);
			model.addAttribute("Reviews", eventService.selectReviews(eno, pageNum));
			return "event/eventDetail";
		} else {
			return "redirect:/list";
		}
	}
	
	@GetMapping("/reviews/{pageNum}")
	public ResponseEntity<List<EventReviewVO>> pagingReviews(Long eno, @PathVariable("pageNum") int pageNum){
		List<EventReviewVO> reviews = eventService.selectReviews(eno, pageNum);
		return new ResponseEntity<> (reviews, HttpStatus.OK);
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
	
    // 행사 등록 - 처리
	@PostMapping("/register")
	public String regiEvent(EventVO event, RedirectAttributes redirAttr, @AuthenticationPrincipal UserDetails userDetails) {
	    System.out.println("컨트롤러 : 이벤트 등록 처리" + event);

	    // 사용자 권한에 따라 etype 값을 설정
	    Collection<? extends GrantedAuthority> authorities = userDetails.getAuthorities();
	    
	    if (authorities.stream().anyMatch(auth -> auth.getAuthority().equals("ROLE_ADMIN"))) {
	        event.setEtype("0"); // 관리자일 경우 etype을 0으로 설정
	    } else if (authorities.stream().anyMatch(auth -> 
	                auth.getAuthority().equals("ROLE_USER") || auth.getAuthority().equals("ROLE_BUSINESS"))) {
	        event.setEtype("1"); // USER나 BUSINESS일 경우 etype을 1로 설정
	    } else {
	        // 기본적으로 USER나 BUSINESS로 간주하여 etype을 1로 설정
	        event.setEtype("1");
	    }

	    // 이벤트 등록 로직
	    Long eno = eventService.regiEvent(event);
	    System.out.println("등록된 이벤트 eno : " + eno);

	    // USER_REGISTRATIONS 테이블에 등록
	    userRegistrationService.registerUserEvent(userDetails.getUsername(), eno);

	    redirAttr.addAttribute("result", eno);

	    return "redirect:/event/list";
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
