package com.teamproject.myteam01.mapper;

import java.util.List;

import com.teamproject.myteam01.domain.RestaurantVO;
import com.teamproject.myteam01.domain.RestaurantsReviewVO;

public interface RestaurantMapper {

	//록귀
	public RestaurantVO restaurantDetail(Long fno);
	public List<RestaurantsReviewVO> selectReviews(Long fno);
	public int registerReview(RestaurantsReviewVO restReviewVO);
	public int copyReview(Long frno);
	public int deleteReview(Long frno);
	public String selectTitle(Long uno);
	//윤정
	public void insertRestaurant(RestaurantVO rest);
	public List<RestaurantVO> selectRestList();
	//영범
	public List<RestaurantsReviewVO> selectMoreReviews(RestaurantsReviewVO reviewVO);
	public List<Long> selectReviewsForStar(Long fno);
}
