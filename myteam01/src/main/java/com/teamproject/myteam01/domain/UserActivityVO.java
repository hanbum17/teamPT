package com.teamproject.myteam01.domain;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class UserActivityVO {

	//사용자 추천을 위한 정보
	private String userId ;
	private String type;
	private Long eno;
	private Long fno;
	//신규회원
    private Date access_time ;
    private Long regDateCount;
}
