package com.teamproject.myteam01.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.teamproject.myteam01.domain.EventReviewVO;
import com.teamproject.myteam01.domain.EventVO;
import com.teamproject.myteam01.domain.RestaurantVO;
import com.teamproject.myteam01.domain.RestaurantsReviewVO;

public interface EventMapper {

	//록귀
	public EventVO eventDetail(Long eno);

	public List<EventReviewVO> selectReviews(Long eno, int pageNum);
	public int registerReview(EventReviewVO eventReviewVO);
	public int copyReview(Long erno);
	public int deleteReview(Long erno);
	public List<String> selectEHOST();
	public void updateEventCoord(EventVO event);

	//영범
	public List<EventReviewVO> selectReviews2(Long eno);
	public int updaterestreview(EventReviewVO eventReviewVO);
	public List<EventReviewVO> selectMoreReviews(EventReviewVO reviewVO);
	public List<Long> selectReviewsForStar(Long eno);
	public List<EventVO> selectRegDate();
	public List<EventVO> selectRecentEvent();
	public Long selectRegEventForCnt();
	
	//희준
	//행사 목록
	public List<EventVO> selectEventList();
	public List<EventVO> selectEventList2(EventVO eventVO);
	//행사 등록
	public Integer registerEvent(EventVO event);
	
	//행사 조회
	public EventVO selectEvent(Long eno);
	
	//행사 수정
	public int updateEvent(EventVO event);

	//행사 삭제
	public int delEvent(Long eno);
	
	//행사 조회수 증가
	public void updateEviewsCnt(Long eno);
	
	public List<EventVO> selectEventListByGuName(@Param("guName") String guName, @Param("offset") Long offset, @Param("pageSize") Long pageSize);
	
	
	
	
	
}
