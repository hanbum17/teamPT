package com.teamproject.myteam01.domain;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Getter
@ToString
public class ChatMessageDTO {

	private Long cno; // 채팅번호
	private int roomId; // 방번호(FK)
    private String username; //userId
    private String content; // 내용
    private Date date; // 보낸날짜시간
}