package com.teamproject.myteam01.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.teamproject.myteam01.domain.FeedBackVO;
import com.teamproject.myteam01.mapper.FeedBackMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class FeedBackServiceImpl implements FeedBackService {

	private final FeedBackMapper feedbackMapper ;
	
	//피드백 목록
	@Override
	public List<FeedBackVO> feedbackList(){
		System.out.println("서비스 : 피드백 목록");
		return feedbackMapper.selectFeedBackList();		
	}
	
	//피드백 등록
	@Override
	public Long regiFeedBack(FeedBackVO feedback) {
		System.out.println("서비스 : 피드백 등록" + feedback);
		feedbackMapper.registerFeedBack(feedback);
		System.out.println("서비스 : 피드백 등록 후 " + feedback);
		return feedback.getFbno();
	}
	
	//피드백 조회
	@Override
	public FeedBackVO getFeedBack(Long fbno) {
		System.out.println("서비스 : 피드백 조회");
		FeedBackVO feedback = feedbackMapper.selectFeedBack(fbno);
		return feedback;
	}
	
}//end
