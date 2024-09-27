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
	

	
///////////////////////////////////////////
	
	// 공지사항 등록
	public void insertNotice(CsVO cs);
	
	// 공지사항 목록 조회
	public List<CsVO> selectNoticeList();
	
	// 공지사항 상세 조회
	public CsVO selectNoticeDetail(Long notice_num);
	
	// 공지사항 수정
	public int updateNT(CsVO cs);

	// 공지사항 삭제
	public int delNT(Long notice_num);
	
	//공지사항 수정
	public CsVO updateNotice(CsVO csVO);
	
	//공지사항 삭제
	public void deleteNotice(Long num);
	
//////////////////////////////////////////////
	
	// 행사등록
	public void insertAdminEvent(CsVO cs);
	
	// 행사 목록 조회
	public List<CsVO> selectAdminEventList();
	
	// 행사 상세 조회
	public CsVO selectAdminEventDetail(Long event_Num);
	
	// 행사 수정
	public int updateAE(CsVO cs);

	// 행사 삭제
	public int delAE(Long event_Num);

	//행사 수정
	public CsVO updateAdminEvent(CsVO csVO);
	
	//행사 삭제
	public void deleteAdminEvent(Long num);
	
//////////////////////////////////////////////

	// 1대1 문의 내역 조회 - 사용자별
	public List<CsVO> selectUserInquiries(String userId);

	// 건의사항 내역 조회 - 사용자별
	public List<CsVO> selectUserFeedbacks(String userId);
	
	
}
