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
    public UserDto findUserById(String userId) {
        return sqlSession.selectOne(NAMESPACE + ".findUserById", userId);
    }

    @Override
    public UserDto selectUser(String userId) throws Exception {
        return sqlSession.selectOne(NAMESPACE + ".selectUser", userId);
    }
    @Override
    public boolean checkUserIdExists(String userId) {
        Integer result = sqlSession.selectOne(NAMESPACE + ".checkUserIdExists", userId);
        return result != null && result > 0;
    }
    @Override
    public UserDto findByUserIdAndPassword(String userId, String userPwd) {
        Map<String, Object> params = new HashMap<>();
        params.put("userId", userId);
        params.put("userPwd", userPwd);
        return sqlSession.selectOne(NAMESPACE + ".findByUserIdAndPassword", params);
    }

    @Override
    public void insertUser(UserDto userDto) throws Exception {
        sqlSession.insert(NAMESPACE + ".insertUser", userDto);
    }

    @Override
    public String findIdByNameAndEmail(String userName, String userEmail) {
        Map<String, String> params = new HashMap<>();
        params.put("userName", userName);
        params.put("userEmail", userEmail);
        return sqlSession.selectOne(NAMESPACE + ".findIdByNameAndEmail", params);
    }

    @Override
    public String findPasswordByNameEmailAndId(String userName, String userEmail, String userId) {
        Map<String, String> params = new HashMap<>();
        params.put("userName", userName);
        params.put("userEmail", userEmail);
        params.put("userId", userId);
        return sqlSession.selectOne(NAMESPACE + ".findPasswordByNameEmailAndId", params);
    }
}
