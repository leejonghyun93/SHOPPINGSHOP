package com.shoppingShop.dao;

import com.shoppingShop.domain.BoardDto;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class BoardDaoImpl implements BoardDao {

    @Autowired
    private SqlSession sqlSession;

    private static final String NAMESPACE = "com.shoppingShop.mapper.BoardMapper";

    @Override
    public List<BoardDto> getBoardList(int offset, int limit, String search, String sort) {
        Map<String, Object> params = new HashMap<>();
        params.put("offset", offset);
        params.put("limit", limit);
        params.put("search", search);  // 검색어 파라미터 추가
        params.put("sort", sort);
        return sqlSession.selectList(NAMESPACE + ".selectBoardListAll", params); // XML에서 정의한 selectBoardListAll 메서드 호출
    }

    @Override
    public int getBoardCount(String search) {
        return sqlSession.selectOne(NAMESPACE + ".getBoardCount", search);
    }

    @Override
    public BoardDto getNoticeById(int noticeId) {
        return sqlSession.selectOne(NAMESPACE + ".getNoticeById", noticeId);
    }

    @Override
    public BoardDto getPreviousNotice(int noticeId) {
        return sqlSession.selectOne(NAMESPACE + ".getPreviousNotice", noticeId);
    }

    @Override
    public BoardDto getNextNotice(int noticeId) {
        return sqlSession.selectOne(NAMESPACE + ".getNextNotice", noticeId);
    }
}