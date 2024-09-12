package com.teamproject.myteam01.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.teamproject.myteam01.domain.FavoriteItemVO;
import com.teamproject.myteam01.domain.TripPlaceVO;
import com.teamproject.myteam01.domain.TripPlanVO;
import com.teamproject.myteam01.service.FavoriteService;
import com.teamproject.myteam01.service.TripService;

import java.util.List;

@Controller
@RequestMapping("/user")
public class TripController {

    @Autowired
    private TripService tripService;
    
    @Autowired
    private FavoriteService favoriteService;

    // 여행 계획 저장
    @PostMapping("/trip/saveTripPlan")
    public String saveTripPlan(@AuthenticationPrincipal UserDetails userDetails, TripPlanVO tripPlan) {
        String userId = userDetails.getUsername();  
        tripPlan.setUserId(userId);               // 사용자 ID 설정
        tripService.saveTripPlan(tripPlan);       // 여행 계획 저장
        return "redirect:/user/trip/list";        // 여행 계획 목록 페이지로 리디렉션
    }

    // 여행 계획 리스트 페이지
    @GetMapping("/trip/list")
    public String getTripPlans(Model model, @AuthenticationPrincipal UserDetails userDetails) {
        List<TripPlanVO> tripPlans = tripService.getTripPlansByUserId(userDetails.getUsername());
        model.addAttribute("tripPlans", tripPlans);
        return "user_main/user_menu/user_trip_list";  // 여행 계획 리스트 페이지로 이동
    }

    // 여행 세부 계획 보기
    @GetMapping("/trip/detail/{tripNo}")
    public String getTripPlanDetail(@PathVariable("tripNo") Long tripNo, Model model, @AuthenticationPrincipal UserDetails userDetails) {
        TripPlanVO tripPlan = tripService.getTripPlan(tripNo);
        List<TripPlaceVO> places = tripService.getTripPlacesByTripNo(tripNo);
        
        
        model.addAttribute("tripPlan", tripPlan);
        model.addAttribute("places", places);
        model.addAttribute("userId", userDetails.getUsername());  // 로그인된 사용자 ID 추가
        return "user_main/user_menu/user_trip_detail";  // 세부 여행 계획 페이지로 이동
    }

    // 장소 추가
    @PostMapping("/trip/addPlace")
    public String addPlace(TripPlaceVO place) {
        tripService.addPlace(place);  // 장소 추가
        return "redirect:/user/trip/detail/" + place.getTripNo();  // 해당 여행 계획의 세부 페이지로 리디렉션
    }
    
    // 장소 삭제
    @PostMapping("/trip/deletePlace")
    public ResponseEntity<String> deletePlace(@RequestParam Long placeId) {
        tripService.deletePlace(placeId);  // 장소 삭제 처리
        return ResponseEntity.ok("삭제 완료");
    }

    // 일정 저장
    @PostMapping("/trip/saveSchedule")
    public String saveSchedule(@RequestBody List<TripPlaceVO> schedule) {
        tripService.saveSchedule(schedule);  // 일정 저장
        return "redirect:/user/trip/list";  // 목록 페이지로 리디렉션
    }
}
