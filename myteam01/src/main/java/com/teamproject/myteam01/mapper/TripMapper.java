package com.teamproject.myteam01.mapper;

import com.teamproject.myteam01.domain.TripPlanVO;
import com.teamproject.myteam01.domain.TripPlaceVO;
import org.apache.ibatis.annotations.Mapper;
import java.util.List;

@Mapper
public interface TripMapper {

    // 여행 계획 저장
    void insertTripPlan(TripPlanVO tripPlan);

    // 사용자 ID로 여행 계획 목록 조회
    List<TripPlanVO> selectTripPlansByUserId(String userId);

    // 특정 여행 계획 조회
    TripPlanVO selectTripPlan(Long tripNo);

    // 여행 계획에 속한 장소 목록 조회
    List<TripPlaceVO> selectTripPlacesByTripNo(Long tripNo);

    // 장소 추가
    void insertPlace(TripPlaceVO place);
    
    // 장소 삭제
    void deletePlaceById(Long placeId);

    // 장소 순서와 시간 업데이트
    void updatePlaceOrderAndDate(TripPlaceVO place);
}
