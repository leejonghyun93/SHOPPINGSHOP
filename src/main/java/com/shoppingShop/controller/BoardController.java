package com.shoppingShop.controller;

import com.shoppingShop.domain.BoardDto;
import com.shoppingShop.service.BoardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@RequestMapping("/board")
public class BoardController {

    @Autowired
    private BoardService boardService;

    @GetMapping("/list")
    public String getBoardList(
            @RequestParam(defaultValue = "1") int pageNum,
            @RequestParam(defaultValue = "10") int pageSize,
            Model m) throws Exception {

        List<BoardDto> boardList = boardService.getBoardList(pageNum, pageSize);
        int totalRecords = boardService.getBoardCount(); // 총 게시글 수

        m.addAttribute("boardList", boardList);
        m.addAttribute("totalRecords", totalRecords);
        m.addAttribute("pageNum", pageNum);
        m.addAttribute("pageSize", pageSize);

        return "board/list";
    }
}
