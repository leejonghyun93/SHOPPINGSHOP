package com.shoppingShop.controller;

import com.shoppingShop.domain.UserDto;
import com.shoppingShop.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/login")
public class LoginController {

    @Autowired
    private UserService userService;

    @GetMapping("/login")
    public String showLoginPage() {
        return "login/login"; // 로그인 페이지 표시
    }

    @PostMapping("/login")
    public String login(String userId, String userPwd, Model model, HttpServletRequest request, HttpServletResponse response) {
        try {

            if (userId != null) {
                // 세션에 로그인 정보 저장
                HttpSession session = request.getSession();
                session.setAttribute("userId", userId);
                // 쿠키 설정
                Cookie cookie = new Cookie("userId", userId);
                cookie.setMaxAge(60 * 60 * 24);
                cookie.setPath("/");
                response.addCookie(cookie);

                // 로그인 성공 시, user 정보를 모델에 추가하여 JSP에서 사용할 수 있게 전달
                model.addAttribute("userId", userId); // userId를 모델에 추가
                return "redirect:/"; // 홈 페이지로 리다이렉트
            } else {
                model.addAttribute("error", "아이디 또는 비밀번호가 잘못되었습니다.");
                return "login/login"; // 로그인 실패 시 로그인 페이지로 다시 이동
            }
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "로그인 중 오류가 발생했습니다.");
            return "login/login"; // 오류 발생 시 로그인 페이지로 다시 이동
        }
    }
}