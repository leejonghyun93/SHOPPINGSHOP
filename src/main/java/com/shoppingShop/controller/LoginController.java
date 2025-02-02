package com.shoppingShop.controller;

// 필요한 클래스들을 임포트합니다.
import com.shoppingShop.domain.UserDto;
import com.shoppingShop.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

// 이 클래스는 로그인 관련 요청을 처리하는 컨트롤러입니다.
@Controller
@RequestMapping("/login")
public class LoginController {

    // UserService를 주입받습니다.
    @Autowired
    private UserService userService;

    // 로그인 페이지를 보여주는 GET 요청을 처리합니다.
    @GetMapping("/login")
    public String showLoginPage() {
        return "login/login"; // 로그인 페이지 뷰를 반환합니다.
    }

    // 로그인 폼 제출을 처리하는 POST 요청을 처리합니다.
    @PostMapping("/login")
    public String login(String userId, String userPwd, Model model, HttpServletRequest request, HttpServletResponse response) {
        try {
            // userId와 userPwd가 null이 아니고 비어있지 않은지 확인합니다.
            if (userId != null && !userId.isEmpty() && userPwd != null && !userPwd.isEmpty()) {
                // UserService를 사용하여 사용자 인증을 검증합니다.
                if (userService.validateUser(userId, userPwd)) {
                    // 세션에 사용자 ID를 저장합니다.
                    HttpSession session = request.getSession();
                    session.setAttribute("userId", userId);

                    // 사용자 ID를 저장하는 쿠키를 생성하고 설정합니다.
                    Cookie cookie = new Cookie("userId", userId);
                    cookie.setMaxAge(60 * 60 * 24); // 쿠키의 유효 기간을 1일로 설정합니다.
                    cookie.setPath("/");
                    response.addCookie(cookie);

                    return "redirect:/"; // 홈 페이지로 리다이렉트합니다.
                } else {
                    // 인증 실패 시 에러 메시지를 모델에 추가하고 로그인 페이지로 돌아갑니다.
                    model.addAttribute("error", "아이디 또는 비밀번호가 잘못되었습니다.");
                    return "login/login";
                }
            } else {
                // 입력 값이 누락된 경우 에러 메시지를 모델에 추가하고 로그인 페이지로 돌아갑니다.
                model.addAttribute("error", "아이디와 비밀번호를 입력해주세요.");
                return "login/login";
            }
        } catch (Exception e) {
            // 예외 발생 시 스택 트레이스를 출력하고 에러 메시지를 모델에 추가한 후 로그인 페이지로 돌아갑니다.
            e.printStackTrace();
            model.addAttribute("error", "로그인 중 오류가 발생했습니다.");
            return "login/login";
        }
    }

    // 로그아웃 요청을 처리하는 GET 요청을 처리합니다.
    @GetMapping("/logout")
    public String logout(HttpServletRequest request, HttpServletResponse response) {
        // 현재 세션을 가져와서 무효화합니다.
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }

        // 사용자 ID 쿠키를 삭제합니다.
        Cookie cookie = new Cookie("userId", null);
        cookie.setMaxAge(0); // 쿠키를 즉시 만료시킵니다.
        cookie.setPath("/");
        response.addCookie(cookie);

        // 로그아웃 후 로그인 페이지로 리다이렉트합니다.
        return "redirect:/login/login";
    }
}
