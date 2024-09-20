package com.teamproject.myteam01.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

import java.time.LocalTime;
import org.springframework.format.annotation.DateTimeFormat;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class TripPlaceVO {
    private Long id;               // 장소 ID
    private Long tripNo;           // 여행 계획 ID
    private Long registeredPlaceId; // 등록된 장소 ID
    private Integer orderNum;     // 순서
    
    @DateTimeFormat(pattern = "HH:mm")
    private LocalTime startDate;       // 일정 시작 시간
    private Integer tripDay;
    
    // 추가된 필드
    private String placeName;
    private String address; 
}
