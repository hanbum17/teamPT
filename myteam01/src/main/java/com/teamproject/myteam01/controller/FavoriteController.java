package com.teamproject.myteam01.controller;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.teamproject.myteam01.domain.EventVO;
import com.teamproject.myteam01.domain.FavoriteItemVO;
import com.teamproject.myteam01.domain.FavoriteListVO;
import com.teamproject.myteam01.domain.RestaurantVO;
import com.teamproject.myteam01.mapper.EventMapper;
import com.teamproject.myteam01.mapper.RestaurantMapper;
import com.teamproject.myteam01.service.FavoriteService;

import io.swagger.v3.oas.annotations.parameters.RequestBody;

@Controller
public class FavoriteController {

    @Autowired
    private FavoriteService favoriteService;
    
    @Autowired
    private EventMapper eventMapper ;
    
    @Autowired
    private RestaurantMapper restaurantMapper ;

    @GetMapping("/user/user_fav_lists")
    public String getUserFavoriteLists(@AuthenticationPrincipal UserDetails userDetails, Model model) {
        String userId = userDetails.getUsername();
        List<FavoriteListVO> favoriteLists = favoriteService.getFavoriteListsByUserId(userId);

        // 각 목록에 대한 항목을 조회하여 채워줍니다.
        for (FavoriteListVO list : favoriteLists) {
            List<FavoriteItemVO> items = favoriteService.getFavoritesByListId(list.getListId());
            list.setItems(items); // 각 목록에 해당하는 항목을 리스트에 채워줌
        }

        model.addAttribute("favoriteLists", favoriteLists);
        return "user_main/user_menu/user_fav_lists";
    }



    @PostMapping("/user/addFavoriteList")
    public String addFavoriteList(@RequestParam("listName") String listName,
                                  @RequestParam("listColor") String listColor,
                                  @AuthenticationPrincipal UserDetails userDetails) {
        String userId = userDetails.getUsername();
        FavoriteListVO favoriteListVO = new FavoriteListVO();
        favoriteListVO.setUserId(userId);
        favoriteListVO.setListName(listName);
        favoriteListVO.setColor(listColor); // 사용자가 선택한 색상 설정

        // 디버깅 로그 추가
        System.out.println("Before Insert - FavoriteListVO: " + favoriteListVO);

        favoriteService.addFavoriteList(favoriteListVO);

        // Insert 후에 listId가 채워졌는지 확인
        System.out.println("After Insert - FavoriteListVO: " + favoriteListVO);

        return "redirect:/user/user_fav_lists"; // 목록 페이지로 리다이렉트
    }


    
    @PostMapping("/user/updateFavoriteList")
    public String updateFavoriteList(@RequestParam("listId") Long listId, 
                                     @RequestParam("listName") String listName,
                                     @RequestParam("listColor") String listColor){
        FavoriteListVO favoriteListVO = new FavoriteListVO();
        favoriteListVO.setListId(listId);
        favoriteListVO.setListName(listName);
        favoriteListVO.setColor(listColor);
        
        favoriteService.updateFavoriteListName(favoriteListVO);
        return "redirect:/user/user_fav_lists"; // 수정 후 목록 페이지로 리다이렉트
    }
    
    @PostMapping("/user/deleteFavoriteList")
    public String deleteFavoriteList(@RequestParam("listId") Long listId) {
        favoriteService.deleteFavoriteList(listId);
        return "redirect:/user/user_fav_lists"; // 삭제 후 목록 페이지로 리다이렉트
    }

    @GetMapping("/user/getFavoriteLists")
    @ResponseBody
    public List<FavoriteListVO> getFavoriteLists(@AuthenticationPrincipal UserDetails userDetails) {
        // 현재 로그인한 사용자의 아이디 가져오기
        String userId = userDetails.getUsername();
        
        // 해당 사용자 아이디로 즐겨찾기 목록 조회
        List<FavoriteListVO> favoriteLists = favoriteService.getFavoriteListsByUserId(userId);

        // 디버깅용 로그 출력
        System.out.println("Favorite Lists for user: " + userId + " -> " + favoriteLists);

        return favoriteLists;
    }


    @GetMapping("/user/user_fav_items")
    public String getFavoriteItems(@RequestParam("listId") Long listId, 
                                   @AuthenticationPrincipal UserDetails userDetails,
                                   Model model) {
        List<FavoriteItemVO> favoriteItems = favoriteService.getFavoritesWithDetailsByListId(listId); // 선택된 즐겨찾기 목록에 대한 항목 조회
        FavoriteListVO favoriteList = favoriteService.getFavoriteListById(listId); // 선택된 목록 정보 조회
        
        // 현재 사용자의 다른 즐겨찾기 목록 가져오기
        String userId = userDetails.getUsername();
        List<FavoriteListVO> favoriteLists = favoriteService.getFavoriteListsByUserId(userId); // 다른 목록들 가져오기

        // 데이터를 모델에 추가하여 JSP로 전달
        model.addAttribute("favoriteItems", favoriteItems);
        model.addAttribute("favoriteList", favoriteList); // 선택된 목록 정보
        model.addAttribute("favoriteLists", favoriteLists); // 사용자의 다른 즐겨찾기 목록들

        return "user_main/user_menu/user_fav_items";
    }




    @PostMapping("/user/addFavoriteItem")
    @ResponseBody
    public String addFavoriteItem(@RequestParam("listId") Long listId,
                                  @RequestParam("link") String link,
                                  @RequestParam(value = "eno", required = false) Long eno,
                                  @RequestParam(value = "fno", required = false) Long fno,
                                  @AuthenticationPrincipal UserDetails userDetails) {
        FavoriteItemVO favoriteItemVO = new FavoriteItemVO();
        favoriteItemVO.setListId(listId);
        favoriteItemVO.setLink(link);
        favoriteItemVO.setEno(eno);
        favoriteItemVO.setFno(fno);
        favoriteItemVO.setUserId(userDetails.getUsername()); // 현재 로그인한 사용자의 아이디 설정
        favoriteItemVO.setRegistrationDate(LocalDateTime.now()); // 현재 시간 설정

        favoriteService.addFavoriteItem(favoriteItemVO);
        return "즐겨찾기가 완료되었습니다."; // 완료 메시지를 반환
    }
    
    @PostMapping("/user/favorites/updateList")
    @ResponseBody
    public String updateFavoriteList(@RequestParam Long favoriteId, @RequestParam Long newListId) {
        try {
            // 즐겨찾기 항목을 새로운 목록으로 이동
            favoriteService.updateFavoriteList(favoriteId, newListId);
            return "Success";
        } catch (Exception e) {
            e.printStackTrace();
            return "Failed";
        }
    }

    

    @PostMapping("/user/favorites/remove")
    public String deleteFavoriteItem(@RequestParam("favoriteId") Long favoriteId, 
                                     @RequestParam("listId") Long listId) {
        favoriteService.deleteFavoriteItem(favoriteId);
        return "redirect:/user/user_fav_items?listId=" + listId;
    }
}
