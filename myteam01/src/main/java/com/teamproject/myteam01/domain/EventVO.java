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
public class EventVO {

    //private Integer eno;         // 행사 번호
    private Long eno ;
    
    private String ename;       // 행사 이름
    private String eperiod;     // 행사 기간
    private String ecost;       // 행사 비용
    private String eaddress;    // 행사 주소
    private String eplace;      // 행사 장소
    private String esite;       // 행사 사이트
    private String ehost;       // 행사 주최
    private String econtent;    // 행사 내용
    private String uno;         // 공통 식별자
    private int eviewsCnt;      // 행사 조회수
    private float erating;      // 행사 평점
    private String excoord;     // 행사 X좌표
    private String eycoord;     // 행사 Y좌표
    

    
    public EventVO(String ehost, String excoord, String eycoord) {
        this.ehost = ehost;
        this.excoord = excoord;
        this.eycoord = eycoord;
    }
    
}


