package com.teamproject.myteam01.controller;

import java.io.File;
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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.teamproject.myteam01.domain.CsVO;
import com.teamproject.myteam01.domain.EventVO;
import com.teamproject.myteam01.domain.RestaurantVO;
import com.teamproject.myteam01.domain.TripPlanVO;
import com.teamproject.myteam01.domain.UserVO;
import com.teamproject.myteam01.service.CsService;
import com.teamproject.myteam01.service.TripService;
import com.teamproject.myteam01.service.UserRegistrationService;
import com.teamproject.myteam01.service.UserService;

import jakarta.servlet.http.HttpServletResponse;

@Controller
public class UserController {

    @Autowired
    private UserService userService;
    
    @Autowired
    private UserRegistrationService userRegistrationService;
    
    @Autowired
    private TripService tripService;
    
    @Autowired
    private CsService csService;
    
    

    @GetMapping("/user/registerSelect")
    public String showRegisterSelectPage() {
        return "user/registerSelect";
    }
    
    @GetMapping("/user/register")
    public String showRegisterForm(@RequestParam("role") String role, Model model) {
        System.out.println("Received role: " + role);
        model.addAttribute("role", role);
        return "user/register";
    }

    @PostMapping("/user/register")
    public String registerUser(UserVO user, @RequestParam("role") String role, RedirectAttributes redirectAttributes) {
        // 사용자 ID 중복 확인
        if (userService.isUserIdDuplicate(user.getUserId())) {
            redirectAttributes.addFlashAttribute("error", "이미 사용 중인 ID입니다.");
            return "redirect:/user/register?role="+ role;  // 로그인 페이지로 이동
        }

        // 사용자 등록
        userService.registerUser(user);

        // 사용자 역할 설정
        userService.registerUserRole(user.getUserId(), role);
        
        redirectAttributes.addFlashAttribute("message", "회원가입이 성공적으로 완료되었습니다.");
        return "redirect:/user/login";
    }

    @GetMapping("/user/login")
    public String showLoginForm() {
        return "user/login";
    }
    
    
    @GetMapping("/user/main")
    public String userPage(@AuthenticationPrincipal UserDetails userDetails, Model model) {
        // 현재 로그인된 사용자 정보를 모델에 추가할 수 있습니다.
        model.addAttribute("username", userDetails.getUsername());
        
        return "redirect:/user/user_detail";
    }
    
    // 사용자 상세 정보 페이지로 이동
    @GetMapping("/user/user_detail")
    public String userDetailPage(@AuthenticationPrincipal UserDetails userDetails, Model model) {
        // UserDetails에서 username을 가져와서 UserVO 객체를 가져옵니다.
        UserVO user = userService.findByUsername(userDetails.getUsername());
        model.addAttribute("user", user);
        return "user_main/user_menu/user_detail"; // 해당 JSP 페이지로 이동
    }
    
    @PostMapping("/user/changePassword")
    public String changePassword(@AuthenticationPrincipal UserDetails userDetails,
                                 @RequestParam("oldPassword") String oldPassword,
                                 @RequestParam("newPassword") String newPassword,
                                 @RequestParam("confirmPassword") String confirmPassword,
                                 RedirectAttributes redirectAttributes) {
        UserVO user = userService.findByUsername(userDetails.getUsername());

        // 현재 비밀번호가 맞는지 확인
        if (!userService.checkPassword(user, oldPassword)) {
            redirectAttributes.addFlashAttribute("error", "현재 비밀번호가 일치하지 않습니다.");
            return "redirect:/user/user_detail";
        }

        // 새 비밀번호와 확인 비밀번호가 일치하는지 확인
        if (!newPassword.equals(confirmPassword)) {
            redirectAttributes.addFlashAttribute("error", "새 비밀번호가 일치하지 않습니다.");
            return "redirect:/user/user_detail";
        }

        // 비밀번호 변경
        userService.changePassword(user, newPassword);
        redirectAttributes.addFlashAttribute("message", "비밀번호가 성공적으로 변경되었습니다.");

        return "redirect:/user/user_detail";
    }

    // 즐겨찾기 목록 페이지로 이동
    @GetMapping("/user/user_fav")
    public String userFavPage() {
        return "redirect:/user/user_fav_lists";
    }

    // 여행 계획 세우기 페이지로 이동
    @GetMapping("/user/user_trip")
    public String userTripPage(@AuthenticationPrincipal UserDetails userDetails, Model model) {
        String userId = userDetails.getUsername();
       
        List<TripPlanVO> tripPlans = tripService.getTripPlansByUserId(userId);
        model.addAttribute("tripPlans", tripPlans);
        
        return "user_main/user_menu/user_trip_list";
    }

    // 등록한 행사 및 음식점 페이지로 이동
    @GetMapping("/user/user_register")
    public String getRegisteredItems(@AuthenticationPrincipal UserDetails userDetails, Model model) {
        String userId = userDetails.getUsername();
        List<Map<String, Object>> registeredItems = userRegistrationService.getUserRegistrations(userId);
        
     // 디버깅을 위해 출력해봅시다.
        System.out.println("등록된 항목: " + registeredItems);
        model.addAttribute("registeredItems", registeredItems);
        return "user_main/user_menu/user_register";
    }

    // 등록한 리뷰 내역 페이지로 이동
    @GetMapping("/user/user_review")
    public String userReviewPage(@AuthenticationPrincipal UserDetails userDetails, Model model) {
        String userId = userDetails.getUsername();  // userId를 가져옴

        // 행사 리뷰 조회
        List<Map<String, Object>> eventReviews = userRegistrationService.getUserEventReviewsByUserId(userId);
        
        // 음식점 리뷰 조회
        List<Map<String, Object>> restaurantReviews = userRegistrationService.getUserRestaurantReviewsByUserId(userId);

        // 모델에 추가
        model.addAttribute("eventReviews", eventReviews);
        model.addAttribute("restaurantReviews", restaurantReviews);

        return "user_main/user_menu/user_review";
    }

    // 예약 내역 페이지로 이동
    @GetMapping("/user/user_reservation")
    public String userReservationPage() {
        return "user_main/user_menu/user_reservation";
    }
    
       

    // 결제 내역 페이지로 이동
    @GetMapping("/user/user_pay")
    public String userPayPage() {
        return "user_main/user_menu/user_pay";
    }

    // 문의 내역 페이지로 이동
    @GetMapping("/user/user_inquiry")
    public String userInquiryPage(@AuthenticationPrincipal UserDetails userDetails, Model model) {
        String userId = userDetails.getUsername();
        
        // 1대1 문의 내역 조회
        List<CsVO> inquiries = csService.getUserInquiries(userId);
        model.addAttribute("inquiries", inquiries);
        

        
        return "user_main/user_menu/user_inquiry";  // 1대1 문의 및 건의사항 페이지로 이동
    }

    // 비지니스 - 등록된 사업 정보 페이지로 이동 (ADMIN, BUSINESS 권한만)
    @GetMapping("/user/user_business")
    public String userBusinessPage(@AuthenticationPrincipal UserDetails userDetails) {
        if (userDetails.getAuthorities().stream()
                .anyMatch(auth -> auth.getAuthority().equals("ROLE_ADMIN") || auth.getAuthority().equals("ROLE_BUSINESS"))) {
            return "user_main/user_menu/user_business";
        }
        return "redirect:/accessDenied"; // 권한이 없는 경우 접근 불가 페이지로 리다이렉트
    }

    @PostMapping("/user/deleteAccount")
    public String deleteAccount(@AuthenticationPrincipal UserDetails userDetails) {
        String userId = userDetails.getUsername();
        userService.deactivateAccount(userId);
        return "redirect:/logout"; // 로그아웃 처리 후 메인 페이지로 리다이렉트
    }

    
    //영범
    // 추천 목록 페이지로 이동
    @GetMapping("/user/user_recommend")
	public String userRecommend(@AuthenticationPrincipal UserDetails userDetails, Model model) {
		String userName = userDetails.getUsername();
		model.addAttribute("userName",userName);
		
		//행사 추천 리스트
		List<EventVO> eventList = userService.recomendEvent(userName);
		model.addAttribute("eventList",eventList);
		
		//식당 추천 리스트
		List<RestaurantVO> restList = userService.recomendRest(userName);
		model.addAttribute("restList",restList);
		
		//행사 추천 타입 ex) 지역추천 , 무료추천
		if(!eventList.isEmpty()) {
			EventVO eRecoType = eventList.get(0);
			model.addAttribute("eRecoType",eRecoType.getEtype());
		}
		
		//식당 추천 타입 ex) 지역추천 , 무료추천
		if(!restList.isEmpty()) {
			RestaurantVO fRecoType = restList.get(0);
			model.addAttribute("fRecoType",fRecoType.getType());
		}
		return "user_main/user_menu/user_recommend";
	}

    //파이썬실행
    // Python 스크립트 실행
    @PostMapping("/executePythonScripts")
    public void executePythonScripts(@AuthenticationPrincipal UserDetails userDetails, HttpServletResponse response) {
        String userName = userDetails.getUsername();

        try {
            // 첫 번째 스크립트 실행
            ProcessBuilder processBuilder1 = new ProcessBuilder(
                    "python",
                    "C:/myPython/PyvirtualEnvs/PyWebCrawlingEnv/crawling/yourpro01/사용자_행사추천.py",
                    userName
            );
            processBuilder1.redirectErrorStream(true); // 오류를 표준 출력으로 리디렉션
            Process process1 = processBuilder1.start();
            process1.waitFor(); // 첫 번째 프로세스 종료 대기

            // 두 번째 스크립트 실행
            ProcessBuilder processBuilder2 = new ProcessBuilder(
                    "python",
                    "C:/myPython/PyvirtualEnvs/PyWebCrawlingEnv/crawling/yourpro01/사용자_식당추천.py",
                    userName
            );
            processBuilder2.redirectErrorStream(true); // 오류를 표준 출력으로 리디렉션
            Process process2 = processBuilder2.start();
            process2.waitFor(); // 두 번째 프로세스 종료 대기

            // 성공적으로 실행되었으면 HTTP 200 응답
            response.setStatus(HttpServletResponse.SC_OK);
        } catch (Exception e) {
            // 오류가 발생하면 HTTP 500 응답
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            e.printStackTrace(); // 로그에 오류 출력 (이 부분은 필요에 따라 유지할 수 있음)
        }
    }

        
 
    
}
