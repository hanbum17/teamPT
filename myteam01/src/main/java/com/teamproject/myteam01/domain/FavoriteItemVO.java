package com.teamproject.myteam01.domain;

import java.time.LocalDateTime;

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
public class FavoriteItemVO {
    private Long favoriteId;            // 즐겨찾기 항목의 고유 ID
    private Long listId;                // 해당 항목이 속한 목록의 ID
    private String userId;
    private String itemName;            // 즐겨찾기 항목의 이름
    private String link;                // 항목의 세부 정보를 볼 수 있는 링크 (URL)
    private Long eno;                   // 행사 ID (nullable)
    private Long fno;                   // 음식점 ID (nullable)
    private LocalDateTime registrationDate; // 즐겨찾기 등록일
    
    private EventVO event;          // 이벤트 정보
    private RestaurantVO restaurant;  // 레스토랑 정보


}