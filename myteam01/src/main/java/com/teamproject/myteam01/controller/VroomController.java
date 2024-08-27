package com.teamproject.myteam01.controller;


import java.io.File;
import java.io.IOException;
import java.nio.file.Files;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.teamproject.myteam01.service.RestaurantService;

import com.teamproject.myteam01.domain.EventVO;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/vroom")
public class VroomController {
	
	public final RestaurantService restService;

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
	public String vroomEvent() {
		return "vroom/vroomEvent";

	}
	
	@PostMapping("/event/data")
	public List<EventVO> vroomEventData(){
		
		
		
		return null;
	}
	
}
