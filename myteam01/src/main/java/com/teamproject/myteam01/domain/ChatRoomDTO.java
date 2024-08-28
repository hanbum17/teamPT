package com.teamproject.myteam01.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class ChatRoomDTO {

	private int roomId; //방번호(PK)
	private Long uno; //글번호(FK)
	private String userId1;
	private String userId2;
	private String title; 
}
