package com.teamproject.myteam01.service;

import com.teamproject.myteam01.mapper.UserRegistrationMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class UserRegistrationService {

    @Autowired
    private UserRegistrationMapper userRegistrationMapper;

    // 특정 사용자의 등록된 행사 및 음식점 정보를 조회
    public List<Map<String, Object>> getUserRegistrations(String userId) {
        return userRegistrationMapper.findUserRegistrationsByUserId(userId);
    }
    
    // 사용자가 작성한 행사 리뷰 조회 (userId로)
    public List<Map<String, Object>> getUserEventReviewsByUserId(String userId) {
        return userRegistrationMapper.getUserEventReviewsByUserId(userId);
    }

    // 사용자가 작성한 음식점 리뷰 조회 (userId로)
    public List<Map<String, Object>> getUserRestaurantReviewsByUserId(String userId) {
        return userRegistrationMapper.getUserRestaurantReviewsByUserId(userId);
    }

    // 사용자의 행사 등록
    public void registerUserEvent(String userId, Long eventId) {
        Map<String, Object> registration = new HashMap<>();
        registration.put("userId", userId);
        registration.put("itemId", eventId);
        registration.put("itemType", "EVENT");
        userRegistrationMapper.insertUserRegistration(registration);
    }

    // 사용자의 음식점 등록
    public void registerUserRestaurant(String userId, Long restaurantId) {
        Map<String, Object> registration = new HashMap<>();
        registration.put("userId", userId);
        registration.put("itemId", restaurantId);
        registration.put("itemType", "RESTAURANT");
        userRegistrationMapper.insertUserRegistration(registration);
    }
}
