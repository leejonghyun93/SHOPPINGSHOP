package com.shoppingShop.service;

import com.shoppingShop.domain.UserDto;

public interface UserService {
    UserDto login(String userId, String userPwd) throws Exception;
    UserDto getUser(String userId) throws Exception;

    boolean registerUser(UserDto userDto);
}