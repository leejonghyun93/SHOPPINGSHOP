package com.shoppingShop.controller;

// 필요한 클래스 임포트
import com.shoppingShop.domain.BoardDto;
import com.shoppingShop.service.BoardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;
import java.util.List;

// Spring MVC 컨트롤러로 지정
@Controller
// URL이 "/board"로 시작하는 요청을 처리하는 컨트롤러
@RequestMapping("/board")
public class BoardController {

    // BoardService 자동 주입 (DI)
    @Autowired
    private BoardService boardService;

    /**
     * 게시판 목록 조회
     * URL: /board/list
     * @param pageNum 현재 페이지 번호 (기본값: 1)
     * @param pageSize 페이지당 표시할 게시글 수 (기본값: 10)
     * @param search 검색어 (선택 사항)
     * @param sort 정렬 방식 (기본값: 최신순)
     * @param model 뷰에 데이터를 전달하는 객체
     * @return 게시판 목록 페이지 (board/list.jsp)
     */
    @GetMapping("/list")
    public String getBoardList(
            @RequestParam(value = "pageNum", defaultValue = "1") int pageNum, // 현재 페이지 번호 (기본값: 1)
            @RequestParam(value = "pageSize", defaultValue = "10") int pageSize, // 한 페이지당 게시글 개수 (기본값: 10)
            @RequestParam(value = "search", required = false) String search, // 검색어 (선택 사항)
            @RequestParam(value = "sort", defaultValue = "latest") String sort, // 정렬 방식 (기본값: 최신순)
            Model model) { // JSP에 데이터를 전달할 Model 객체

        // 게시글 목록 조회 (검색어, 정렬 방식, 페이지네이션 적용)
        List<BoardDto> boardList = boardService.getBoardList(pageNum, pageSize, search, sort);

        // 검색 조건을 포함한 전체 게시글 개수 조회
        int totalRecords = boardService.getBoardCount(search);

        // 뷰로 전달할 데이터 추가
        model.addAttribute("boardList", boardList); // 게시글 목록 추가
        model.addAttribute("totalRecords", totalRecords); // 총 게시글 개수 추가
        model.addAttribute("pageNum", pageNum); // 현재 페이지 번호 추가
        model.addAttribute("pageSize", pageSize); // 페이지당 게시글 수 추가
        model.addAttribute("search", search); // 검색어 추가
        model.addAttribute("sort", sort); // 정렬 방식 추가

        // board/list.jsp 페이지로 이동
        return "board/list";
    }

    /**
     * 공지사항 상세보기
     * URL: /board/view/{noticeId}
     * @param noticeId 공지사항 ID
     * @param model 뷰에 데이터를 전달하는 객체
     * @return 공지사항 상세 페이지 (board/view.jsp)
     * @throws Exception 예외 발생 시 처리
     */
    @GetMapping("/view/{noticeId}")
    public String viewNotice(
            @PathVariable("noticeId") int noticeId, // URL 경로 변수에서 noticeId 값을 가져옴
            Model model) throws Exception { // JSP로 데이터를 전달하기 위한 Model 객체

        // 공지사항 상세 정보 조회
        BoardDto notice = boardService.getNoticeById(noticeId);

        // 이전 공지사항 조회 (이전 글이 없으면 null)
        BoardDto previousNotice = boardService.getPreviousNotice(noticeId);

        // 다음 공지사항 조회 (다음 글이 없으면 null)
        BoardDto nextNotice = boardService.getNextNotice(noticeId);

        // 모델에 데이터 추가하여 JSP에서 사용 가능하도록 설정
        model.addAttribute("notice", notice); // 현재 공지사항 데이터 추가
        model.addAttribute("previousNotice", previousNotice); // 이전 공지사항 추가
        model.addAttribute("nextNotice", nextNotice); // 다음 공지사항 추가

        // board/view.jsp 페이지로 이동
        return "board/view";
    }

    /**
     * LocalDateTime을 Date 객체로 변환하는 메서드
     * @param localDateTime 변환할 LocalDateTime 객체
     * @return 변환된 Date 객체
     */
    private Date convertToDate(LocalDateTime localDateTime) {
        // LocalDateTime을 시스템 기본 시간대로 변환 후 Date 타입으로 변환
        return Date.from(localDateTime.atZone(ZoneId.systemDefault()).toInstant());
    }
}
