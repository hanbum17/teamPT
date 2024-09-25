package com.teamproject.myteam01.domain;

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
	
}
