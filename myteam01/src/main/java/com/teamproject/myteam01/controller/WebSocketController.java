package com.teamproject.myteam01.controller;

import java.text.SimpleDateFormat;

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
	private int userCnt = 0;
	
	@GetMapping("/chat/chat")
	public String chat() {
		return "chat" ;
	}
	
	//입장
	@MessageMapping("/chat/enter")
	public void enter(@RequestBody ChatMessageDTO chat) {
		userCnt++;
		updateUserCnt();
		SimpleDateFormat smpDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String fmtDate = smpDate.format(chat.getDate());
		System.out.println("sender: " + chat.getSender() + " content: " + chat.getContent() + " date: " + fmtDate);
		messagingTemplate.convertAndSend("/sub/chat/room/1", chat);
	}
	//퇴장
	@MessageMapping("/chat/leave")
	public void leave(@RequestBody ChatMessageDTO chat) {
		userCnt--;
		updateUserCnt();
		SimpleDateFormat smpDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String fmtDate = smpDate.format(chat.getDate());
		System.out.println("sender: " + chat.getSender() + " content: " + chat.getContent() + " date: " + fmtDate);
		messagingTemplate.convertAndSend("/sub/chat/room/1", chat);
	}
	//전송
	@MessageMapping("/chat/message")
	public void message(@RequestBody ChatMessageDTO chat) {
		SimpleDateFormat smpDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String fmtDate = smpDate.format(chat.getDate());
		System.out.println("sender: " + chat.getSender() + " content: " + chat.getContent() + " date: " + fmtDate);
		messagingTemplate.convertAndSend("/sub/chat/room/1", chat);
    }
	
	private void updateUserCnt() {
		messagingTemplate.convertAndSend("/sub/chat/userCnt", userCnt);
	}
	
}
