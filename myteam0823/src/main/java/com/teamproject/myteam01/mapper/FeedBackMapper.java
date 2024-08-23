package com.teamproject.myteam01.mapper;

import java.util.List;

import com.teamproject.myteam01.domain.EventVO;
import com.teamproject.myteam01.domain.FeedBackVO;

public interface FeedBackMapper {
	
	//피드백 목록
	public List<FeedBackVO> selectFeedBackList();
	
	//피드백 등록
	public Integer registerFeedBack(FeedBackVO feedback);
	
	//피드백 조회
	public FeedBackVO selectFeedBack(Long fbno);
	

}//end
