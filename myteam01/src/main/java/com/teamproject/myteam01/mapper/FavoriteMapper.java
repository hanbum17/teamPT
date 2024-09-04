package com.teamproject.myteam01.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.teamproject.myteam01.domain.FavoriteItemVO;
import com.teamproject.myteam01.domain.FavoriteListVO;

@Mapper
public interface FavoriteMapper {

	void insertFavoriteList(FavoriteListVO favoriteListVO);

    List<FavoriteListVO> getFavoriteListsByUserId(String userid);

}
