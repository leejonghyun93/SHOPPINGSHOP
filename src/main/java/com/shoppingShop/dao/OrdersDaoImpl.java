package com.shoppingShop.dao;

import com.shoppingShop.domain.OrdersDto;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class OrdersDaoImpl implements OrdersDao {

    @Autowired
    private SqlSession sqlSession;

    private static final String NAMESPACE = "com.shoppingShop.dao.OrdersDao";

    @Override
    public void createOrder(OrdersDto order) {
        sqlSession.insert(NAMESPACE + ".createOrder", order);
    }

    @Override
    public List<OrdersDto> getOrderHistoryByUserId(String userId) {
        return sqlSession.selectList(NAMESPACE + ".getOrderHistoryByUserId", userId);
    }

    @Override
    public List<OrdersDto> getSelectOrderList(String userId) {
        return sqlSession.selectList(NAMESPACE + ".selectGetOrderList", userId);
    }
}
