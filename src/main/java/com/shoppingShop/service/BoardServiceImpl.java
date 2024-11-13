package com.shoppingShop.service;

import com.shoppingShop.dao.BoardDao;
import com.shoppingShop.domain.BoardDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BoardServiceImpl implements BoardService{

    @Autowired
    private BoardDao boardDao;

    @Override
    public List<BoardDto> getBoardList() throws Exception {  // 파라미터 제거
        return boardDao.selectBoardListAll();
    }
}
