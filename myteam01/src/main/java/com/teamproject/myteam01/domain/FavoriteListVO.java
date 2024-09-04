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
public class FavoriteListVO {
    private Long listId;           // 즐겨찾기 목록의 고유 ID
    private String userId;        // 목록을 소유한 사용자 ID
    private String listName;      // 즐겨찾기 목록의 이름
    private List<FavoriteItemVO> items; // 이 목록에 포함된 즐겨찾기 항목들
}