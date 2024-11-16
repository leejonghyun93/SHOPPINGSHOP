package com.shoppingShop.dao;

import com.shoppingShop.domain.BoardDto;

import java.util.List;

public interface BoardDao {

    List<BoardDto> selectBoardListAll(int offset, int pageSize) throws Exception;
    int countAllBoards() throws Exception;

    BoardDto selectNoticeById(int noticeId)throws Exception;

    BoardDto selectPreviousNotice(int noticeId) throws Exception;

    BoardDto selectNextNotice(int noticeId) throws Exception;
}
