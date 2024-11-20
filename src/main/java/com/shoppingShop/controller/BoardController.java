package com.shoppingShop.controller;

import com.shoppingShop.domain.BoardDto;
import com.shoppingShop.service.BoardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
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
            @RequestParam(defaultValue = "1") int pageNum,             // 현재 페이지 번호
            @RequestParam(defaultValue = "10") int pageSize,           // 페이지당 게시글 수
            @RequestParam(defaultValue = "latest") String sort,        // 정렬 기준
            Model model) throws Exception {

        // 게시글 리스트 가져오기
        List<BoardDto> boardList = boardService.getBoardList(pageNum, pageSize, sort);
        int totalRecords = boardService.getBoardCount(); // 총 게시글 수

        model.addAttribute("boardList", boardList);
        model.addAttribute("totalRecords", totalRecords);
        model.addAttribute("pageNum", pageNum);
        model.addAttribute("pageSize", pageSize);
        model.addAttribute("sort", sort); // 현재 정렬 기준 전달

        return "board/list";
    }

    @GetMapping("/view/{noticeId}")
    public String viewNotice(
            @PathVariable("noticeId") int noticeId,
            Model model) throws Exception {

        // 공지사항 상세보기 및 이전/다음 공지사항 가져오기
        BoardDto notice = boardService.getNoticeById(noticeId);
        BoardDto previousNotice = boardService.getPreviousNotice(noticeId);
        BoardDto nextNotice = boardService.getNextNotice(noticeId);

        model.addAttribute("notice", notice);
        model.addAttribute("previousNotice", previousNotice);
        model.addAttribute("nextNotice", nextNotice);

        return "board/view";
    }
}
