package com.shoppingShop.dao;

import com.shoppingShop.domain.CartDto;
import com.shoppingShop.domain.OrdersDto;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class CartDaoImpl implements CartDao {

    private static final String NAMESPACE = "com.shoppingShop.dao.CartDao.";

    @Autowired
    private SqlSession sqlSession;

    @Override
    public List<CartDto> selectCartByUserId(String userId) {
        return sqlSession.selectList(NAMESPACE + "selectCartByUserId", userId);
    }

    @Override
    public int insertCart(CartDto cartDto) {
        return sqlSession.insert(NAMESPACE + "insertCart", cartDto);
    }

    @Override
    public int checkProductInCart(CartDto cartDto) {
        return sqlSession.selectOne(NAMESPACE + "checkProductInCart", cartDto);
    }

    @Override
    public int deleteCart(Long cartId) {
        return sqlSession.delete(NAMESPACE + "deleteCart", cartId);
    }
    @Override
    public boolean existsByUserIdAndProductId(String userId, int proId) {
        // userId와 proId를 파라미터로 넘겨서 쿼리 실행
        int count = sqlSession.selectOne(NAMESPACE + "existsByUserIdAndProductId", new HashMap<String, Object>() {{
            put("userId", userId);
            put("proId", proId);
        }});

        return count > 0;  // 존재하면 true, 존재하지 않으면 false
    }
    @Override
    public List<OrdersDto> getCartItemsByIds(List<Long> cartIds) {
        Map<String, Object> params = new HashMap<>();
        params.put("cartIds", cartIds);
        return sqlSession.selectList(NAMESPACE + "getCartItemsByIds", params);
    }


    @Override
    public int deleteCartItems(List<Long> cartIds) {
        // 먼저 orders 테이블에서 해당 cart_id를 참조하는 항목을 삭제
        deleteOrdersByCartIds(cartIds);

        // 장바구니 항목 삭제
        Map<String, Object> params = new HashMap<>();
        params.put("cartIds", cartIds);
        return sqlSession.delete(NAMESPACE + "deleteCartItems", params);
    }


    @Override
    public int deleteOrdersByCartIds(List<Long> cartIds) {
        Map<String, Object> params = new HashMap<>();
        params.put("cartIds", cartIds);

        // 먼저 delivery 테이블에서 관련 데이터를 삭제
        sqlSession.delete(NAMESPACE + "deleteDeliveryByCartIds", params);

        // 그 후 orders 테이블에서 데이터를 삭제
        return sqlSession.delete(NAMESPACE + "deleteOrdersByCartIds", params);
    }
}
