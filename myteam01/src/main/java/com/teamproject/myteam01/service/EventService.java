package com.teamproject.myteam01.service;

import java.util.List;
import java.util.Map;

import com.teamproject.myteam01.domain.EventReviewVO;
import com.teamproject.myteam01.domain.EventVO;

public interface EventService {

	//록귀
	public EventVO eventDetail(Long eno);

	public List<EventReviewVO> selectReviews(Long eno, int pageNum);
	public int registerReview(EventReviewVO eventReviewVO);
	public int copyReview(Long erno);
	public int deleteReview(Long erno);
	public List<String> selectEHOST();
	public void updateEventCoord(EventVO event);

	//영범
	public List<EventReviewVO> selectReviews2 (Long rno);
	public List<EventReviewVO> modifyreview(EventReviewVO eventReviewVO);
	public List<EventVO> getEventList(Long page , Long pageSize);
	public List<EventReviewVO> selectMoreReviews(EventReviewVO eventReviewVO);
	public List<EventVO> eventRegDate();
	public List<EventVO> recentEvent();
	public Long regEventCnt();
	
	//희준
	//행사 목록
	public List<EventVO> eventList();
	//행사 등록
	public Long regiEvent(EventVO event);
	//행사 조회
	public EventVO getEvent(Long eno);
	//행사 수정
	public boolean modifyEvent(EventVO event);
	//행사 삭제
	public boolean removeEvent(Long eno);
	
	
	public List<EventVO> getEventListByGuName(Map<String, Object> params);

	
	
}
