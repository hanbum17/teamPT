package com.teamproject.myteam01.mapper;

import com.teamproject.myteam01.domain.TripPlanVO;
import com.teamproject.myteam01.domain.TripPlaceVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface TripMapper {

    void insertTripPlan(TripPlanVO tripPlan);

    List<TripPlanVO> selectTripPlansByUserId(String userId);

    TripPlanVO selectTripPlan(Long tripNo);

    List<TripPlaceVO> selectTripPlacesByTripNo(Long tripNo);

    void insertPlace(TripPlaceVO place);

    void updatePlaceOrder(TripPlaceVO place);
}
