package com.teamproject.myteam01.mapper;

import java.util.List;

import com.teamproject.myteam01.domain.ChatMessageDTO;

public interface ChatMapper {

	//록귀
	public void insertChat(ChatMessageDTO chat);
	public List<ChatMessageDTO> selectChatList(int roomId);
	
}
 