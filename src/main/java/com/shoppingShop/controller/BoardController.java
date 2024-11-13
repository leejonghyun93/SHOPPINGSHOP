package com.shoppingShop.controller;

import com.shoppingShop.domain.BoardDto;
import com.shoppingShop.service.BoardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/board")
public class BoardController {

    @Autowired
    private BoardService boardService;

    @GetMapping("/list")
    public String getBoardList(Model m) throws Exception {
        List<BoardDto> getBoardList = boardService.getBoardList();
        m.addAttribute("boardList",getBoardList);
        return "board/list";
    }
}
