package com.shoppingShop.dao;

import com.shoppingShop.domain.UserDto;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.Map;

@Repository
public class UserDaoImpl implements UserDao {

    @Autowired
    private SqlSession sqlSession;

    private static final String NAMESPACE = "com.shoppingShop.dao.UserDao";

    @Override
    public UserDto selectUser(String userId) throws Exception {
        return sqlSession.selectOne("com.shoppingShop.dao.UserDao.selectUser", userId);
    }

    @Override
    public UserDto findByUserIdAndPassword(String userId, String userPwd) {
        Map<String, Object> params = new HashMap<>();
        params.put("userId", userId);
        params.put("userPwd", userPwd);
        return sqlSession.selectOne("com.shoppingShop.dao.UserDao.findByUserIdAndPassword", params);
    }

    @Override
    public void insertUser(UserDto userDto) throws Exception {
        sqlSession.insert(NAMESPACE + ".insertUser", userDto);
    }
}
