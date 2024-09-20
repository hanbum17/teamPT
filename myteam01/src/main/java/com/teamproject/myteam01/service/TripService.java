package com.teamproject.myteam01.service;

import com.teamproject.myteam01.domain.TripPlanVO;
import com.teamproject.myteam01.domain.TripPlaceVO;
import com.teamproject.myteam01.domain.TripRegisteredPlaceVO;
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
    
    @Transactional
    public void deleteTripPlanAndDetails(Long tripNo) {
        // 1. 여행 계획에 속한 장소들 삭제
        tripMapper.deleteTripPlacesByTripNo(tripNo);

        // 2. 여행 계획에 등록된 장소 삭제
        tripMapper.deleteRegisteredPlacesByTripNo(tripNo);

        // 3. 여행 계획 삭제
        tripMapper.deleteTripPlan(tripNo);
    }

    public void updateTrip(Long tripNo, TripPlanVO updatedTripPlan) {
        // DB에서 해당 여행 계획을 가져와서 수정
        TripPlanVO existingTripPlan = tripMapper.selectTripPlan(tripNo);
        
        if (existingTripPlan != null) {
            existingTripPlan.setTitle(updatedTripPlan.getTitle());
            existingTripPlan.setStartDate(updatedTripPlan.getStartDate());
            existingTripPlan.setEndDate(updatedTripPlan.getEndDate());
            
            // 여행 계획 업데이트
            tripMapper.updateTripPlan(existingTripPlan);
        }
    }
    
    
    

    public List<TripRegisteredPlaceVO> getRegisteredPlacesByTripNo(Long tripNo) {
        return tripMapper.selectRegisteredPlacesByTripNo(tripNo);
    }


    public List<TripPlaceVO> getPlacesByTripNoAndDay(Long tripNo, int tripDay) {
        return tripMapper.getPlacesByTripNoAndDay(tripNo, tripDay);
    }

    @Transactional
    public void addRegisteredPlace(TripRegisteredPlaceVO place) {
        tripMapper.insertRegisteredPlace(place);
    }

    public void addPlaceToTrip(TripPlaceVO place) {
        tripMapper.insertTripPlace(place);
    }

    public void deletePlace(Long placeId) {
        tripMapper.deletePlaceById(placeId);
    }

    @Transactional
    public void saveTripSchedule(List<TripPlaceVO> schedule) {
        for (TripPlaceVO place : schedule) {
            // id와 startDate로 일정이 존재하는지 확인
            TripPlaceVO existingPlace = tripMapper.selectScheduleByIdAndStartDate(place.getId(), place.getStartDate());
            
            if (existingPlace != null) {
                // 일정이 존재하면 업데이트
                tripMapper.updateSchedule(place);
            } else {
                // 일정이 존재하지 않으면 삽입
                tripMapper.insertSchedule(place);
            }
        }
    }

    
    @Transactional
    public void deleteSchedule(Long tripPlaceId, Long tripNo, Integer orderNum, Integer tripDay) {
        tripMapper.deleteScheduleById(tripPlaceId);
        
        tripMapper.updateOrderNumsAfterExclusion(tripNo, tripDay, orderNum);
    }

}
