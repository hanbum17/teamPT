package com.teamproject.myteam01.service;

import java.util.List;

import com.teamproject.myteam01.domain.FeedBackVO;

public interface FeedBackService {

	//피드백 목록
	public List<FeedBackVO> feedbackList();
	
	//피드백 등록
	public Long regiFeedBack(FeedBackVO feedback);
	
	//피드백 조회
	public FeedBackVO getFeedBack(Long fbno);
	
	
}//end
