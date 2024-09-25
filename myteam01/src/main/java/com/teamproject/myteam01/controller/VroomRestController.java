package com.teamproject.myteam01.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.teamproject.myteam01.domain.EventReviewVO;
import com.teamproject.myteam01.domain.EventVO;
import com.teamproject.myteam01.domain.RestaurantVO;
import com.teamproject.myteam01.domain.RestaurantsReviewVO;
import com.teamproject.myteam01.domain.UserVO;
import com.teamproject.myteam01.service.EventService;
import com.teamproject.myteam01.service.RestaurantService;
import com.teamproject.myteam01.service.UserService;

import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api")
public class VroomRestController {

	public final UserService userService;
    private final EventService eventService;
    private final RestaurantService restService;
    
    @GetMapping("/events")
    public List<EventVO> getEvents() {
        return eventService.eventList();
    }

//    @GetMapping("/reviews")
//    public String getEventReviews() {
//    	List<EventReviewVO> eventReviews = eventService.selectReviews();
//    }
    
    @GetMapping("/eventsPage")
    public String getEventsPage(Model model) {
        try {
            List<EventVO> events = eventService.eventList();
            String eventsJson = new ObjectMapper().writeValueAsString(events);
            System.out.println("Serialized JSON: " + eventsJson); // 직렬화된 JSON 로그
            model.addAttribute("eventsJson", eventsJson);
            return "vroom/vroomEvent"; // JSP 파일 이름
        } catch (JsonProcessingException e) {
            e.printStackTrace();
            System.out.println("Serialized JSON: 오류");
            return "error"; // 오류가 발생한 경우에 대한 처리
        }
    }
    
    //test
//  	@GetMapping("/getRestaurantReviews2")
//  	@ResponseBody
//  	public List<RestaurantsReviewVO> getRestaurantReviews2(@RequestParam("fno") Long fno,
//  														   @RequestParam("page") Long page,
//  														   @RequestParam("pageSize") Long pageSize,
//  														   Model model) {
//  		List<RestaurantsReviewVO> reviews = restService.selectReviews(fno);
//  	    return reviews;
//  	}

    @GetMapping("/getRestaurantReviews")

    public List<RestaurantsReviewVO> getRestaurantReviews( @RequestParam Long fno,
            												@RequestParam Long page,
            												@RequestParam Long pageSize) {
        
        RestaurantsReviewVO restReviewVO = new RestaurantsReviewVO();
        restReviewVO.setFno(fno);
        restReviewVO.setPage(page);
        restReviewVO.setPageSize(pageSize);
        
        // 데이터 조회 로직
        List<RestaurantsReviewVO> reviews = restService.selectMoreReviews(restReviewVO);
        
        return reviews;
    }

    //스크롤시 추가 데이터 보내기
    @GetMapping("/restaurant/more")
    public List<RestaurantVO> restMain(@AuthenticationPrincipal UserDetails userDetails, 
                           @RequestParam(value = "page", defaultValue = "1") Long page, 
                           @RequestParam(value = "pageSize", defaultValue = "12") Long pageSize,
                           Model model) {
    	
        // 현재 로그인된 사용자의 ID를 이용해 사용자 정보 조회
        if (userDetails != null) {
            String userId = userDetails.getUsername();
            UserVO user = userService.findByUsername(userId);
            model.addAttribute("user", user);
        }
        System.out.println("page"+page);
        // 식당 목록 추가
        List<RestaurantVO> restList = restService.getRestList(page, pageSize);
        System.out.println(restList);
        
        return restList ;
    }
    
    @GetMapping("/event")
    public List<EventVO> eventMain(@AuthenticationPrincipal UserDetails userDetails, 
                           @RequestParam(value = "page", defaultValue = "1") Long page, 
                           @RequestParam(value = "pageSize", defaultValue = "12") Long pageSize,
                           Model model) {
        // 현재 로그인된 사용자의 ID를 이용해 사용자 정보 조회
        if (userDetails != null) {
            String userId = userDetails.getUsername();
            UserVO user = userService.findByUsername(userId);
            model.addAttribute("user", user);
        }
        System.out.println("page"+page);
        // 식당 목록 추가
        List<EventVO> restList = eventService.getEventList(page, pageSize);
        System.out.println(restList);
        
        return restList ;
    }
    
    
    @GetMapping("/getEventReviews")
    public List<EventReviewVO> getEventReviews( @RequestParam Long eno,
            												@RequestParam Long page,
            												@RequestParam Long pageSize) {
    	EventReviewVO eventReviewVO = new EventReviewVO();
    	eventReviewVO.setEno(eno);
    	eventReviewVO.setPage(page);
    	eventReviewVO.setPageSize(pageSize);
        // 데이터 조회 로직
        List<EventReviewVO> reviews = eventService.selectMoreReviews(eventReviewVO);
        return reviews;
    }
    
    @GetMapping("/images/{filename:.+}")
    public ResponseEntity<Resource> getImage(@PathVariable String filename) {
        try {
            String uploadPath = "C:/myupload"; // 실제 경로를 가져오는 방법을 사용해야 함
            String fullPath = uploadPath + "/" + filename;

            Resource resource = new FileSystemResource(fullPath);
            if (!resource.exists()) {
                return new ResponseEntity<>(HttpStatus.NOT_FOUND);
            }
            HttpHeaders headers = new HttpHeaders();
            headers.add(HttpHeaders.CONTENT_TYPE, "image/jpeg"); // 실제 파일 타입에 맞게 설정
            return new ResponseEntity<>(resource, headers, HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @GetMapping("/executePythonScripts")
    @ResponseBody
    public Map<String, Object> executePythonScripts() {
        Map<String, Object> response = new HashMap<>();
        StringBuilder combinedOutput = new StringBuilder();

        try {
            // 첫 번째 Python 스크립트 실행
            ProcessBuilder processBuilder1 = new ProcessBuilder("python", "C:/myPython/PyvirtualEnvs/PyWebCrawlingEnv/crawling/yourpro01/사용자_식당추천.py");
            Process process1 = processBuilder1.start();
            
            // 결과 읽기
            BufferedReader reader1 = new BufferedReader(new InputStreamReader(process1.getInputStream()));
            String line;
            while ((line = reader1.readLine()) != null) {
                combinedOutput.append(line).append("\n");
            }
            int exitCode1 = process1.waitFor();
            response.put("exitCode1", exitCode1);
            
            // 두 번째 Python 스크립트 실행
            ProcessBuilder processBuilder2 = new ProcessBuilder("python", "C:/myPython/PyvirtualEnvs/PyWebCrawlingEnv/crawling/yourpro01/사용자_행사추천.py");
            Process process2 = processBuilder2.start();
            
            // 결과 읽기
            BufferedReader reader2 = new BufferedReader(new InputStreamReader(process2.getInputStream()));
            while ((line = reader2.readLine()) != null) {
                combinedOutput.append(line).append("\n");
            }
            int exitCode2 = process2.waitFor();
            response.put("exitCode2", exitCode2);

            // 두 스크립트의 출력 통합
            response.put("output", combinedOutput.toString());
        } catch (Exception e) {
            response.put("error", e.getMessage());
        }
        return response;
    }

    
}
