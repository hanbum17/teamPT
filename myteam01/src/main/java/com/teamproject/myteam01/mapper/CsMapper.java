package com.teamproject.myteam01.mapper;

import java.util.List;

import com.teamproject.myteam01.domain.CsVO;

public interface CsMapper {


	//희준 - 자주묻는질문 (FAQ)
	//CS Main 조회 - 목록
	public List<CsVO> selectFAQList();
	
	//FAQ 등록
	public Integer registerFAQ(CsVO cs);
	
	//FAQ 조회
	public CsVO selectFAQ(Long faqno);
	
	//FAQ 수정
	public int updateFAQ(CsVO cs);

	//FAQ 삭제
	public int delFAQ(Long faqno);
	
	
	
	
	
	
}
