package com.shoppingShop.service;

import com.shoppingShop.domain.BoardDto;

import java.util.List;

public interface BoardService {
    // 정렬 기준 추가
    List<BoardDto> getBoardList(int pageNum, int pageSize, String search, String sort);
    int getBoardCount(String search);
    BoardDto getNoticeById(int noticeId);
    BoardDto getPreviousNotice(int noticeId);
    BoardDto getNextNotice(int noticeId);
}
