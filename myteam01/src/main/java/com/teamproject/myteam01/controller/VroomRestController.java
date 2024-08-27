package com.teamproject.myteam01.controller;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.teamproject.myteam01.domain.EventVO;
import com.teamproject.myteam01.service.EventService;

import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
@RequestMapping("/vroom")
public class VroomRestController {

    private final EventService eventService;

    @GetMapping("/event/data")
    public ResponseEntity<String> getEventData() {
        List<EventVO> events = eventService.eventList();
        ObjectMapper mapper = new ObjectMapper();
        try {
            String json = mapper.writeValueAsString(events);
            return ResponseEntity.ok(json);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
            return ResponseEntity.status(500).body("Error processing JSON");
        }
    }
}
