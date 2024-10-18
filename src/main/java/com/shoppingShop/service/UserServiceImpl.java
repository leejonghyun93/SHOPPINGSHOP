package com.shoppingShop.service;

import com.shoppingShop.dao.UserDao;
import com.shoppingShop.domain.UserDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserDao userDao;

    @Override
    public UserDto getUser(String userId) throws Exception {
        return userDao.selectUser(userId);
    }
    @Override
    public UserDto login(String userId, String userPwd) {
        return userDao.findByUserIdAndPassword(userId, userPwd);
    }
}