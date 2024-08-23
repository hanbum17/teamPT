package com.teamproject.myteam01.domain;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class UserVO {
    private Long userNo;
    private String userId;
    private String userPw;
    private String userName;
    private char userGender;
    private String userCall;
    private String userAddress;
    private String userEmail;
    private int userType;
    private Timestamp joinDate; 
    private Timestamp lastLoginDate; 
}
