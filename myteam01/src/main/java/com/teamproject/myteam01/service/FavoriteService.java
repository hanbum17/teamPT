package com.teamproject.myteam01.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.teamproject.myteam01.domain.EventVO;
import com.teamproject.myteam01.domain.FavoriteItemVO;
import com.teamproject.myteam01.domain.FavoriteListVO;
import com.teamproject.myteam01.domain.RestaurantVO;
import com.teamproject.myteam01.mapper.EventMapper;
import com.teamproject.myteam01.mapper.FavoriteMapper;
import com.teamproject.myteam01.mapper.RestaurantMapper;

@Service
public class FavoriteService {

    @Autowired
    private FavoriteMapper favoriteMapper;
    
    @Autowired
    private EventMapper eventMapper;

    @Autowired
    private RestaurantMapper restaurantMapper;

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
    
 // favoriteItems에 이벤트와 레스토랑 데이터를 채우는 메서드 추가
    public List<FavoriteItemVO> getFavoritesWithDetailsByListId(Long listId) {
        List<FavoriteItemVO> favoriteItems = favoriteMapper.getFavoritesByListId(listId);
        
        for (FavoriteItemVO item : favoriteItems) {
            if (item.getEno() != null) {
                EventVO event = eventMapper.eventDetail(item.getEno());
                item.setEvent(event); // 이벤트 정보를 세팅
            }
            if (item.getFno() != null) {
                RestaurantVO restaurant = restaurantMapper.restaurantDetail(item.getFno());
                item.setRestaurant(restaurant); // 레스토랑 정보를 세팅
            }
        }

        return favoriteItems;
    }
}
