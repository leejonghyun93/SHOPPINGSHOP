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

    // 장바구니 조회
    @GetMapping
    public String viewCart(HttpSession session, Model model) {
        String userId = (String) session.getAttribute("userId");
        if (userId == null) {
            return "redirect:/login";
        }

        List<CartDto> cartItems = cartService.getCartByUserId(userId);
        model.addAttribute("cartItems", cartItems);
        return "user/cart";  // JSP 파일 경로
    }

    // 장바구니 추가
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

            // 세션에서 userId 추가
            cartDto.setUserId(userId);

            // 장바구니에 상품 추가
            cartService.addCart(cartDto);
            response.put("success", true);
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "장바구니에 추가하는 중 오류가 발생했습니다.");
        }
        return ResponseEntity.ok(response);
    }

    // 장바구니 삭제
    @DeleteMapping("/delete/{cartId}")
    @ResponseBody
    public ResponseEntity<String> deleteCart(@PathVariable Long cartId) {
        try {
            cartService.deleteCart(cartId);
            return ResponseEntity.ok("장바구니에서 제거되었습니다.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("장바구니에서 제거 중 오류가 발생했습니다.");
        }
    }
}

