package com.teamproject.myteam01.domain;

import java.sql.Date;

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
public class UserRegistrationVO {
    private Long id;
    private String userId;
    private Long itemId;
    private String itemType;
    private Date registerDate;

    // Getters and Setters
}