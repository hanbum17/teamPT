package com.teamproject.myteam01.mapper;

import com.teamproject.myteam01.domain.UserVO;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface UserMapper {
    void insertUser(UserVO user);
    UserVO findByUsername(String username);
}
