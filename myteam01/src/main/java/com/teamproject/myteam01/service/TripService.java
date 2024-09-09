package com.teamproject.myteam01.service;

import com.teamproject.myteam01.domain.TripPlanVO;
import com.teamproject.myteam01.domain.TripPlaceVO;
import com.teamproject.myteam01.mapper.TripMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
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

    public void addPlace(TripPlaceVO place) {
        tripMapper.insertPlace(place);
    }

    public void saveSchedule(List<TripPlaceVO> schedule) {
        for (TripPlaceVO place : schedule) {
            tripMapper.updatePlaceOrder(place);
        }
    }
}
