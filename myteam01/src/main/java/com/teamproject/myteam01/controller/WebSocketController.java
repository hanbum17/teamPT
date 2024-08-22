package com.teamproject.myteam01.controller;

import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;

import com.teamproject.myteam01.domain.ChatMessageDTO;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class WebSocketController {

	private final SimpMessagingTemplate messagingTemplate ;
	
	@GetMapping("/chat/chat")
	public String chat() {
		return "chat" ;
	}
	
	//입장
	@MessageMapping("/chat/enter")
	public void enter(@RequestBody ChatMessageDTO chat) {
		System.out.println("sender: " + chat.getSender() + " content: " + chat.getContent());
		messagingTemplate.convertAndSend("/sub/chat/room/1", chat);
	}
	//퇴장
	@MessageMapping("/chat/leave")
	public void leave(@RequestBody ChatMessageDTO chat) {
		System.out.println("sender: " + chat.getSender() + " content: " + chat.getContent());
		messagingTemplate.convertAndSend("/sub/chat/room/1", chat);
	}
	//전송
	@MessageMapping("/chat/message")
	public void message(@RequestBody ChatMessageDTO chat) {
		System.out.println("sender: " + chat.getSender() + " content: " + chat.getContent());
		messagingTemplate.convertAndSend("/sub/chat/room/1", chat);
    }
	
}
