package com.teamproject.myteam01.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/vroom")
public class VroomController {

	//Vroom의 메인페이지
	@GetMapping("/main")
	public String main() {
		return "vroom/vroomMain" ; //테스트(삭제안되어있으면 해당 주석 삭제해주세용22)
	}
	
	@GetMapping("/festivalList")
	public String festivalList() {
		return "vroom/festivalList" ;
	}
	
}
