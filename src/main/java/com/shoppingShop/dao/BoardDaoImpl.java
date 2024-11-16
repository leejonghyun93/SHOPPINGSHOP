package com.shoppingShop.dao;

import com.shoppingShop.domain.BoardDto;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class BoardDaoImpl implements BoardDao{

    @Autowired
    private SqlSession session;
    private static String namespace = "com.shoppingShop.dao.BoardDao.";

    @Override
    public List<BoardDto> selectBoardListAll(int offset, int pageSize) throws Exception {
        // offset과 pageSize를 사용하여 페이징 처리
        return session.selectList(namespace + "selectBoardListAll", Map.of("offset", offset, "pageSize", pageSize));
    }

    @Override
    public int countAllBoards() throws Exception {
        return session.selectOne(namespace + "countAllBoards"); // 총 게시글 수 반환
    }

    @Override
    public BoardDto selectNoticeById(int noticeId) throws Exception {
        return session.selectOne(namespace + "selectNoticeById", noticeId); // 불필요한 "." 제거
    }

    @Override
    public BoardDto selectPreviousNotice(int noticeId) throws Exception {
        return session.selectOne(namespace + "selectPreviousNotice", noticeId);
    }

    @Override
    public BoardDto selectNextNotice(int noticeId) throws Exception {
        return session.selectOne(namespace + "selectNextNotice", noticeId);
    }
}
