package com.shoppingShop.service;

import com.shoppingShop.domain.BoardDto;

import java.util.List;

public interface BoardService {
    List<BoardDto> getBoardList() throws Exception;
}
