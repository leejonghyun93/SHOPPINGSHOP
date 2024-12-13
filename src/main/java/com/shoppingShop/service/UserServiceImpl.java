package com.shoppingShop.service;

import com.shoppingShop.dao.UserDao;
import com.shoppingShop.domain.UserDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;

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

    @Override
    public boolean registerUser(UserDto userDto) {
        try {
            userDto.setCreatedAt(new Date()); // 생성일자 설정
            userDto.setUpdatedAt(new Date()); // 수정일자 설정
            userDao.insertUser(userDto);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}