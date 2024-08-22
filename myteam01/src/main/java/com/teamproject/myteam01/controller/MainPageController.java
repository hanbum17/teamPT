package com.teamproject.myteam01.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;


import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/admin")
public class MainPageController {

	@GetMapping("/main")
	public String main() {
		return "admin_main/adminMain" ;
	}

//	@GetMapping("/map")
//	public String main2() {
//		return "KaKaoTest" ;
//	}
	
}
