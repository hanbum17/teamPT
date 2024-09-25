package com.teamproject.myteam01.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.teamproject.myteam01.domain.CsVO;
import com.teamproject.myteam01.mapper.CsMapper;

import lombok.RequiredArgsConstructor;


@Service
@RequiredArgsConstructor
public class CsServiceImpl implements CsService{

	private final CsMapper csMapper ;
	


	//희준
	//FAQ 목록
	@Override
	public List<CsVO> csList(){
		return csMapper.selectFAQList();
	}
	
	//FAQ 등록
	@Override
	public Long regiFAQ(CsVO faq) {
		csMapper.registerFAQ(faq);
		return faq.getFaqno();
	}
	
	//FAQ 조회
	@Override
	public CsVO getFAQ(Long faqno) {
		CsVO faq = csMapper.selectFAQ(faqno);
		return faq ;
	}
	
	
	//FAQ 수정
	@Override
	public boolean modifyFAQ(CsVO faq) {
		System.out.println("서비스 : FAQ 수정");
		return csMapper.updateFAQ(faq) == 1;
	}
	
	//FAQ 삭제
	@Override
	public boolean removeFAQ(Long faqno) {
		System.out.println("서비스 : FAQ 삭제");
		return csMapper.delFAQ(faqno) == 1;
		
	}

/////////////////////////////////////////////////////////////
	
	//Inquiry 목록
	@Override
	public List<CsVO> csInList(){
		return csMapper.selectINQList();
		
	}
	
	//Inquiry 등록
	@Override
	public Long regiIn(CsVO inq) {
		csMapper.registerINQ(inq);
		return inq.getIno();
	}
	
	//Inquiry 조회
	@Override
	public CsVO getIn(Long ino) {
		CsVO inq = csMapper.selectINQ(ino);
		return inq ;
	}
	
	
	//Inquiry 수정
	@Override
	public boolean modifyIn(CsVO inq) {
		System.out.println("서비스 : Inquiry 수정");
		return csMapper.updateINQ(inq) == 1;
	}
	
	//Inquiry 삭제
	@Override
	public boolean removeIn(Long ino) {
		System.out.println("서비스 : Inquiry 삭제");
		return csMapper.delFAQ(ino) == 1;
		
	}

/////////////////////////////////////////////////////////////
	
	//FeedBack 목록
	@Override
	public List<CsVO> csFBList(){
		return csMapper.selectFBList();
	}
	
	//FeedBack 등록
	@Override
	public Long regiFB(CsVO feeb) {
		csMapper.registerFB(feeb);
		return feeb.getFbno();
	}
	
	//FeedBack 조회
	@Override
	public CsVO getFB(Long fbno) {
		CsVO feeb = csMapper.selectFB(fbno);
		return feeb ;
	}
	
	
	//FeedBack 수정
	@Override
	public boolean modifyFB(CsVO feeb) {
		System.out.println("서비스 : Feedback 수정");
		return csMapper.updateFB(feeb) == 1;
	}
	
	//FeedBack 삭제
	@Override
	public boolean removeFB(Long fbno) {
		System.out.println("서비스 : Feedback 삭제");
		return csMapper.delFB(fbno) == 1;
		
	}
	
/////////////////////////////////////////////////////////////
	
	//공지사항 등록
	@Override
	public void regNotice(CsVO notice) {
		csMapper.insertNotice(notice);
	}
	
	//공지사항 목록조회
	@Override
	public List<CsVO> getNoticeList(){
		return csMapper.selectNoticeList();
	}
	
	//공지사항 상세조회
	@Override
	public CsVO getNoticeDetail(Long num) {
		return csMapper.selectNoticeDetail(num);
	}
	
	
}
