package com.teamproject.myteam01.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
//@AllArgsConstructor
@ToString
public class ChatRoomDTO {

	private Integer roomId; //방번호(PK)
	private Long uno; //글번호(FK)
	private String userId1;
	private String userId2;
	private String title; 
	
//	public Integer getRoomId() {
//        return roomId;
//    }
//	public void setRoomId(String roomId) {
//		this.roomId = Integer.parseInt(roomId);
//	}
//	public void setRoomId(Integer roomId) {
//		this.roomId = roomId;
//	}
}
