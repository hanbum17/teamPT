package com.teamproject.myteam01.mapper;

import java.util.List;

import com.teamproject.myteam01.domain.ChatMessageDTO;
import com.teamproject.myteam01.domain.ChatRoomDTO;

public interface ChatMapper {

	//록귀
	public void insertChat(ChatMessageDTO chat);
	public List<ChatMessageDTO> selectChatList(int roomId);
	public List<ChatRoomDTO> selectChatRoomList(String username);
	public String selectChatRoomTitle(int roomId);
}
 