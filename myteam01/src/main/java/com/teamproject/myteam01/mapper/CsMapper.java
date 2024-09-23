package com.teamproject.myteam01.mapper;

import java.util.List;

import com.teamproject.myteam01.domain.CsVO;

public interface CsMapper {


	// 희준 - 자주묻는질문 (FAQ)
	// CS Main 조회 - 목록
	public List<CsVO> selectFAQList();
	
	// FAQ 등록
	public Integer registerFAQ(CsVO cs);
	
	// FAQ 조회
	public CsVO selectFAQ(Long faqno);
	
	// FAQ 수정
	public int updateFAQ(CsVO cs);

	// FAQ 삭제
	public int delFAQ(Long faqno);
	
	
//////////////////////////////////////////
	
	
	// Inquiry 목록
	public List<CsVO> selectInquiryList();
	
	// Inquiry 등록
	public Integer registerInquiry(CsVO cs);
	
	// Inquiry 조회
	public CsVO selectInquiry(Long ino);
	
	// Inquiry 수정
	public int updateInquiry(CsVO cs);
	
	// Inquiry 삭제
	public int delInquiry(Long ibno);


///////////////////////////////////////////
	
	// Feedback 목록
	public List<CsVO> selectFeedbackList();
	
	// Feedback 등록
	public Integer registerFeedback(CsVO cs);
	
	// Feedback 조회
	public CsVO selectFeedback(Long fbno);
		
	// Feedback 수정
	public int updateFeedback(CsVO cs);

	// Feedback 삭제
	public int delFeedback(Long fbno);
	

	
	
	
	
}
