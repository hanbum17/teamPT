package com.teamproject.myteam01.mapper;

import java.util.List;

import com.teamproject.myteam01.domain.EventVO;

public interface EventMapper {

	
	
	//록귀
	public EventVO eventDetail(String eno);
	
	
	
	
	//희준
	//행사 목록
	public List<EventVO> selectEventList();
	
	//행사 등록
	public Integer registerEvent(EventVO event);
	
	//행사 조회
	public EventVO selectEvent(Long eno);
	
	//행사 수정
	public int updateEvent(EventVO event);

	//행사 삭제
	public int delEvent(Long eno);
	
	//행사 조회수 증가
	public void updateEviewsCnt(Long eno);
	
	
	
	
	
}
