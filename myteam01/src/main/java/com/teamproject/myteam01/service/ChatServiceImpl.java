package com.teamproject.myteam01.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.teamproject.myteam01.domain.ChatMessageDTO;
import com.teamproject.myteam01.domain.ChatRoomDTO;
import com.teamproject.myteam01.domain.EventReviewVO;
import com.teamproject.myteam01.domain.EventVO;
import com.teamproject.myteam01.domain.RestaurantsReviewVO;
import com.teamproject.myteam01.mapper.ChatMapper;
import com.teamproject.myteam01.mapper.EventMapper;

import lombok.RequiredArgsConstructor;


@Service
@RequiredArgsConstructor
public class ChatServiceImpl implements ChatService{

	private final ChatMapper chatMapper ;

	@Override
	public void insertChat(ChatMessageDTO chat) {
		chatMapper.insertChat(chat);
	}

	@Override
	public List<ChatMessageDTO> selectChatList(int roomId) {
		return chatMapper.selectChatList(roomId);
	}

	@Override
	public List<ChatRoomDTO> selectChatRoomList(String username) {
		return chatMapper.selectChatRoomList(username);
	}

	@Override
	public String selectChatRoomTitle(int roomId) {
		return chatMapper.selectChatRoomTitle(roomId);
	}

	@Override
	public Integer createChatRoom(String username) {
		return chatMapper.createChatRoom(username);
	}

	@Override
	public ChatRoomDTO selectAdminChatRoom(String username) {
		return chatMapper.selectAdminChatRoom(username);
	}
	
}
