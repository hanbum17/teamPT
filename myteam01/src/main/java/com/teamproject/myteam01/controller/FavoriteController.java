package com.teamproject.myteam01.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import com.teamproject.myteam01.domain.FavoriteItemVO;
import com.teamproject.myteam01.domain.FavoriteListVO;
import com.teamproject.myteam01.service.FavoriteService;

@Controller
public class FavoriteController {

    @Autowired
    private FavoriteService favoriteService;

    @GetMapping("/user/user_fav_lists")
    public String getUserFavoriteLists(@AuthenticationPrincipal UserDetails userDetails, Model model) {
        String userId = userDetails.getUsername();
        List<FavoriteListVO> favoriteLists = favoriteService.getFavoriteListsByUserId(userId);
        model.addAttribute("favoriteLists", favoriteLists);
        return "user_main/user_menu/user_fav_lists";
    }

    @PostMapping("/user/addFavoriteList")
    public String addFavoriteList(@RequestParam("listName") String listName,
                                  @AuthenticationPrincipal UserDetails userDetails) {
        String userId = userDetails.getUsername();
        FavoriteListVO favoriteListVO = new FavoriteListVO();
        favoriteListVO.setUserId(userId);
        favoriteListVO.setListName(listName);

        // 디버깅 로그 추가
        System.out.println("Before Insert - FavoriteListVO: " + favoriteListVO);

        favoriteService.addFavoriteList(favoriteListVO);

        // Insert 후에 listId가 채워졌는지 확인
        System.out.println("After Insert - FavoriteListVO: " + favoriteListVO);

        return "redirect:/user/user_fav_lists"; // 목록 페이지로 리다이렉트
    }
    
    @PostMapping("/user/updateFavoriteList")
    public String updateFavoriteList(@RequestParam("listId") Long listId, 
                                     @RequestParam("listName") String listName) {
        FavoriteListVO favoriteListVO = new FavoriteListVO();
        favoriteListVO.setListId(listId);
        favoriteListVO.setListName(listName);
        favoriteService.updateFavoriteListName(favoriteListVO);
        return "redirect:/user/user_fav_lists"; // 수정 후 목록 페이지로 리다이렉트
    }
    
    @PostMapping("/user/deleteFavoriteList")
    public String deleteFavoriteList(@RequestParam("listId") Long listId) {
        favoriteService.deleteFavoriteList(listId);
        return "redirect:/user/user_fav_lists"; // 삭제 후 목록 페이지로 리다이렉트
    }




    @GetMapping("/user/user_fav_items")
    public String getFavoriteItems(@RequestParam("listId") Long listId, Model model) {
        List<FavoriteItemVO> favoriteItems = favoriteService.getFavoritesByListId(listId);
        model.addAttribute("favoriteItems", favoriteItems);
        return "user_main/user_menu/user_fav_items";
    }

    @PostMapping("/user/addFavoriteItem")
    public String addFavoriteItem(@RequestParam("listId") Long listId,
                                  @RequestParam("itemName") String itemName,
                                  @RequestParam("link") String link,
                                  @RequestParam(value = "eno", required = false) Long eno,
                                  @RequestParam(value = "fno", required = false) Long fno) {
        FavoriteItemVO favoriteItemVO = new FavoriteItemVO();
        favoriteItemVO.setListId(listId);
        favoriteItemVO.setItemName(itemName);
        favoriteItemVO.setLink(link);
        favoriteItemVO.setEno(eno);
        favoriteItemVO.setFno(fno);
        favoriteService.addFavoriteItem(favoriteItemVO);
        return "redirect:/user/user_fav_items?listId=" + listId;
    }

    @PostMapping("/user/favorites/remove")
    public String deleteFavoriteItem(@RequestParam("favoriteId") Long favoriteId, 
                                     @RequestParam("listId") Long listId) {
        favoriteService.deleteFavoriteItem(favoriteId);
        return "redirect:/user/user_fav_items?listId=" + listId;
    }
}
