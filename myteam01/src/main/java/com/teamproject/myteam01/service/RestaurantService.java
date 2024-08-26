package com.teamproject.myteam01.service;

import java.util.List;

import com.teamproject.myteam01.domain.AttachFileDTO;
import com.teamproject.myteam01.domain.RestaurantVO;
import com.teamproject.myteam01.domain.RestaurantsReviewVO;

public interface RestaurantService {

	//록귀
	public RestaurantVO restaurantDetail(Long fno);
	public List<RestaurantsReviewVO> selectReviews(Long fno);
	public int registerReview(RestaurantsReviewVO restReviewVO);
	public int copyReview(Long frno);
	public int deleteReview(Long frno);
	
	//윤정
	public Long registerRest(RestaurantVO rest, AttachFileDTO attach);
	public List<RestaurantVO> getBoadList();
	
}
