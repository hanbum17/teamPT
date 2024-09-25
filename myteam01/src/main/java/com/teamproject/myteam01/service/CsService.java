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
	public CsVO getNoticeDetail(Long num);
	
}
