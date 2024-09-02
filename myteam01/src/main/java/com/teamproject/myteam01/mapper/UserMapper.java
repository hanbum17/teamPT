package com.teamproject.myteam01.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.teamproject.myteam01.domain.UserVO;

@Mapper
public interface UserMapper {

    // 사용자의 ID로 사용자 정보를 조회
    UserVO findByUsername(String username);

    // 사용자의 ID로 역할(Role)을 조회
    List<String> findRolesByUserId(String userId);

    // 사용자 정보를 데이터베이스에 삽입
    void insertUser(UserVO userVO);

    // 사용자 역할을 데이터베이스에 삽입
    void insertUserRole(@Param("userId") String userId, @Param("roleName") String roleName);

    // 사용자 계정의 활성화 상태를 업데이트
    void updateAccountStatus(@Param("userId") String userId, @Param("accountStatus") int accountStatus);

    // 마지막 로그인 날짜를 업데이트
    void updateLastLoginDate(String userId);

    // 사용자 정보를 업데이트
    void updateUser(UserVO userVO);
}
