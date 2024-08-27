package com.teamproject.myteam01.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.teamproject.myteam01.domain.EventVO;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/vroom")
public class VroomController {

	//Vroom의 메인페이지
	@GetMapping("/main")
	public String main() {
		return "vroom/vroomMain" ;
	}
	
	@GetMapping("/event")
	public String vroomEvent() {
		return "vroom/vroomEvent";
	}
	
	@PostMapping("/event/data")
	public List<EventVO> vroomEventData(){
		
		
		
		return null;
	}
	
}
