package com.teamproject.myteam01.controller;

import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;


import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.security.core.session.SessionRegistry;
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
	
	//채팅방 페이지
	@GetMapping("/chat/chat")
	public String chat(int roomId, Model model, Principal principal) {
		System.out.println("/chat/chat 실행됨.");
		model.addAttribute("roomId", roomId);
		model.addAttribute("chatRoomTitle", chatService.selectChatRoomTitle(roomId));
		model.addAttribute("username", principal.getName());
		return "chat";
	}
	
	@GetMapping("/chat/adminChat")
	public String adminChatPage(Principal principal, Model model) {
		String username = principal.getName();
		ChatRoomDTO chatRoom = chatService.selectAdminChatRoom(username);
		
		if(chatRoom == null) {
			System.out.println("방없음");
			chatRoom = new ChatRoomDTO();
			chatService.createChatRoom(username);
			chatRoom.setRoomId(chatService.selectAdminChatRoom(username).getRoomId());
			System.out.println(chatRoom.getRoomId());
		}
		
		int roomId = chatRoom.getRoomId();
		model.addAttribute("roomId", roomId);
		model.addAttribute("chatRoomTitle", "관리자와 실시간 상담");
		model.addAttribute("username", principal.getName());
		
		return "chat";
	}
	
	//내가 참여한 채팅방 리스트 조회 페이지
	@GetMapping("/chat/chatPage")
	public String chatPage(String username, Model model) {
		username = "user4";
		List<ChatRoomDTO> chatList = chatService.selectChatRoomList(username) ;
		System.out.println(chatList);
		model.addAttribute("chatList", chatList);
		return "chatPage";
	}
	
	//이전채팅기록 가져오기
//	private List<ChatMessageDTO> chatMessageList(int roomId) {
//		messagingTemplate.convertAndSend("/sub/chat/chatHistory", chatService.selectChatList(roomId));
//		System.out.println(chatService.selectChatList(roomId));
//		return chatService.selectChatList(roomId);
//	}
	 
	//입장
	@MessageMapping("/chat/enter")
	public void enter(@RequestBody ChatMessageDTO chat, Principal principal) {
		userCnt++;
		updateUserCnt();
		int roomId = chat.getRoomId();
		
		String username = principal.getName();
		System.out.println("username: " + username);
		
		//입장 시 채팅기록을 입장한 유저에게만 전송
		List<ChatMessageDTO> chatHistory = chatService.selectChatList(roomId);
		System.out.println("chatHistory: " + chatHistory);
//		messagingTemplate.convertAndSendToUser(username, "/user/queue/chatHistory", chatHistory);
		messagingTemplate.convertAndSend("/sub/chat/chatHistory"+roomId , chatHistory);
		
		
		SimpleDateFormat smpDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String fmtDate = smpDate.format(chat.getSendDate());
		System.out.println("username: " + chat.getUsername() + " content: " + chat.getContent() + " date: " + fmtDate + " roomId: " + roomId);

		//입장 시 모든유저에게 입장알림메세지 전송
		messagingTemplate.convertAndSend("/sub/chat/room/" + roomId, chat);
	}
	
	//퇴장
	@MessageMapping("/chat/leave")
	public void leave(@RequestBody ChatMessageDTO chat) {
		userCnt--;
		updateUserCnt();
		int roomId = chat.getRoomId();
		
		SimpleDateFormat smpDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String fmtDate = smpDate.format(chat.getSendDate());
		System.out.println("username: " + chat.getUsername() + " content: " + chat.getContent() + " date: " + fmtDate + " roomId: " + roomId);

		messagingTemplate.convertAndSend("/sub/chat/room/" + roomId , chat);
	}
	
	//전송
	@MessageMapping("/chat/message")
	public void message(@RequestBody ChatMessageDTO chat) {
		SimpleDateFormat smpDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String fmtDate = smpDate.format(chat.getSendDate());
		
		int roomId = chat.getRoomId();
		
		chatService.insertChat(chat);
		
		System.out.println("username: " + chat.getUsername() + " content: " + chat.getContent() + " date: " + fmtDate + " roomId: " + roomId);

		messagingTemplate.convertAndSend("/sub/chat/room/" + roomId , chat);
    }
	
	//접속유저수 변환
	private void updateUserCnt() {
		messagingTemplate.convertAndSend("/sub/chat/userCnt", userCnt);
	}
	
}
