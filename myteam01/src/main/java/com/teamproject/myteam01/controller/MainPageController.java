package com.teamproject.myteam01.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.HttpStatusCode;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.teamproject.myteam01.domain.UserVO;
import com.teamproject.myteam01.service.UserService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/admin")
public class MainPageController {

	final private UserService userService;
	
	@GetMapping("/main")
	public String main() {
		return "admin_main/adminMain";
	}

	@GetMapping("/manage/userList")
	@ResponseBody
	public ResponseEntity<List<UserVO>> userList() {
		List<UserVO> userList = new ArrayList<UserVO>(); 
		userList = userService.selectUserList();
		return new ResponseEntity<>(userList, HttpStatus.OK);
	}
	
	@GetMapping("/manage/userDetail")
	public String userDetail() {
		return "admin_main/manageUserDetail";
	}
	
	@PostMapping("/manage/userUpdate")
	public Integer userUpdate() {
		
		return null;
	}
	
	@PostMapping("/manage/userDelete")
	public Integer userDelete() {
		
		return null;
	}
	
//	@GetMapping("/map")
//	public String main2() {
//		return "KaKaoTest" ;
//	}
	
}
