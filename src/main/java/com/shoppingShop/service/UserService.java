package com.shoppingShop.service;

import com.shoppingShop.domain.UserDto;

public interface UserService {
//    UserDto login(String userId, String userPwd) throws Exception;
    UserDto getUser(String userId) throws Exception;

    boolean registerUser(UserDto userDto);

    boolean validateUser(String userId, String userPwd);


    boolean isUserIdDuplicate(String userId);

    String findIdByNameAndEmail(String userName, String userEmail);

    String findPasswordByNameEmailAndId(String userName, String userEmail, String userId);
}