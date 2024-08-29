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
    private Long itemId;            // 즐겨찾기 항목의 고유 ID
    private Long listId;            // 해당 항목이 속한 목록의 ID
    private String itemName;        // 즐겨찾기 항목의 이름
    private String link;            // 항목의 세부 정보를 볼 수 있는 링크 (URL)
    private Long eno;               // 행사 ID (nullable)
    private Long fno;               // 음식점 ID (nullable)
    private LocalDateTime registrationDate; // 즐겨찾기 등록일

    // 음식점과 행사는 둘 중 하나만 선택되므로,
    // 둘 다 존재하지 않거나, 둘 다 존재할 수 없음.
    public boolean isRestaurant() {
        return fno != null;
    }

    public boolean isEvent() {
        return eno != null;
    }
}
