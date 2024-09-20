package com.teamproject.myteam01.mapper;

import com.teamproject.myteam01.domain.TripPlanVO;
import com.teamproject.myteam01.domain.TripPlaceVO;
import com.teamproject.myteam01.domain.TripRegisteredPlaceVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.time.LocalTime;
import java.util.List;

@Mapper
public interface TripMapper {

    // 여행 계획 저장
    void insertTripPlan(TripPlanVO tripPlan);
    
	// 여행 계획 삭제
    void deleteTripPlan(Long tripNo);
    void deleteTripPlacesByTripNo(Long tripNo);
    void deleteRegisteredPlacesByTripNo(Long tripNo);

    // 여행 계획 수정
    void updateTripPlan(TripPlanVO existingTripPlan);

    // 사용자 ID로 여행 계획 목록 조회
    List<TripPlanVO> selectTripPlansByUserId(String userId);

    // 특정 여행 계획 조회
    TripPlanVO selectTripPlan(Long tripNo);

    // 여행 계획에 속한 장소 목록 조회
    List<TripRegisteredPlaceVO> selectRegisteredPlacesByTripNo(Long tripNo);

    // 특정 tripNo와 tripDay에 해당하는 장소 리스트 가져오기
    List<TripPlaceVO> getPlacesByTripNoAndDay(Long tripNo, Integer tripDay);

    // 장소 등록 (trip_registered_places 테이블)
    void insertRegisteredPlace(TripRegisteredPlaceVO place);

    // 여행 계획에 장소 추가 (trip_places 테이블)
    void insertTripPlace(TripPlaceVO place);

    // 장소 삭제
    void deletePlaceById(Long placeId);

    // 일정에 대한 정보를 업데이트하는 메서드
    void updateSchedule(TripPlaceVO place);
    void insertSchedule(TripPlaceVO place);
    
    // 일정 조회 (id와 startDate로 일정이 이미 존재하는지 확인)
    TripPlaceVO selectScheduleByIdAndStartDate(@Param("id") Long id, @Param("startDate") LocalTime localTime);

    // 일정의 tripDay, startDate, orderNum을 null로 설정
    void deleteScheduleById(Long tripPlaceId);

    // 제외된 일정 이후의 일정들의 orderNum을 재정렬
    void updateOrderNumsAfterExclusion(@Param("tripNo") Long tripNo, 
                                       @Param("tripDay") Integer tripDay, 
                                       @Param("orderNum") Integer orderNum);
}
