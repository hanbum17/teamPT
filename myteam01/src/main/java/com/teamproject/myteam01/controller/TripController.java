package com.teamproject.myteam01.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
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
import java.util.Map;

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

    // 여행 세부 계획 보기 (tripDay로 필터링)
    @GetMapping("/trip/detail/{tripNo}")
    public String getTripPlanDetail(@PathVariable("tripNo") Long tripNo,
                                    @RequestParam(value = "day", required = false, defaultValue = "1") Integer tripDay,
                                    Model model, @AuthenticationPrincipal UserDetails userDetails) {
        TripPlanVO tripPlan = tripService.getTripPlan(tripNo);
        
        // 전체 장소 가져오기 (tripDay와 관계없이 모든 장소)
        List<TripPlaceVO> allPlaces = tripService.getTripPlacesByTripNo(tripNo);
        
        // 특정 tripDay에 해당하는 일정만 가져오기
        List<TripPlaceVO> daySpecificPlaces = tripService.getPlacesByTripNoAndDay(tripNo, tripDay);

        model.addAttribute("tripPlan", tripPlan);
        model.addAttribute("places", allPlaces);  // 모든 장소
        model.addAttribute("daySpecificPlaces", daySpecificPlaces);  // tripDay에 맞는 일정
        model.addAttribute("tripDay", tripDay);  // 현재 tripDay
        model.addAttribute("userId", userDetails.getUsername());
        
        return "user_main/user_menu/user_trip_detail";
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
    public ResponseEntity<String> saveSchedule(@RequestBody List<TripPlaceVO> schedule) {
        try {
            // schedule 객체 출력해보기 (디버깅용)
            schedule.forEach(place -> System.out.println(place.toString()));
            
            tripService.saveTripSchedule(schedule);
            return ResponseEntity.ok("일정이 성공적으로 저장되었습니다.");
        } catch (Exception e) {
            e.printStackTrace();  // 예외 스택 트레이스 출력
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("일정 저장에 실패했습니다.");
        }
    }
    
    @PostMapping("/trip/excludeSchedule")
    public ResponseEntity<String> excludeSchedule(@RequestBody Map<String, Object> requestData) {
        try {
            Long tripPlaceId = Long.valueOf(requestData.get("tripPlaceId").toString());
            Integer orderNum = Integer.valueOf(requestData.get("orderNum").toString());
            Long tripNo = Long.valueOf(requestData.get("tripNo").toString());
            Integer tripDay = Integer.valueOf(requestData.get("tripDay").toString());

            // 일정 제외 처리 로직 수행 (tripDay, startDate, orderNum을 null로 설정)
            tripService.excludeTripSchedule(tripPlaceId, tripNo, orderNum, tripDay);
            
            return ResponseEntity.ok("일정 제외가 성공적으로 처리되었습니다.");
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                                 .body("일정 제외에 실패했습니다.");
        }
    }
}
