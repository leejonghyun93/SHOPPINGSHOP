package com.shoppingShop.dao;

import com.shoppingShop.domain.BoardDto;

import java.util.List;

public interface BoardDao {

    List<BoardDto> selectBoardListAll() throws Exception;
}
