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

    public List<FavoriteListVO> getFavoriteListsByUserId(String userid) {
        return favoriteMapper.getFavoriteListsByUserId(userid);
    }
}
