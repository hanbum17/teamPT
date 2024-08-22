package com.teamproject.myteam01.controller;

import com.teamproject.myteam01.service.ListService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;
import java.util.Map;

@Controller
public class ListController {

    @Autowired
    private ListService listService;

    @GetMapping("/list")
    public String getCombinedList(
            @RequestParam(value = "pageNum", defaultValue = "1") int pageNum,
            @RequestParam(value = "pageSize", defaultValue = "10") int pageSize,
            @RequestParam(value = "searchType", required = false) String searchType,
            @RequestParam(value = "searchKeyword", required = false) String searchKeyword,
            @RequestParam(value = "filterType", defaultValue = "전체") String filterType,
            @RequestParam(value = "eventType", required = false) String eventType,
            Model model) {

        int startRow = (pageNum - 1) * pageSize + 1;
        int endRow = startRow + pageSize - 1;

        List<Map<String, Object>> combinedList = listService.getCombinedList(startRow, endRow, searchType, searchKeyword, filterType, eventType);
        int totalCount = listService.getTotalCount(searchType, searchKeyword, filterType, eventType);
        int totalPages = (int) Math.ceil((double) totalCount / pageSize);

        model.addAttribute("combinedList", combinedList);
        model.addAttribute("currentPage", pageNum);
        model.addAttribute("pageSize", pageSize);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("searchType", searchType);
        model.addAttribute("searchKeyword", searchKeyword);
        model.addAttribute("filterType", filterType);
        model.addAttribute("eventType", eventType);

        return "event/list";
    }
}
