package com.teamproject.myteam01.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
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
		
		//////////////////// 대시보드 요약 정보
		//오늘 신규회원 수
		Long todayNewCnt = userService.getTodayNewUserCount();
		model.addAttribute("todayNewCnt",todayNewCnt);
		
		//오늘 신규 식당글 등록 수
		Long todayNewRestCnt = restService.regRestCnt();
		model.addAttribute("todayNewRestCnt" ,todayNewRestCnt);
		
		//오늘 신규 행사글 등록 수
		Long todayNewEventCnt = eventService.regEventCnt();
		model.addAttribute("todayNewEventCnt",todayNewEventCnt);
		
		////////////////////그래프관련
		//신규회원 날짜별 가입 횟수
		Map<String,Long> dateWithCnt = userService.getNewUserCountByDate();
		model.addAttribute("dateWithCnt",dateWithCnt);
		
		
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
