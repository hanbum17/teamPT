package com.teamproject.myteam01.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

import java.util.Date;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class TripPlanVO {
    private Long tripNo;          // 여행 계획 번호
    private String userId;        // 사용자 ID
    private String title;         // 여행 이름
    private Date startDate;       // 여행 시작 날짜
    private Date endDate;         // 여행 종료 날짜
}
