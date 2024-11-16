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
    public List<BoardDto> getBoardList(int pageNum, int pageSize) throws Exception {
        int offset = (pageNum - 1) * pageSize; // 페이지 오프셋 계산
        return boardDao.selectBoardListAll(offset, pageSize); // 페이징 적용
    }

    @Override
    public int getBoardCount() throws Exception {
        return boardDao.countAllBoards(); // 총 게시글 수 반환
    }

    @Override
    public BoardDto getNoticeById(int noticeId)throws Exception {
        return boardDao.selectNoticeById(noticeId);
    }
}
