package com.teamproject.myteam01.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;


import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;

import com.teamproject.myteam01.domain.ChatMessageDTO;
import com.teamproject.myteam01.domain.ChatRoomDTO;
import com.teamproject.myteam01.service.ChatService;
import com.teamproject.myteam01.service.RestaurantService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class WebSocketController {

	private final ChatService chatService;
	private final RestaurantService restService;
	private final SimpMessagingTemplate messagingTemplate ;
	private int userCnt = 0;
	
	@GetMapping("/chat/chat")
	public String chat() {
		return "chat";
	}
	
	@GetMapping("/chat/chatPage")
	public String chatPage(String username, Model model) {
		username = "user4";
		List<ChatRoomDTO> chatList = chatService.selectChatRoomList(username) ;
		System.out.println(chatList);
		model.addAttribute("chatList", chatList);
		
		return "chatPage";
	}
	
	//입장
	@MessageMapping("/chat/enter")
	public void enter(@RequestBody ChatMessageDTO chat) {
		userCnt++;
		updateUserCnt();

		
		System.out.println(chatMessageList(chat.getRoomId()));
		
		SimpleDateFormat smpDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String fmtDate = smpDate.format(chat.getDate());
		System.out.println("sender: " + chat.getUsername() + " content: " + chat.getContent() + " date: " + fmtDate);

		messagingTemplate.convertAndSend("/sub/chat/room/1", chat);
	}
	//퇴장
	@MessageMapping("/chat/leave")
	public void leave(@RequestBody ChatMessageDTO chat) {
		userCnt--;
		updateUserCnt();

		SimpleDateFormat smpDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String fmtDate = smpDate.format(chat.getDate());
		System.out.println("sender: " + chat.getUsername() + " content: " + chat.getContent() + " date: " + fmtDate);

		messagingTemplate.convertAndSend("/sub/chat/room/1", chat);
	}
	//전송
	@MessageMapping("/chat/message")
	public void message(@RequestBody ChatMessageDTO chat) {
		SimpleDateFormat smpDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String fmtDate = smpDate.format(chat.getDate());

		
		chatService.insertChat(chat);
		
		System.out.println("sender: " + chat.getUsername() + " content: " + chat.getContent() + " date: " + fmtDate);

		messagingTemplate.convertAndSend("/sub/chat/room/1", chat);
    }
	//이전채팅목록 불러오기
	private List<ChatMessageDTO> chatMessageList(int roomId) {
		messagingTemplate.convertAndSend("/sub/chat/chatList", chatService.selectChatList(roomId));
		return chatService.selectChatList(roomId);
	}
	
	//접속유저수 변환
	private void updateUserCnt() {
		messagingTemplate.convertAndSend("/sub/chat/userCnt", userCnt);
	}
	
}
