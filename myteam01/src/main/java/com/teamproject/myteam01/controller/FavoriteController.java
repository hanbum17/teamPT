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
        String userid = userDetails.getUsername();
        List<FavoriteListVO> favoriteLists = favoriteService.getFavoriteListsByUserId(userid);
        model.addAttribute("favoriteLists", favoriteLists);
        return "user_main/user_menu/user_fav_lists";
    }

    @PostMapping("/user/addFavoriteList")
    public String addFavoriteList(@RequestParam("listName") String listName,
                                  @AuthenticationPrincipal UserDetails userDetails) {
    	System.out.println("=============================1==============================");
        String userid = userDetails.getUsername();
        System.out.println("=============================2==============================");
        FavoriteListVO favoriteListVO = new FavoriteListVO();
        System.out.println("=============================3==============================");
        favoriteListVO.setUserId(userid);
        System.out.println("=============================4==============================");
        favoriteListVO.setListName(listName);
        System.out.println("=============================5==============================");
        favoriteService.addFavoriteList(favoriteListVO);
        System.out.println("=============================6==============================");
        return "redirect:/user/user_fav_lists"; // 목록 페이지로 리다이렉트
    }
}
