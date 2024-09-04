package com.teamproject.myteam01.service;

import com.teamproject.myteam01.domain.UserRegistrationVO;
import com.teamproject.myteam01.mapper.UserRegistrationMapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserRegistrationService {

    @Autowired
    private UserRegistrationMapper userRegistrationMapper;


    
    public List<Map<String, Object>> getUserRegistrations(String userId) {
        return userRegistrationMapper.findUserRegistrationsByUserId(userId);
    }
    
    public void registerUserEvent(String userId, Long eventId) {
        Map<String, Object> registration = new HashMap<>();
        registration.put("userId", userId);
        registration.put("itemId", eventId);
        registration.put("itemType", "EVENT");
        userRegistrationMapper.insertUserRegistration(registration);
    }


    public void registerUserRestaurant(String userId, Long restaurantId) {
        Map<String, Object> registration = new HashMap<>();
        registration.put("userId", userId);
        registration.put("itemId", restaurantId);
        registration.put("itemType", "RESTAURANT");
        userRegistrationMapper.insertUserRegistration(registration);
    }
}