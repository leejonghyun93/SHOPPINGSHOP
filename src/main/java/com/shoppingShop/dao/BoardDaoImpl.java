package com.shoppingShop.dao;

import com.shoppingShop.domain.BoardDto;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class BoardDaoImpl implements BoardDao{

    @Autowired
    private SqlSession session;
    private static String namespace = "com.shoppingShop.dao.BoardDao.";

    @Override
    public List<BoardDto> selectBoardListAll() throws Exception {  // 파라미터 제거
        return session.selectList(namespace + "selectBoardListAll");
    }
}
