package com.teamproject.myteam01.service;

import com.teamproject.myteam01.domain.TripPlanVO;
import com.teamproject.myteam01.domain.TripPlaceVO;
import com.teamproject.myteam01.mapper.TripMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class TripService {

    @Autowired
    private TripMapper tripMapper;

    public void saveTripPlan(TripPlanVO tripPlan) {
        tripMapper.insertTripPlan(tripPlan);
    }

    public List<TripPlanVO> getTripPlansByUserId(String userId) {
        return tripMapper.selectTripPlansByUserId(userId);
    }

    public TripPlanVO getTripPlan(Long tripNo) {
        return tripMapper.selectTripPlan(tripNo);
    }

    public List<TripPlaceVO> getTripPlacesByTripNo(Long tripNo) {
        return tripMapper.selectTripPlacesByTripNo(tripNo);
    }
    
    public List<TripPlaceVO> getPlacesByTripNoAndDay(Long tripNo, int tripDay) {
        return tripMapper.getPlacesByTripNoAndDay(tripNo, tripDay);
    }

    public void addPlace(TripPlaceVO place) {
        tripMapper.insertPlace(place);
    }
    
    public void deletePlace(Long placeId) {
        tripMapper.deletePlaceById(placeId);
    }

    @Transactional  // 이 메서드에서 트랜잭션이 관리됨
    public void saveTripSchedule(List<TripPlaceVO> schedule) {
        for (TripPlaceVO place : schedule) {
            tripMapper.updatePlaceOrderAndDay(place);
        }
    }
    
    @Transactional
    public void excludeTripSchedule(Long tripPlaceId, Long tripNo, Integer orderNum, Integer tripDay) {
        // 일정의 tripDay, startDate, orderNum을 null로 설정
        tripMapper.updateScheduleToNull(tripPlaceId);

        // 제거된 일정의 orderNum에 따라 나머지 일정들의 순서를 재정렬
        tripMapper.updateOrderNumsAfterExclusion(tripNo, tripDay, orderNum);
    }
}
