package com.teamproject.myteam01.domain;

import java.sql.Timestamp;

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
public class FeedBackVO {

	private Long fbno; // 피드백 번호
	private String fbtitle; // 피드백 제목
	private String fbcontent; // 피드백 내용
	private Timestamp fbRegDate; // 피드백 등록일
	private String fbCategory; // 피드백 카테고리
	private Long uno; // 공통 식별자
	private String fResponse; // 뭐냐 이건
	
}//end
