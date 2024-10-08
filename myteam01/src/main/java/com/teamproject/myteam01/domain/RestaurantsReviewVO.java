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
public class RestaurantsReviewVO {
	
	private Long frno ;
	private String frtitle ;
	private String frcontent ;
	private String frwriter ;
	private Date frregDate ;
	private Date frmodDate ;
	private Double frrating ;
	private Long uno ;
	private Long fno ;
	
	private Double ratingAverage ;
	private Long frCount;

	private Long page;
	private Long pageSize;
	private Long offset;
	
	public RestaurantsReviewVO(Long page, Long pageSize) {
		
		if(page == null || pageSize == null || page == 0L || pageSize == 0L) {
			this.page = 1L;
			this.pageSize = 5L;
		} else {
			this.page = page;
			this.pageSize = pageSize;
		}
	}
	
	
	
	
}
