package com.shoppingShop.controller;

import com.shoppingShop.domain.UserDto;
import com.shoppingShop.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

@Controller // 이 클래스는 Spring MVC 프레임워크에서 컨트롤러 역할을 한다.
@RequestMapping("/membership") // /membership로 오는 HTTP 요청을 이 컨트롤러에서 처리하도록 매핑한다.
public class UserController {

    @Autowired // UserService 빈을 자동으로 주입한다.
    private UserService userService;

    @GetMapping("/register") // /membership/register로 오는 GET 요청을 처리한다.
    public String showRegisterForm() {
        return "user/register"; // 회원가입 폼을 보여주는 뷰 이름을 반환한다. (register.jsp)
    }

    @PostMapping("/registerSubmit") // /membership/registerSubmit로 오는 POST 요청을 처리한다.
    public String submitRegisterForm(@RequestParam("fullAddress") String fullAddress, UserDto userDto, Model model) {
        // 디버깅: 전체 주소와 사용자 정보를 출력한다.
        System.out.println("Full Address: " + userDto.getUserAddress());
        System.out.println("User DTO: " + userDto);
        System.out.println("Full Address: " + fullAddress);

        boolean success = userService.registerUser(userDto); // 사용자를 등록하려 시도한다.
        if (success) {
            return "redirect:/login/login"; // 성공하면 로그인 페이지로 리다이렉트한다.
        } else {
            model.addAttribute("errorMessage", "회원가입에 실패했습니다. 다시 시도해주세요."); // 실패하면 오류 메시지를 모델에 추가한다.
            return "user/register"; // 실패 시 회원가입 폼으로 돌아간다.
        }
    }

    @PostMapping("/checkUserId") // /membership/checkUserId로 오는 POST 요청을 처리한다.
    public ResponseEntity<Map<String, Boolean>> checkUserId(@RequestBody Map<String, String> requestData) {
        String userId = requestData.get("userId"); // 요청 본문에서 userId를 추출한다.
        boolean isAvailable = !userService.isUserIdDuplicate(userId); // userId가 사용 가능한지 확인한다.

        Map<String, Boolean> response = new HashMap<>();
        response.put("available", isAvailable); // 사용 가능한지 여부를 응답으로 준비한다.

        return ResponseEntity.ok(response); // JSON 형태로 응답을 반환한다.
    }

    @GetMapping("/findId") // /membership/findId로 오는 GET 요청을 처리한다.
    public String showFindIdForm() {
        return "user/findId"; // 아이디 찾기 폼을 보여주는 뷰 이름을 반환한다. (findId.jsp)
    }

    @PostMapping("/findId") // /membership/findId로 오는 POST 요청을 처리한다.
    public String findId(@RequestParam("userName") String userName,
                         @RequestParam("userEmail") String userEmail,
                         Model model) {
        try {
            String foundId = userService.findIdByNameAndEmail(userName, userEmail); // 사용자 ID를 찾으려 시도한다.
            if (foundId != null) {
                model.addAttribute("foundId", foundId); // 찾은 ID를 모델에 추가한다.
            } else {
                model.addAttribute("errorMessage", "일치하는 아이디가 없습니다."); // 일치하는 ID가 없으면 오류 메시지를 추가한다.
            }
        } catch (Exception e) {
            model.addAttribute("errorMessage", "오류가 발생했습니다. 다시 시도해주세요."); // 예외 발생 시 일반 오류 메시지를 추가한다.
        }

        return "user/findId"; // 아이디 찾기 폼을 반환한다.
    }

    @GetMapping("/findPassword") // /membership/findPassword로 오는 GET 요청을 처리한다.
    public String showFindPasswordForm() {
        return "user/findPassword"; // 비밀번호 찾기 폼을 보여주는 뷰 이름을 반환한다. (findPassword.jsp)
    }

    @PostMapping("/findPassword") // /membership/findPassword로 오는 POST 요청을 처리한다.
    public String findPassword(@RequestParam("userName") String userName,
                               @RequestParam("userEmail") String userEmail,
                               @RequestParam("userId") String userId,
                               Model model) {
        try {
            String password = userService.findPasswordByNameEmailAndId(userName, userEmail, userId); // 비밀번호를 찾으려 시도한다.
            if (password != null) {
                model.addAttribute("password", password); // 찾은 비밀번호를 모델에 추가한다.
            } else {
                model.addAttribute("errorMessage", "입력하신 정보와 일치하는 비밀번호를 찾을 수 없습니다."); // 일치하는 비밀번호가 없으면 오류 메시지를 추가한다.
            }
        } catch (Exception e) {
            model.addAttribute("errorMessage", "오류가 발생했습니다. 다시 시도해주세요."); // 예외 발생 시 일반 오류 메시지를 추가한다.
            e.printStackTrace(); // 디버깅을 위한 예외 출력
        }

        return "user/findPassword"; // 비밀번호 찾기 폼을 반환한다.
    }

    @GetMapping("/myPage") // /membership/myPage로 오는 GET 요청을 처리한다.
    public String myPage() {
        return "/user/myPage"; // 사용자 개인 페이지를 보여주는 뷰 이름을 반환한다. (myPage.jsp)
    }

    @GetMapping("/edit") // /membership/edit로 오는 GET 요청을 처리한다.
    public String showUpdateForm(HttpSession session, Model model) {
        try {
            String userId = (String) session.getAttribute("userId"); // 세션에서 userId를 가져온다.

            if (userId == null || userId.isEmpty()) {
                model.addAttribute("errorMessage", "로그인이 필요합니다."); // 로그인하지 않았으면 오류 메시지를 추가한다.
                return "login/login"; // 로그인 페이지로 리다이렉트한다.
            }

            // 디버깅: 세션에서 가져온 userId를 출력한다.
            System.out.println("Session userId: " + userId);

            UserDto userDto = userService.getUserById(userId); // 사용자의 정보를 가져온다.

            // 디버깅: 가져온 UserDto를 출력한다.
            System.out.println("Fetched UserDto: " + userDto);

            if (userDto == null) {
                model.addAttribute("errorMessage", "해당 사용자를 찾을 수 없습니다."); // 사용자가 없으면 오류 메시지를 추가한다.
                return "user/myPage"; // 마이 페이지로 리다이렉트한다.
            }

            model.addAttribute("userDto", userDto); // 사용자 정보를 모델에 추가한다.
            return "user/edit"; // 수정 폼을 반환한다. (edit.jsp)

        } catch (Exception e) {
            e.printStackTrace(); // 디버깅을 위한 예외 출력
            model.addAttribute("errorMessage", "오류가 발생했습니다. 다시 시도해주세요."); // 예외 발생 시 일반 오류 메시지를 추가한다.
            return "user/myPage"; // 오류 발생 시 마이 페이지로 돌아간다.
        }
    }

    // 회원정보 수정 처리
    @PostMapping("/updateSubmit")
    public String submitUpdateForm(UserDto userDto, HttpSession session, Model model) {
        try {
            // 세션에서 userId 가져오기
            String userId = (String) session.getAttribute("userId");

            // 디버깅용 로그 추가
            System.out.println("Session userId: " + userId);
            System.out.println("Received UserDto: " + userDto);

            // 회원 정보 업데이트
            boolean success = userService.updateUser(userDto);

            if (success) {
                return "redirect:/membership/myPage"; // 수정 성공 후 마이페이지로 리다이렉트
            } else {
                model.addAttribute("errorMessage", "회원정보 수정에 실패했습니다. 다시 시도해주세요.");
                return "user/edit"; // 수정 실패 시 다시 수정 폼으로 돌아간다.
            }
        } catch (Exception e) {
            // 예외 처리 및 디버깅용 로그
            e.printStackTrace();
            model.addAttribute("errorMessage", "오류가 발생했습니다. 다시 시도해주세요.");
            return "user/edit"; // 오류 발생 시 수정 페이지로 돌아간다.
        }
    }
}
