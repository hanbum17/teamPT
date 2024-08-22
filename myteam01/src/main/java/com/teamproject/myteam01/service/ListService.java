package com.teamproject.myteam01.service;

import com.teamproject.myteam01.mapper.MyBoardMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ListService {

    @Autowired
    private MyBoardMapper myBoardMapper;

    public List<Map<String, Object>> getCombinedList(int startRow, int endRow, String searchType, String searchKeyword, String filterType, String eventType) {
        Map<String, Object> params = new HashMap<>();
        params.put("startRow", startRow);
        params.put("endRow", endRow);
        params.put("searchType", searchType);
        params.put("searchKeyword", searchKeyword);
        params.put("filterType", filterType);
        params.put("eventType", eventType);
        return myBoardMapper.getCombinedList(params);
    }

    public int getTotalCount(String searchType, String searchKeyword, String filterType, String eventType) {
        Map<String, Object> params = new HashMap<>();
        params.put("searchType", searchType);
        params.put("searchKeyword", searchKeyword);
        params.put("filterType", filterType);
        params.put("eventType", eventType);
        return myBoardMapper.getTotalCount(params);
    }
}
