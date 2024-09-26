package com.teamproject.myteam01.controller;

import java.util.ArrayList;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.teamproject.myteam01.domain.EventVO;
import com.teamproject.myteam01.domain.RestaurantVO;
import com.teamproject.myteam01.domain.UserVO;
import com.teamproject.myteam01.security.CustomUserDetailsService;
import com.teamproject.myteam01.service.EventService;
import com.teamproject.myteam01.service.RestaurantService;
import com.teamproject.myteam01.service.UserService;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/admin")
public class MainPageController {
	
	@Autowired
	private CustomUserDetailsService customUserService ;
	@Autowired
	private UserService userService ;
	@Autowired
	private EventService eventService ;
	@Autowired
	private RestaurantService restService;
	
	@GetMapping("/manage/adminUserManage")
	public String adminUserManage() {
		return "admin_main/adminUserManage";
	}
	@GetMapping("/manage/userList")
	@ResponseBody
	public ResponseEntity<List<UserVO>> userList() {
		List<UserVO> userList = userService.selectUserList();
		return new ResponseEntity<>(userList, HttpStatus.OK);
	}
	
	@GetMapping("/manage/userDetail")
	@ResponseBody
	public ResponseEntity<UserVO> userDetail(String userId) {
		UserVO userDetail = userService.findByUsername(userId); 
		return new ResponseEntity<>(userDetail, HttpStatus.OK);
	}
	
	@PostMapping("/manage/userUpdate")
	@ResponseBody
	public ResponseEntity<String> userUpdate(UserVO userVO) {
		System.out.println("userUpdate 정보: " + userVO);
		userService.updateUser(userVO);
		return new ResponseEntity<String>("수정되었습니다.", HttpStatus.OK);
	}
	
	
	//오래걸리는건 db에서 가져올 때 모든 날짜를 가져오기 때문에 버퍼링이 걸린다.
	@GetMapping("/main")
	public String main(Model model) {
		//성별 통계 남자수, 여자수
		UserVO user = userService.countGender();
		model.addAttribute("user" , user);
		
		//행사 등록 모든 날짜 조회 (행사 등록 개수 그래프)
		List<EventVO> eventRegDate = eventService.eventRegDate();
		model.addAttribute("eventRegDate" , eventRegDate);
		
		//행사 최신순 10개 조회(최근 등록한 행사글 조회)
		List<EventVO> event = eventService.recentEvent();
		model.addAttribute("recentEvents" , event);
		
		//식당 등록 모든 날짜 조회 (식당 등록 개수 그래프)
		List<RestaurantVO> restRegDate = restService.restRegDate();
		model.addAttribute("restRegDate",restRegDate);
		
		//식당 최신순 10개 조회 (최근 등록한 식당글 조회)
		List<RestaurantVO> rest = restService.recentRest();
		model.addAttribute("recentRestaurants",rest);
		
		return "admin_main/adminMain" ;
	}
	
}
