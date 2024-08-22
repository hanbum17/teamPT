package com.teamproject.myteam01.mapper;

import java.util.Date;
import java.util.List;
import java.util.Map;

import com.teamproject.myteam01.domain.BoardVO;

public interface MyBoardMapper {
	
    public Date showMyDate();
    public List<BoardVO> selectBaordList();

    List<Map<String, Object>> getCombinedList(Map<String, Object> params);
    int getTotalCount(Map<String, Object> params);
} 
