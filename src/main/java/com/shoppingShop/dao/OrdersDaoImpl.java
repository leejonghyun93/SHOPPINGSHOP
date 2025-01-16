package com.shoppingShop.dao;

import com.shoppingShop.domain.OrdersDto;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
public class OrdersDaoImpl implements OrdersDao {

    @Autowired
    private SqlSession sqlSession;

    @Autowired
    private CartDao cartDao;  // CartDao 주입

    private static final String NAMESPACE = "com.shoppingShop.dao.OrdersDao";

    @Override
    @Transactional
    public int createOrder(OrdersDto order) {
        return sqlSession.insert(NAMESPACE + ".createOrder", order); // 주문 DB에 저장
        // 자동 생성된 orderId가 OrdersDto 객체에 반영됨
    }

    @Override
    public List<OrdersDto> getOrderHistoryByUserId(String userId) {
        return sqlSession.selectList(NAMESPACE + ".getOrderHistoryByUserId", userId);
    }

    @Override
    public List<OrdersDto> getSelectOrderList(String userId) {
        return sqlSession.selectList(NAMESPACE + ".selectGetOrderList", userId);
    }

    public List<OrdersDto> getCartItemsByIds(List<Long> cartIds) {
        return cartDao.getCartItemsByIds(cartIds);  // CartDao 메서드 호출
    }
}
