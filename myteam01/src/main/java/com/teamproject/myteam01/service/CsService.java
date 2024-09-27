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

/////////////////////////////////////////////////////////////
	
	//Inquiry 목록
	public List<CsVO> csInList();
	
	//Inquiry 등록
	public Long regiIn(CsVO inq);
	
	//Inquiry 조회
	public CsVO getIn(Long ino);
	
	//Inquiry 수정
	public boolean modifyIn(CsVO inq);
	
	//Inquiry 삭제
	public boolean removeIn(Long ino);
	
/////////////////////////////////////////////////////////////
	
	//FeedBack 목록
	public List<CsVO> csFBList();
	
	//FeedBack 등록
	public Long regiFB(CsVO feeb);
	
	//FeedBack 조회
	public CsVO getFB(Long fbno);
	
	//FeedBack 수정
	public boolean modifyFB(CsVO feeb);
	
	//FeedBack 삭제
	public boolean removeFB(Long fbno);
	
/////////////////////////////////////////////////////////////
	
	//공지사항 등록
	public void regNotice(CsVO notice);
	
	//공지사항 목록조회
	public List<CsVO> getNoticeList();
	
	//공지사항 상세조회

	public CsVO getNoticeDetail(Long notice_num);
	
	//공지사항 수정
	public boolean modifyNT(CsVO nt);
	
	//공지사항 삭제
	public boolean removeNT(Long notice_num);
	
////////////////////////////////////////////////////////
	
	//이벤트 등록
	public void regEvent(CsVO event);
	
	//이벤트 목록조회
	public List<CsVO> getEventList();
	
	//이벤트 상세조회
	public CsVO getEventDetail(Long event_num);
	
	//이벤트 수정
	public boolean modifyAE(CsVO ae);
	
	//이벤트 삭제
	public boolean removeAE(Long event_num);


	
////////////////////////////////////////////////////////
	
	List<CsVO> getUserInquiries(String userId);  // 사용자 1대1 문의 조회

	
}
