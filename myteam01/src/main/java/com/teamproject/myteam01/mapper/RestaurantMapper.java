package com.teamproject.myteam01.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.teamproject.myteam01.domain.AttachFileDTO;
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
	public List<RestaurantVO> selectRestList(RestaurantVO restVO);

	public int updaterestreview(RestaurantsReviewVO restReviewVO);
	
	public List<RestaurantVO> selectRestListByGuName(@Param("guName") String guName, @Param("offset") Long offset, @Param("pageSize") Long pageSize);



	
	

	//영범
	public List<RestaurantsReviewVO> selectMoreReviews(RestaurantsReviewVO reviewVO);
	public List<Long> selectReviewsForStar(Long fno);

	public List<RestaurantVO> selectRegDate();
	public List<RestaurantVO> selectRecentRest();

	
}
