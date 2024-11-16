package com.shoppingShop.service;

import com.shoppingShop.domain.BoardDto;

import java.util.List;

public interface BoardService {
    List<BoardDto> getBoardList(int pageNum, int pageSize) throws Exception;
    int getBoardCount() throws Exception; // 총 게시글 수 반환 메서드

    BoardDto getNoticeById(int noticeId)throws Exception;
}
