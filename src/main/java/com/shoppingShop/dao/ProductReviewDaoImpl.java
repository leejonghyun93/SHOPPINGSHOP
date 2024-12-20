package com.shoppingShop.dao;

import com.shoppingShop.domain.ProductReviewDto;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class ProductReviewDaoImpl implements ProductReviewDao {

    @Autowired
    private SqlSession sqlSession;

    private static final String NAMESPACE = "com.shoppingShop.dao.ProductReviewDao";

    @Override
    public List<ProductReviewDto> getReviewsByProductId(int productId) {
        return sqlSession.selectList(NAMESPACE + ".getReviewsByProductId", productId);
    }

    @Override
    public void insertReview(ProductReviewDto productReview) {
        sqlSession.insert(NAMESPACE + ".addReview", productReview);  // 메서드 호출
    }
}
