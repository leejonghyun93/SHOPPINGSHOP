package com.shoppingShop.dao;

import com.shoppingShop.domain.BoardDto;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class BoardDaoImpl implements BoardDao {

    @Autowired
    private SqlSession session;
    private static final String namespace = "com.shoppingShop.dao.BoardDao.";

    @Override
    public List<BoardDto> selectBoardListAll(int offset, int pageSize, String sort) throws Exception {
        // offset, pageSize, sort를 사용하여 페이징 및 정렬 처리
        Map<String, Object> params = Map.of(
                "offset", offset,
                "pageSize", pageSize,
                "sort", sort
        );
        return session.selectList(namespace + "selectBoardListAll", params);
    }

    @Override
    public int countAllBoards() throws Exception {
        return session.selectOne(namespace + "countAllBoards");
    }

    @Override
    public BoardDto selectNoticeById(int noticeId) throws Exception {
        return session.selectOne(namespace + "selectNoticeById", noticeId);
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
