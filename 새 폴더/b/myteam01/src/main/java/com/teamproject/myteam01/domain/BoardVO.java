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
public class BoardVO {

	private Long bno ;
	private String btitle ;
	private String bcontent ;
	private String bwriter ;
	private Date bregDate ;
	private Date bmodDate ;
	private Integer bviewsCnt ;
	private Integer breplyCnt ;
	private boolean bdelFlag ;
}
