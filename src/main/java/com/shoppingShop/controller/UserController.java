package com.shoppingShop.controller;

import com.shoppingShop.domain.UserDto;
import com.shoppingShop.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/membership")
public class UserController {

    @Autowired
    private UserService userService;

    @GetMapping("/register")
    public String showRegisterForm() {
        return "user/register"; // register.jsp를 반환
    }

    @PostMapping("/registerSubmit")
    public String submitRegisterForm(UserDto userDto, Model model) {
        boolean success = userService.registerUser(userDto);
        if (success) {
            return "redirect:/login/login"; // 회원가입 성공 시 로그인 페이지로 리다이렉트
        } else {
            model.addAttribute("errorMessage", "회원가입에 실패했습니다. 다시 시도해주세요.");
            return "register";
        }
    }
    @GetMapping("/findId")
    public String showFindIdForm() {
        return "user/findId"; // findId.jsp 반환
    }

    @PostMapping("/findId")
    public String findId(@RequestParam("userName") String userName,
                         @RequestParam("userEmail") String userEmail,
                         Model model) {
        try {
            String foundId = userService.findIdByNameAndEmail(userName, userEmail);
            if (foundId != null) {
                model.addAttribute("foundId", foundId);
            } else {
                model.addAttribute("errorMessage", "일치하는 아이디가 없습니다.");
            }
        } catch (Exception e) {
            model.addAttribute("errorMessage", "오류가 발생했습니다. 다시 시도해주세요.");
        }

        return "user/findId";
    }
    @GetMapping("/findPassword")
    public String showFindPasswordForm() {
        return "user/findPassword";
    }

    @PostMapping("/findPassword")
    public String findPassword(
            @RequestParam("userName") String userName,
            @RequestParam("userEmail") String userEmail,
            @RequestParam("userId") String userId,
            Model model) {

        try {
            String password = userService.findPasswordByNameEmailAndId(userName, userEmail, userId);
            if (password != null) {
                model.addAttribute("password", password);
            } else {
                model.addAttribute("errorMessage", "입력하신 정보와 일치하는 비밀번호를 찾을 수 없습니다.");
            }
        } catch (Exception e) {
            model.addAttribute("errorMessage", "오류가 발생했습니다. 다시 시도해주세요.");
            e.printStackTrace();
        }

        return "user/findPassword"; // findPassword.jsp로 반환
    }

}
