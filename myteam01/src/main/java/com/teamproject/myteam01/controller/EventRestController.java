package com.teamproject.myteam01.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.teamproject.myteam01.domain.EventReviewVO;
import com.teamproject.myteam01.domain.EventVO;
import com.teamproject.myteam01.domain.RestaurantVO;
import com.teamproject.myteam01.domain.RestaurantsReviewVO;
import com.teamproject.myteam01.service.EventService;

import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;

@Tag(name = "EventController", description = "Event")
@RestController
@RequiredArgsConstructor
@RequestMapping("/eventRest")
public class EventRestController {

	private final EventService eventService ;
	
	@GetMapping("ehost")
	@ResponseBody
	public List<String> getEhost() {
		List<String> hostList = eventService.selectEHOST();
		return hostList;
	}
	
	@PostMapping(path = "/updateEventCoord", consumes = "application/json", produces = "application/json")
	@ResponseBody
	public ResponseEntity<Void> updateEventCoord(@RequestBody EventVO data) {
		System.out.println("updateEventCoord 컨트롤러 실행됨");
		System.out.println("ehost: " + data.getEhost() + " excoord: " + data.getExcoord() + " eycoord: " + data.getEycoord());
		eventService.updateEventCoord(data);
		
		return new ResponseEntity<> (HttpStatus.OK);
	}
	
	
	
}
