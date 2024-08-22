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
		return "vroom/vroomMain" ;
	}
	
	@GetMapping("/restaurant")
	public String restMain() {
		return "main_restaurant";
	}
	
}
