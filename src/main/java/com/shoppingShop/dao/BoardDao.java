package com.shoppingShop.dao;

import com.shoppingShop.domain.BoardDto;
import java.util.List;

public interface BoardDao {
    List<BoardDto> getBoardList(int offset, int limit, String search, String sort);
    int getBoardCount(String search);
    BoardDto getNoticeById(int noticeId);
    BoardDto getPreviousNotice(int noticeId);
    BoardDto getNextNotice(int noticeId);
}
