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
	public List<CsVO> selectINQList();
	
	// Inquiry 등록
	public Integer registerINQ(CsVO cs);
	
	// Inquiry 조회
	public CsVO selectINQ(Long ino);
	
	// Inquiry 수정
	public int updateINQ(CsVO cs);
	
	// Inquiry 삭제
	public int delINQ(Long ibno);


///////////////////////////////////////////
	
	// Feedback 목록
	public List<CsVO> selectFBList();
	
	// Feedback 등록
	public Integer registerFB(CsVO cs);
	
	// Feedback 조회
	public CsVO selectFB(Long fbno);
		
	// Feedback 수정
	public int updateFB(CsVO cs);

	// Feedback 삭제
	public int delFB(Long fbno);
	

	
	
	
	
}
