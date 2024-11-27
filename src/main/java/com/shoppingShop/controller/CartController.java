package com.shoppingShop.controller;

import com.shoppingShop.domain.CartDto;
import com.shoppingShop.service.CartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/cart")
public class CartController {

    @Autowired
    private CartService cartService;

    @GetMapping
    public String viewCart(HttpSession session, Model model) {
        String userId = (String) session.getAttribute("userId");

        if (userId == null) {
            return "redirect:/login"; // 로그인 페이지로 리다이렉트
        }

        // 사용자 ID로 장바구니 항목 가져오기
        List<CartDto> cartItems = cartService.getCartByUserId(userId);
        model.addAttribute("cartItems", cartItems);
        return "user/cart";  // JSP 파일 경로 (장바구니 페이지)
    }

    @PostMapping("/add")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> addToCart(@RequestBody CartDto cartDto, HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        try {
            String userId = (String) session.getAttribute("userId");
            if (userId == null) {
                response.put("success", false);
                response.put("message", "로그인이 필요합니다.");
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(response);
            }

            // 세션에서 가져온 사용자 ID 설정
            cartDto.setUserId(userId);

            // 장바구니 서비스 호출
            cartService.addCart(cartDto);
            response.put("success", true);
            response.put("message", "장바구니에 추가되었습니다.");
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "장바구니에 추가하는 중 오류가 발생했습니다.");
        }
        return ResponseEntity.ok(response);
    }

    @DeleteMapping("/delete/{cartId}")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> deleteCart(@PathVariable Long cartId, HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        try {
            String userId = (String) session.getAttribute("userId");
            if (userId == null) {
                response.put("success", false);
                response.put("message", "로그인이 필요합니다.");
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(response);
            }

            // 장바구니 항목 삭제
            cartService.deleteCart(cartId);
            response.put("success", true);
            response.put("message", "장바구니에서 삭제되었습니다.");
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "장바구니 항목 삭제 중 오류가 발생했습니다.");
        }
        return ResponseEntity.ok(response);
    }
}


