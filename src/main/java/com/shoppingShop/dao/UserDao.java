package com.shoppingShop.dao;

import com.shoppingShop.domain.UserDto;

public interface UserDao {

    UserDto findUserById(String userId);

    UserDto selectUser(String userId) throws Exception; // 사용자 조회
    UserDto findByUserIdAndPassword(String userId, String userPwd); // 사용자 아이디와 비밀번호로 조회

    void insertUser(UserDto userDto) throws Exception;
}
