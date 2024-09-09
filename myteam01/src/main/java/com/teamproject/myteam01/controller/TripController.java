package com.teamproject.myteam01.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.teamproject.myteam01.domain.TripPlaceVO;
import com.teamproject.myteam01.domain.TripPlanVO;
import com.teamproject.myteam01.service.TripService;

import java.util.List;

@Controller
@RequestMapping("/trip")
public class TripController {

    @Autowired
    private TripService tripService;

    // 여행 계획 저장
    @PostMapping("/saveTripPlan")
    public String saveTripPlan(@SessionAttribute("userId") String userId, TripPlanVO tripPlan) {
        tripPlan.setUserId(userId); // 사용자 ID 설정
        tripService.saveTripPlan(tripPlan);
        return "redirect:/user/user_trip"; // 저장 후 리스트 페이지로 리디렉션
    }

    // 여행 계획 리스트 페이지
    @GetMapping("/list")
    public String getTripPlans(Model model, @SessionAttribute("userId") String userId) {
        List<TripPlanVO> tripPlans = tripService.getTripPlansByUserId(userId);
        model.addAttribute("tripPlans", tripPlans);
        return "user_main/user_menu/user_trip_list"; // 여행 계획 리스트 페이지로 이동
    }

    // 여행 세부 계획 보기
    @GetMapping("/detail/{tripNo}")
    public String getTripPlanDetail(@PathVariable("tripNo") Long tripNo, Model model, @SessionAttribute("userId") String userId) {
        TripPlanVO tripPlan = tripService.getTripPlan(tripNo);
        List<TripPlaceVO> places = tripService.getTripPlacesByTripNo(tripNo);
        model.addAttribute("tripPlan", tripPlan);
        model.addAttribute("places", places);
        model.addAttribute("userId", userId);
        return "user_main/user_menu/user_trip_detail"; // 세부 여행 계획 페이지로 이동
    }
}
