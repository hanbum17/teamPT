package com.teamproject.myteam01.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class TripPlanVO {
    private Long tripNo;          // 여행 계획 번호
    private String userId;        // 사용자 ID
    private String title;         // 여행 이름
    
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date startDate;       // 여행 시작 날짜
    
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date endDate;         // 여행 종료 날짜
    
    // 여행 일수 계산 메서드
    public long getTripDays() {
        if (startDate != null && endDate != null) {
            return (endDate.getTime() - startDate.getTime()) / (1000 * 60 * 60 * 24) + 1;
        }
        return 0;
    }
}
