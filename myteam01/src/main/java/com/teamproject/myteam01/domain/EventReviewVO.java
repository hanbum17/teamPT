package com.teamproject.myteam01.domain;

import java.util.Date;
import java.util.List;

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
public class EventReviewVO {
	
	private Long erno ;
	private String ertitle ;
	private String ercontent ;
	private String erwriter ;
	private Date erregDate ;
	private Date ermodDate ;
	private Long errating ;
	private Long uno ;
	private Long eno ;

}
