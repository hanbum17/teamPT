package com.teamproject.myteam01.domain;

import java.sql.Timestamp;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@ToString
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class CsVO {

	private Long fbno; // 건의사항 번호
	private String fbtitle; // 건의사항 제목
	private String fbcontent; // 건의사항 내용
	private Timestamp fbRegDate; // 건의사항 등록일
	private Integer fbdelflag; // 상태 0 = 존재,  1 = 삭제


	///////
	
	private Long faqno; // FAQ 번호
	private String faqcategory; // FAQ 카테고리
	private String faqtitle; // FAQ 제목(질문)
	private String faqcontent; // FAQ 내용(답변)
	private Date faqregdate; // FAQ 등록일
	private Timestamp faqmoddate; // FAQ 수정일
	private Integer faqdelflag; // FAQ 상태 0 = 존재,  1 = 삭제
	
	/////
	
	private Long ino; // inquiry 번호
	private String icategory; // inquiry 카테고리
	private String ititle; // inquiry 제목(질문)
	private String icontent; // inquiry 내용(답변)
	private Date iregdate; // inquiry 등록일
	private Integer idelflag; // inquiry 상태 0 = 존재,  1 = 삭제
	private String iresponse; // inquiry 답변
	private String userid;
	
	///////
	//공지사항
	private String notice_title;
	private String notice_content;
	private Long notice_num;
	private Long notice_delflag;
	private Date notice_regdate;
	private Date notice_moddate;
	
}//end
