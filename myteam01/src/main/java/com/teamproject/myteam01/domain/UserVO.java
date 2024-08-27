package com.teamproject.myteam01.domain;

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
    private String userId;
    private String userPw;
    private String userName;
    private char userGender;
    private String userCall;
    private String userAddress;
    private String userEmail;
    private int userType;
}
