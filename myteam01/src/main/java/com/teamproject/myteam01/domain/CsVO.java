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

	private Long fbno; // 피드백 번호
	private String fbtitle; // 피드백 제목
	private String fbcontent; // 피드백 내용
	private Timestamp fbRegDate; // 피드백 등록일
	private String fbCategory; // 피드백 카테고리
	private Long uno; // 공통 식별자
	private String fResponse; // 피드백 답변

	////
	
	private Long faqno; // FAQ 번호
	private String faqcategory; // FAQ 분류
	private String faqtitle; // FAQ 제목(질문)
	private String faqcontent; // FAQ 내용(답변)
	private Date faqregdate; // FAQ 등록일
	private Timestamp TimeStamfaqmoddate; // FAQ 수정일
	
}//end
