package com.teamproject.myteam01.domain;

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
public class RestaurantVO {
	

  private Long fno;
	private Long uno;
	private Integer fviewscnt;
	private Double frating;
	private Double fxcoord;
	private Double fycoord;
	
    private String fcategory;   // 음식점 카테고리
    private String fname;       // 음식점 이름
    private String faddress;    // 음식점 주소
    
    private Long ftype;
    private List<AttachFileDTO> attachFileList;
    private List<RestaurantsReviewVO> reivewsList;
    
    private Long page;
	private Long pageSize;
	private Long offset;
	
	 private Double lat; // 위도
	 private Double lng; 
	 
	 private String guName;
	
   

}
