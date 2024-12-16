package com.shoppingShop.service;

import com.shoppingShop.dao.UserDao;
import com.shoppingShop.domain.UserDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@Service
public class UserServiceImpl implements UserService {

    private final UserDao userDao;
    private final PasswordEncoder passwordEncoder;

    @Autowired
    public UserServiceImpl(UserDao userDao, PasswordEncoder passwordEncoder) {
        this.userDao = userDao;
        this.passwordEncoder = passwordEncoder;
    }

    @Override
    public UserDto getUser(String userId) throws Exception {
        return userDao.selectUser(userId);
    }
//    @Override
//    public UserDto login(String userId, String userPwd) {
//        return userDao.findByUserIdAndPassword(userId, userPwd);
//    }

    @Override
    public boolean registerUser(UserDto userDto) {
        try {
            System.out.println("평문 비밀번호: " + userDto.getUserPwd());  // 평문 비밀번호
            String encodedPassword = passwordEncoder.encode(userDto.getUserPwd());  // BCrypt 인코딩
            System.out.println("암호화된 비밀번호: " + encodedPassword);  // 인코딩된 비밀번호 출력

            userDto.setUserPwd(encodedPassword); // 암호화된 비밀번호 저장
            userDto.setCreatedAt(new Date());
            userDto.setUpdatedAt(new Date());
            userDao.insertUser(userDto);  // DB에 사용자 등록
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    @Override
    public boolean validateUser(String userId, String userPwd) {
        UserDto user = userDao.findUserById(userId);  // DB에서 사용자 조회
        System.out.println("입력된 비밀번호: " + userPwd);  // 사용자가 입력한 비밀번호
        System.out.println("DB 비밀번호: " + user.getUserPwd());  // DB에 저장된 비밀번호

        // BCrypt의 matches 메서드로 비교
        System.out.println("비밀번호 비교 결과: " + passwordEncoder.matches(userPwd, user.getUserPwd()));  // 비밀번호 비교
        if (user != null && passwordEncoder.matches(userPwd, user.getUserPwd())) {
            return true;
        }
        return false;
    }

    @Override
    public String findIdByNameAndEmail(String userName, String userEmail) {
        return userDao.findIdByNameAndEmail(userName, userEmail);
    }
    @Override
    public String findPasswordByNameEmailAndId(String userName, String userEmail, String userId) {
        return userDao.findPasswordByNameEmailAndId(userName, userEmail, userId);
    }
    // 비밀번호 비교 메소드
    public boolean checkPassword(String rawPassword, String encodedPassword) {
        return passwordEncoder.matches(rawPassword, encodedPassword);
    }

}