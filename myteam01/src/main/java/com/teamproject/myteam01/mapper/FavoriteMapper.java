package com.teamproject.myteam01.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.teamproject.myteam01.domain.FavoriteItemVO;
import com.teamproject.myteam01.domain.FavoriteListVO;

@Mapper
public interface FavoriteMapper {

    // 즐겨찾기 목록을 삽입하는 메서드
    void insertFavoriteList(FavoriteListVO favoriteListVO);

    // 특정 사용자 ID로 즐겨찾기 목록을 조회하는 메서드
    List<FavoriteListVO> getFavoriteListsByUserId(String userId);

    // 특정 즐겨찾기 목록 ID로 즐겨찾기 항목을 조회하는 메서드
    List<FavoriteItemVO> getFavoritesByListId(Long listId);

    FavoriteListVO getFavoriteListById(Long listId);
    
    // 즐겨찾기 항목을 삽입하는 메서드
    void insertFavoriteItem(FavoriteItemVO favoriteItemVO);

    // 특정 즐겨찾기 항목을 삭제하는 메서드
    void deleteFavoriteItem(Long favoriteId);

    // 즐겨찾기 목록 이름을 수정하는 메서드
    void updateFavoriteListName(FavoriteListVO favoriteListVO);
    
    void updateFavoriteList(@Param("favoriteId") Long favoriteId, @Param("newListId") Long newListId);

    // 즐겨찾기 목록을 삭제하는 메서드
    void deleteFavoriteList(Long listId);
}
