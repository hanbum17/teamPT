package com.teamproject.myteam01.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface UserRegistrationMapper {

    // 사용자 등록 정보를 삽입하는 메서드
    void insertUserRegistration(Map<String, Object> registration);

    // 특정 사용자의 등록된 행사 및 음식점 정보를 조회하는 메서드
    List<Map<String, Object>> findUserRegistrationsByUserId(@Param("userId") String userId);

    // 사용자가 작성한 행사 리뷰를 조회하는 메서드 (userId로)
    List<Map<String, Object>> getUserEventReviewsByUserId(@Param("userId") String userId);

    // 사용자가 작성한 음식점 리뷰를 조회하는 메서드 (userId로)
    List<Map<String, Object>> getUserRestaurantReviewsByUserId(@Param("userId") String userId);
}
