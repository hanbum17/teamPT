package com.teamproject.myteam01.mapper;

import java.util.List;

import com.teamproject.myteam01.domain.CsVO;

public interface CsMapper {


	//희준 - 자주묻는질문 (FAQ)
	//CS Main 조회 - 목록
	public List<CsVO> selectEventList();
	
	//FAQ 등록
	public Integer registerEvent(CsVO cs);
	
	//FAQ 조회
	public CsVO selectEvent(Long faqno);
	
	//FAQ 수정
	public int updateEvent(CsVO cs);

	//FAQ 삭제
	public int delEvent(Long faqno);
	
	
	
	
	
	
}
