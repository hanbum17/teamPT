package com.teamproject.myteam01.mapper;

import com.teamproject.myteam01.domain.UserVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface UserMapper {
    void insertUser(UserVO user);
    UserVO findByUsername(String username);
    void updateLastLoginDate(String userId);
    
    void insertUserRole(@Param("userId") String userId, @Param("roleName") String roleName);
}
