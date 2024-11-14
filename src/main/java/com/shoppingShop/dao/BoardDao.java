package com.shoppingShop.dao;

import com.shoppingShop.domain.BoardDto;

import java.util.List;

public interface BoardDao {

    List<BoardDto> selectBoardListAll(int offset, int pageSize) throws Exception;
    int countAllBoards() throws Exception; //
}
