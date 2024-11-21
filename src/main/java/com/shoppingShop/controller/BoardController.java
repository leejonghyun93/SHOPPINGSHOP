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
            @RequestParam(value = "pageNum", defaultValue = "1") int pageNum,
            @RequestParam(value = "pageSize", defaultValue = "10") int pageSize,
            @RequestParam(value = "search", required = false) String search,
            @RequestParam(value = "sort", defaultValue = "latest") String sort,
            Model model) {

        List<BoardDto> boardList = boardService.getBoardList(pageNum, pageSize, search, sort);
        int totalRecords = boardService.getBoardCount(search);

        // 페이지 정보 및 게시글 총 건수 추가
        model.addAttribute("boardList", boardList);
        model.addAttribute("totalRecords", totalRecords);
        model.addAttribute("pageNum", pageNum);
        model.addAttribute("pageSize", pageSize);
        model.addAttribute("search", search);
        model.addAttribute("sort", sort);

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
