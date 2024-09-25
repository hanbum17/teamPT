package com.teamproject.myteam01.controller;

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
import org.springframework.web.bind.annotation.RequestMapping;

import com.teamproject.myteam01.domain.EventVO;
import com.teamproject.myteam01.domain.RestaurantVO;
import com.teamproject.myteam01.domain.UserVO;
import com.teamproject.myteam01.service.EventService;
import com.teamproject.myteam01.service.RestaurantService;
import com.teamproject.myteam01.service.UserService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/admin")
public class MainPageController {

	@Autowired
	private UserService userService ;
	@Autowired
	private EventService eventService ;
	@Autowired
	private RestaurantService restService;
	
	//파이썬 추천 테스트
	@GetMapping("/mypage")
	public String test(@AuthenticationPrincipal UserDetails userDetails, Model model) {
		String userName = userDetails.getUsername();
		model.addAttribute("userName",userName);
		
		//행사 추천 리스트
		List<EventVO> eventList = userService.recomendEvent(userName);
		model.addAttribute("eventList",eventList);
		
		//식당 추천 리스트
		List<RestaurantVO> restList = userService.recomendRest(userName);
		model.addAttribute("restList",restList);
		
		//행사 추천 타입 ex) 지역추천 , 무료추천
		if(!eventList.isEmpty()) {
			EventVO eRecoType = eventList.get(0);
			model.addAttribute("eRecoType",eRecoType.getEtype());
		}
		
		//식당 추천 타입 ex) 지역추천 , 무료추천
		if(!restList.isEmpty()) {
			RestaurantVO fRecoType = restList.get(0);
			model.addAttribute("fRecoType",fRecoType.getType());
		}
		return "admin_main/pythonTest";
	}
	

	
	@GetMapping("/main")
	public String main() {
		return "admin_main/adminMain" ;
	}

	
	//오래걸리는건 db에서 가져올 때 모든 날짜를 가져오기 때문에 버퍼링이 걸린다.
	@GetMapping("/data")
	public String data(Model model) {
		
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
		
		//최근 등록된 댓글 10개 보류;
		
		return "admin_main/adminData";
	}
	
//	@GetMapping("/map")
//	public String main2() {
//		return "KaKaoTest" ;
//	}
	
}
