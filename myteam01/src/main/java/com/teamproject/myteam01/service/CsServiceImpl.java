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
		return csMapper.delINQ(ino) == 1;
		
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
		System.out.println("피드백 데이터 : " + feeb); // 가져온 공지사항 데이터 확인
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
	
	

	
	//공지사항 목록조회
	@Override
	public List<CsVO> getNoticeList(){
		return csMapper.selectNoticeList();
	}
	
	//공지사항 등록
		@Override
		public void regNotice(CsVO notice) {
			csMapper.insertNotice(notice);
		}
	
	//공지사항 상세조회
	@Override
	public CsVO getNoticeDetail(Long notice_num) {
		System.out.println("서비스 - 공지사항 번호: " + notice_num); // notice_num 값 확인
		CsVO notice = csMapper.selectNoticeDetail(notice_num);
		System.out.println("서비스 - 공지사항 데이터: " + notice); // 가져온 공지사항 데이터 확인
		return notice;
	}
	
	


	//공지사항 수정
		@Override
		public boolean modifyNT(CsVO nt) {
			System.out.println("서비스 : notice 수정");
			return csMapper.updateNT(nt) == 1;
		}
		
	//공지사항 삭제
	@Override
	public boolean removeNT(Long notice_num) {
		System.out.println("서비스 : notice 삭제");
		return csMapper.delNT(notice_num) == 1;
			
		}
	
////////////////////////////////////////////////////////////////
	

	//이벤트 목록조회
	@Override
	public List<CsVO> getEventList(){
		return  csMapper.selectAdminEventList(); 
		
	}
	
	//이벤트 등록

	@Override
	public void regEvent(CsVO event) {
		csMapper.insertAdminEvent(event);
	}
	

	
	//이벤트 상세조회

	@Override
	public CsVO getEventDetail(Long event_num) {
		System.out.println("이벤트 번호:------------------------------------------ " + event_num); // event_num 값 확인
		CsVO event = csMapper.selectAdminEventDetail(event_num);
		System.out.println("이벤트 데이터:------------------------------------------ " + event); // 가져온 이벤트 데이터 확인
		return event;
	}
	

	//이벤트 수정
ain
	@Override
	public boolean modifyAE(CsVO ae) {
		System.out.println("서비스 : adminevent 수정");
		return csMapper.updateAE(ae) == 1;
	}
	
	//이벤트 삭제
	@Override
	public boolean removeAE(Long event_Num) {
		System.out.println("서비스 : adminevent 삭제");
		return csMapper.delAE(event_Num) == 1;
		
	}
	
	
////////////////////////////////////////////////////////////////
	@Override
    public List<CsVO> getUserInquiries(String userId) {
        return csMapper.selectUserInquiries(userId);
    }



    
	
}
