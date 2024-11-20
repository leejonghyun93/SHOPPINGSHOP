package com.shoppingShop.service;

import com.shoppingShop.domain.BoardDto;

import java.util.List;

public interface BoardService {
    // 정렬 기준 추가
    List<BoardDto> getBoardList(int pageNum, int pageSize, String sort) throws Exception;

    int getBoardCount() throws Exception;

    BoardDto getNoticeById(int noticeId) throws Exception;

    BoardDto getPreviousNotice(int noticeId) throws Exception;

    BoardDto getNextNotice(int noticeId) throws Exception;
}
