package com.teamproject.myteam01.controller;

import java.util.Collection;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.teamproject.myteam01.domain.AttachFileDTO;
import com.teamproject.myteam01.domain.RestaurantVO;
import com.teamproject.myteam01.domain.RestaurantsReviewVO;
import com.teamproject.myteam01.service.RestaurantService;
import com.teamproject.myteam01.service.UserRegistrationService;

import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;

@Tag(name = "RestautantController", description = "Restautant")
@Controller
@RequiredArgsConstructor
@RequestMapping("/restaurant")
public class RestaurantController {

   private final RestaurantService restaurantService ;
    private final UserRegistrationService userRegistrationService;

   

   @GetMapping("/detail")
   public String eventDetail(@RequestParam("fno")Long fno, Model model) {
      RestaurantVO restaurantVO = restaurantService.restaurantDetail(fno);
      if(restaurantVO != null) {
         model.addAttribute("Restaurant", restaurantVO);
         model.addAttribute("Reviews", restaurantService.selectReviews(fno));
         return "restaurantDetail";
      } else {
         return "redirect:/list";
      }
      
   }
   
   @PostMapping("/registerReview")
   public String registerReview(Model model, RestaurantsReviewVO restReviewVO) {
      restaurantService.registerReview(restReviewVO);
      return "redirect:/restaurant/detail?fno=" + restReviewVO.getFno() ;
   }
   
   @PostMapping("/deleteReview")
    @ResponseBody  // 이 어노테이션은 JSON이나 텍스트 데이터를 응답으로 보내기 위해 사용됩니다.
    public String deleteReview(@RequestParam("frno") Long frno) {
      restaurantService.copyReview(frno);
      restaurantService.deleteReview(frno);
        // 성공적인 처리 후 응답 메시지를 반환
        return "리뷰 삭제 처리 완료";  // 클라이언트에게 전송될 응답
    }
   
   //윤정 파트
         @GetMapping("/rest_register")
          public String restaurantRegister() {
              return "rest_register"; // JSP 페이지로 이동
          }
         
         
         @PostMapping("/rest_register")
         public String restaurantRegister(RestaurantVO rest, RedirectAttributes redirectAttr, Model model, 
                                          @AuthenticationPrincipal UserDetails userDetails) {
             // 현재 로그인한 사용자의 권한 가져오기
             Collection<? extends GrantedAuthority> authorities = userDetails.getAuthorities();
             
             // 권한에 따라 ftype 값 설정
             if (authorities.stream().anyMatch(auth -> auth.getAuthority().equals("ROLE_ADMIN"))) {
                 rest.setFtype(0L); // 관리자일 경우 0으로 설정
             } else if (authorities.stream().anyMatch(auth -> 
                          auth.getAuthority().equals("ROLE_USER") || auth.getAuthority().equals("ROLE_BUSINESS"))) {
                 rest.setFtype(1L); // USER나 BUSINESS이면 1로 설정
             } else {
                 // 다른 권한일 경우 기본값을 설정하거나 예외 처리 가능
                 rest.setFtype(1L); // 기본적으로 USER나 BUSINESS로 간주
             }

             System.out.println("식당 등록 컨트롤러: " + rest);
             
             List<AttachFileDTO> attachFileList = rest.getAttachFileList();
             model.addAttribute("attachFileList", attachFileList);

             Long fno = null;
             if (attachFileList != null && !attachFileList.isEmpty()) {
                 attachFileList.forEach(attachFile -> System.out.println("첨부파일 확인: " + attachFile.toString()));
                 fno = restaurantService.registerRest(rest, attachFileList.get(0));
             } else {
                 System.out.println("controller:첨부파일 없음 ");
                 fno = restaurantService.registerRest(rest, null); // 첨부파일 없음
             }

             System.out.println("등록된 식당 번호: " + fno);
             redirectAttr.addFlashAttribute("result", fno);

             // USER_REGISTRATIONS 테이블에 등록
             userRegistrationService.registerUserRestaurant(userDetails.getUsername(), fno);

             return "redirect:/restaurant/rest_register";
         }


   
   
   
}
