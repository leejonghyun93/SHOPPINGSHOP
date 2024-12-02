package com.shoppingShop.controller;

import com.shoppingShop.domain.CartDto;
import com.shoppingShop.service.CartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/cart")
public class CartController {

    @Autowired
    private CartService cartService;

    @PostMapping("/add")
    public ResponseEntity<Map<String, Object>> addToCart(@RequestBody CartDto cartDto, HttpSession session) {
        System.out.println("Cart Data: " + cartDto);
        String userId = (String) session.getAttribute("userId");
        if (userId == null) {
            return ResponseEntity.status(401).body(Map.of("message", "로그인이 필요합니다."));
        }

        cartDto.setUserId(userId);
        cartService.addCart(cartDto);
        Map<String, Object> response = new HashMap<>();
        response.put("message", "장바구니에 추가되었습니다.");
        return ResponseEntity.ok(Map.of("message", "장바구니에 상품이 추가되었습니다."));
    }

    @GetMapping("/list")
    public ResponseEntity<List<CartDto>> getCartList(HttpSession session) {
        String userId = (String) session.getAttribute("userId");
        if (userId == null) {
            return ResponseEntity.status(401).build();
        }

        List<CartDto> cartList = cartService.getCartByUserId(userId);
        return ResponseEntity.ok(cartList);
    }

    @DeleteMapping("/remove/{cartId}")
    public ResponseEntity<Map<String, Object>> removeFromCart(@PathVariable Long cartId) {
        cartService.removeCart(cartId);
        return ResponseEntity.ok(Map.of("message", "장바구니에서 상품이 삭제되었습니다."));
    }
}