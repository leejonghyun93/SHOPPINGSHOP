package com.shoppingShop.controller;

import com.shoppingShop.domain.CartDto;
import com.shoppingShop.domain.ProductDto;
import com.shoppingShop.service.CartService;
import org.springframework.beans.factory.annotation.Autowired;
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
    @GetMapping("/cart")
    public String getCart(HttpSession session, Model model) {
        String userId = (String) session.getAttribute("userId");
        if (userId == null) {
            model.addAttribute("message", "로그인 후 이용해 주세요.");
            return "login/login"; // 로그인 페이지로 리다이렉트
        }

        List<CartDto> cartItems = cartService.getCartByUserId(userId);
        model.addAttribute("cartItems", cartItems);
        return "user/cart"; // user/cart.jsp 뷰로 이동
    }

    // 장바구니에 상품 추가
    @PostMapping("/add")
    public ResponseEntity<Map<String, Object>> addToCart(@RequestBody CartDto cartDto, HttpSession session) {
        String userId = (String) session.getAttribute("userId");

        if (userId == null) {
            Map<String, Object> response = new HashMap<>();
            response.put("message", "로그인이 필요합니다.");
            return ResponseEntity.status(401).body(response);
        }

        // 사용자 ID 추가
        cartDto.setUserId(userId);
        // 장바구니 서비스에 상품 추가
        cartService.addCart(cartDto);

        Map<String, Object> response = new HashMap<>();
        response.put("message", "장바구니에 상품이 추가되었습니다.");
        response.put("cart", cartDto); // 추가된 데이터 반환
        return ResponseEntity.ok(response);
    }

    // 장바구니에서 상품 삭제
    @DeleteMapping("/remove/{cartId}")
    public ResponseEntity<Map<String, Object>> removeFromCart(@PathVariable Long cartId) {
        cartService.removeCart(cartId);
        return ResponseEntity.ok(Map.of("message", "장바구니에서 상품이 삭제되었습니다."));
    }
}


