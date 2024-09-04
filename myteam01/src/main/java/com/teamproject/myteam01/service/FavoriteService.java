package com.teamproject.myteam01.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.teamproject.myteam01.domain.FavoriteItemVO;
import com.teamproject.myteam01.domain.FavoriteListVO;
import com.teamproject.myteam01.mapper.FavoriteMapper;

@Service
public class FavoriteService {

    @Autowired
    private FavoriteMapper favoriteMapper;

    public void addFavoriteList(FavoriteListVO favoriteListVO) {
        favoriteMapper.insertFavoriteList(favoriteListVO);
    }

    public List<FavoriteListVO> getFavoriteListsByUserId(String userId) {
        return favoriteMapper.getFavoriteListsByUserId(userId);
    }

    public List<FavoriteItemVO> getFavoritesByListId(Long listId) {
        return favoriteMapper.getFavoritesByListId(listId);
    }

    public FavoriteListVO getFavoriteListById(Long listId) {
        return favoriteMapper.getFavoriteListById(listId);
    }

    public void addFavoriteItem(FavoriteItemVO favoriteItemVO) {
        favoriteMapper.insertFavoriteItem(favoriteItemVO);
    }

    public void deleteFavoriteItem(Long favoriteId) {
        favoriteMapper.deleteFavoriteItem(favoriteId);
    }

    public void updateFavoriteListName(FavoriteListVO favoriteListVO) {
        favoriteMapper.updateFavoriteListName(favoriteListVO);
    }

    public void deleteFavoriteList(Long listId) {
        favoriteMapper.deleteFavoriteList(listId);
    }
}
