package com.teamproject.myteam01.service;

import java.util.List;

import com.teamproject.myteam01.domain.CsVO;

public interface CsService {

	
	//희준
	//FAQ 목록
	public List<CsVO> csList();
	
	//FAQ 등록
	public Long regiFAQ(CsVO faq);
	
	//FAQ 조회
	public CsVO getFAQ(Long faqno);
	
	//FAQ 수정
	public boolean modifyFAQ(CsVO faq);
	
	//FAQ 삭제
	public boolean removeFAQ(Long faqno);
	
	
}
