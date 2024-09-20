package com.teamproject.myteam01.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.teamproject.myteam01.domain.TripRegisteredPlaceVO;
import com.teamproject.myteam01.domain.TripPlaceVO;
import com.teamproject.myteam01.domain.TripPlanVO;
import com.teamproject.myteam01.service.TripService;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/user")
public class TripController {

    @Autowired
    private TripService tripService;

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
    
    // 여행 계획 삭제
    @PostMapping("/trip/delete/{tripNo}")
    public ResponseEntity<String> deleteTripPlan(@PathVariable("tripNo") Long tripNo) {
        try {
            tripService.deleteTripPlanAndDetails(tripNo);
            return ResponseEntity.ok("여행 계획이 삭제되었습니다.");
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("여행 계획 삭제에 실패했습니다.");
        }
    }
    
    @PostMapping("/trip/update/{tripNo}")
    public ResponseEntity<String> updateTrip(@PathVariable("tripNo") Long tripNo, @RequestBody TripPlanVO updatedTrip) {
        try {
            // 업데이트 로직
            tripService.updateTrip(tripNo, updatedTrip);
            return ResponseEntity.ok("여행 계획이 성공적으로 수정되었습니다.");
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("여행 계획 수정에 실패했습니다.");
        }
    }

    
    

    // 여행 계획 세부 내용 보기
    @GetMapping("/trip/detail/{tripNo}")
    public String getTripPlanDetail(@PathVariable("tripNo") Long tripNo,
                                    @RequestParam(value = "day", required = false, defaultValue = "1") Integer tripDay,
                                    Model model, @AuthenticationPrincipal UserDetails userDetails) {
        TripPlanVO tripPlan = tripService.getTripPlan(tripNo);
        
        // 모든 장소 가져오기 (등록된 장소)
        List<TripRegisteredPlaceVO> allRegisteredPlaces = tripService.getRegisteredPlacesByTripNo(tripNo);
        
        // 특정 day에 해당하는 장소 가져오기
        List<TripPlaceVO> daySpecificPlaces = tripService.getPlacesByTripNoAndDay(tripNo, tripDay);
       

        model.addAttribute("tripPlan", tripPlan);
        model.addAttribute("places", allRegisteredPlaces);  // 전체 등록된 장소
        model.addAttribute("daySpecificPlaces", daySpecificPlaces);  // 해당 day의 장소
        model.addAttribute("tripDay", tripDay);

        return "user_main/user_menu/user_trip_detail"; 
    }

 // 장소 추가 (등록)
    @PostMapping("/trip/addPlace")
    public String addPlace(@ModelAttribute TripRegisteredPlaceVO place, RedirectAttributes redirectAttributes) {
        try {
            tripService.addRegisteredPlace(place);
            
            redirectAttributes.addFlashAttribute("message", "장소가 성공적으로 등록되었습니다.");
            return "redirect:/user/trip/detail/" + place.getTripNo();
        } catch (Exception e) {
            e.printStackTrace();
            
            redirectAttributes.addFlashAttribute("message", "장소 등록에 실패했습니다.");
            return "redirect:/user/trip/detail/" + place.getTripNo();
        }
    }
    
    // 등록된 장소 삭제
    @PostMapping("/trip/deletePlace")
    @ResponseBody
    public ResponseEntity<String> deletePlace(@RequestParam Long placeId) {
        try {
            tripService.deletePlace(placeId);  // 서비스 호출
            return ResponseEntity.ok("장소가 성공적으로 삭제되었습니다.");
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("장소 삭제에 실패했습니다.");
        }
    }
    
    // 즐겨찾기 목록에서 장소 선택 시 처리
    @PostMapping("/trip/favoritePlace")
    @ResponseBody
    public String addFavoritePlace(@RequestParam Long tripNo, @RequestParam String placeName, @RequestParam String address) {
    	TripRegisteredPlaceVO place = new TripRegisteredPlaceVO();
        place.setTripNo(tripNo);
        place.setPlaceName(placeName);
        place.setAddress(address);
        tripService.addRegisteredPlace(place);
        return "success";  // 성공 시 클라이언트로 메시지 반환
    }

    // 일정 저장
    @PostMapping("/trip/saveSchedule")
    public ResponseEntity<String> saveSchedule(@RequestBody List<TripPlaceVO> schedule) {
    	for (TripPlaceVO place : schedule) {
            System.out.println("받은 일정 정보: " + place);
        }
        try {
            tripService.saveTripSchedule(schedule);
            return ResponseEntity.ok("일정이 성공적으로 저장되었습니다.");
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("일정 저장에 실패했습니다.");
        }
    }
    

    
    // 일정 삭제
    @PostMapping("/trip/deleteSchedule")
    @ResponseBody
    public ResponseEntity<String> deleteSchedule(@RequestBody Map<String, Object> requestData) {
        try {
            Long tripPlaceId = Long.parseLong((String) requestData.get("tripPlaceId")); // String -> Long 변환
            Long tripNo = Long.parseLong((String) requestData.get("tripNo")); // String -> Long 변환
            Integer orderNum = Integer.parseInt((String) requestData.get("orderNum")); // String -> Integer 변환
            Integer tripDay = Integer.parseInt((String) requestData.get("tripDay")); // String -> Integer 변환

            tripService.deleteSchedule(tripPlaceId, tripNo, orderNum, tripDay);
            return ResponseEntity.ok("일정이 성공적으로 삭제되었습니다.");
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("일정 삭제에 실패했습니다.");
        }
    }

}
