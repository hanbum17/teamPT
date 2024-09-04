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
	
//    private String fno;         // 음식점 번호
//	private String uno;         // 공통 식별자
//	private int fviewscnt;      // 음식점 조회수
//	private float frating;      // 음식점 평점
//	private String fxcoord;     // 음식점 X좌표
//    private String fycoord;     // 음식점 Y좌표
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
    
    
   

}
