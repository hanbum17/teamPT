package com.teamproject.myteam01.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.teamproject.myteam01.domain.EventReviewVO;
import com.teamproject.myteam01.domain.EventVO;
import com.teamproject.myteam01.domain.RestaurantsReviewVO;
import com.teamproject.myteam01.mapper.EventMapper;

import lombok.RequiredArgsConstructor;


@Service
@RequiredArgsConstructor
public class EventServiceImpl implements EventService{

	private final EventMapper eventMapper ;
	
	
	//영범 추가
	@Override
	public Long regEventCnt() {
		return eventMapper.selectRegEventForCnt();
	}
	
	@Override
	public List<EventReviewVO> selectMoreReviews(EventReviewVO eventReviewVO){
		Long offSet = (eventReviewVO.getPage()- 1 ) * eventReviewVO.getPageSize();
		eventReviewVO.setOffset(offSet);
		List<EventReviewVO> reviews = eventMapper.selectMoreReviews(eventReviewVO);
		List<Long> forStars = eventMapper.selectReviewsForStar(eventReviewVO.getEno());
		
		Double frRating = 0.0;
		Long count = 0L;
		if (forStars != null && !forStars.isEmpty()) {
			for (Long forStar : forStars) {
	            frRating += forStar;
	            count++;
	        }
			Double ratingAverage = frRating / count;
	        Double finalRatingAverage = Math.round(ratingAverage * 10) / 10.0;
	        
	     // 모든 리뷰 객체에 평균 평점과 리뷰 개수를 설정하기
	        for (EventReviewVO review : reviews) {
	            review.setRatingAverage(finalRatingAverage);
	            review.setErCount(count);
	        }
			
		}
		return reviews;
		
	}
	
	
	//록귀
	@Override
	public EventVO eventDetail(Long eno) {
		return eventMapper.eventDetail(eno);
	}
	
	@Override
	public List<EventReviewVO> selectReviews(Long eno, int pageNum) {
		return eventMapper.selectReviews(eno, pageNum);

	}
	
	//리뷰 가져오기 및 리뷰 갯수와 평균점수 구하기
	@Override
	public List<EventReviewVO> selectReviews2(Long eno) {
		List<EventReviewVO> reviews = eventMapper.selectReviews2(eno);
		Double frRating = 0.0;
	    Long count = 0L;
		EventReviewVO setRatingAverage = new EventReviewVO();
		
		if (reviews != null && !reviews.isEmpty()) {
			for(EventReviewVO review : reviews) {
				frRating += review.getErrating();
	            count++;
			}
			Double ratingAverage = frRating / count;
	        Double finalRatingAverage = Math.round(ratingAverage * 10) / 10.0;
			
	        for (EventReviewVO review : reviews) {
	            review.setRatingAverage(finalRatingAverage);
	            review.setErCount(count);
	        }
	        
	        return reviews;
		}
		
		return reviews;
	}
	@Override
	public List<EventReviewVO> modifyreview(EventReviewVO eventReviewVO) {
		System.out.println("리뷰 수정 서비스 값: "+eventReviewVO);
		eventMapper.updaterestreview(eventReviewVO);
		return null;
	}
	
	
	
	@Override
	public int registerReview(EventReviewVO eventReviewVO) {
		System.out.println(eventReviewVO);
		return eventMapper.registerReview(eventReviewVO);
	}
	
	@Override
	public int copyReview(Long erno) {
		return eventMapper.copyReview(erno);
	}

	@Override
	public int deleteReview(Long erno) {
		return eventMapper.deleteReview(erno);
	}

	@Override
	public void updateEventCoord(EventVO event) {
		eventMapper.updateEventCoord(event);
	}
	
	@Override
	public List<String> selectEHOST(){
		return eventMapper.selectEHOST();
	}

	

	//희준
	//행사 목록
	@Override
	public List<EventVO> eventList(){
		List<EventVO> eventList = eventMapper.selectEventList();
		return eventList;
	}
	
	@Override
	public List<EventVO> getEventList(Long page , Long pageSize){
		EventVO eventVO = new EventVO();
		Long offSet = (page- 1 ) * pageSize;
		
		eventVO.setPage(page);
		eventVO.setPageSize(pageSize);
		eventVO.setOffset(offSet);
		
		List<EventVO> eventList = eventMapper.selectEventList2(eventVO);
		return eventList;
	}
	
	//행사 등록
	@Override
	public Long regiEvent(EventVO event) {
		eventMapper.registerEvent(event);
		return event.getEno();
	}
	
	//행사 조회
	@Override
	public EventVO getEvent(Long eno) {
		EventVO event = eventMapper.selectEvent(eno);
		eventMapper.updateEviewsCnt(eno);
		return event ;
	}
	
	
	//행사 수정
	@Override
	public boolean modifyEvent(EventVO event) {
		return eventMapper.updateEvent(event) == 1;
	}
	
	//행사 삭제
	@Override
	public boolean removeEvent(Long eno) {
		return eventMapper.delEvent(eno) == 1;
	}
	
	//날짜 조회
	@Override
	public List<EventVO> eventRegDate(){
		return eventMapper.selectRegDate();
	}
	
	//최신순 조회
	@Override
	public List<EventVO> recentEvent(){
		return eventMapper.selectRecentEvent();
	}
}
