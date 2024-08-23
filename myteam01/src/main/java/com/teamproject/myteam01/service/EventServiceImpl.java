package com.teamproject.myteam01.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.teamproject.myteam01.domain.EventVO;
import com.teamproject.myteam01.mapper.EventMapper;

import lombok.RequiredArgsConstructor;


@Service
@RequiredArgsConstructor
public class EventServiceImpl implements EventService{

	private final EventMapper eventMapper ;
	
	//록귀
	@Override
	public EventVO eventDetail(String eno) {
		return eventMapper.eventDetail(eno);
	}


	//희준
	//행사 목록
	@Override
	public List<EventVO> eventList(){
		System.out.println("서비스: 행사목록");
		return eventMapper.selectEventList();
	}
	
	//행사 등록
	@Override
	public Long regiEvent(EventVO event) {
		System.out.println("서비스 : 행사 등록" + event);
		eventMapper.registerEvent(event);
		System.out.println("서비스 : 행사 등록 후" + event);
		return event.getEno();
	}
	
	//행사 조회
	@Override
	public EventVO getEvent(Long eno) {
		System.out.println("서비스 : 행사 조회");
		EventVO event = eventMapper.selectEvent(eno);
		eventMapper.updateEviewsCnt(eno);
		return event ;
	}
	
	
	//행사 수정
	@Override
	public boolean modifyEvent(EventVO event) {
		System.out.println("서비스 : 행사 수정");
		return eventMapper.updateEvent(event) == 1;
	}
	
	//행사 삭제
	@Override
	public boolean removeEvent(Long eno) {
		System.out.println("서비스 : 행사 삭제");
		return eventMapper.delEvent(eno) == 1;
		
	}
	
}
