package com.shoppingShop.service;

import com.shoppingShop.dao.BoardDao;
import com.shoppingShop.domain.BoardDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BoardServiceImpl implements BoardService {

    @Autowired
    private BoardDao boardDao;

    @Override
    public List<BoardDto> getBoardList(int pageNum, int pageSize, String search, String sort) {
        int offset = (pageNum - 1) * pageSize;
        return boardDao.getBoardList(offset, pageSize, search, sort);
    }

    @Override
    public int getBoardCount(String search) {
        return boardDao.getBoardCount(search);
    }

    @Override
    public BoardDto getNoticeById(int noticeId) {
        return boardDao.getNoticeById(noticeId);
    }

    @Override
    public BoardDto getPreviousNotice(int noticeId) {
        return boardDao.getPreviousNotice(noticeId);
    }

    @Override
    public BoardDto getNextNotice(int noticeId) {
        return boardDao.getNextNotice(noticeId);
    }
}
