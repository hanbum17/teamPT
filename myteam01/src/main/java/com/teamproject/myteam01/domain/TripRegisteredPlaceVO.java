package com.teamproject.myteam01.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class TripRegisteredPlaceVO {
    private Long id;          // 장소 ID
    private Long tripNo;      // 여행 계획 ID
    private String placeName; // 장소 이름
    private String address;   // 주소
}
