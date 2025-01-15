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
        Map<String, Object> response = new HashMap<>();

        if (userId == null) {
            response.put("message", "로그인이 필요합니다.");
            return ResponseEntity.status(401).body(response);
        }

        cartDto.setUserId(userId);

        try {
            cartService.addCart(cartDto);
            response.put("message", "장바구니에 상품이 추가되었습니다.");
            response.put("cart", cartDto);
            return ResponseEntity.ok(response);
        } catch (IllegalArgumentException e) {
            response.put("message", e.getMessage());
            return ResponseEntity.status(400).body(response);
        }
    }
    @PostMapping("/checkCartItem")
    public ResponseEntity<Map<String, Object>> checkCartItem(@RequestBody CartDto cartDto, HttpSession session) {
        String userId = (String) session.getAttribute("userId");
        Map<String, Object> response = new HashMap<>();

        if (userId == null) {
            response.put("message", "로그인이 필요합니다.");
            return ResponseEntity.status(401).body(response);
        }

        cartDto.setUserId(userId);

        boolean isExist = cartService.isItemInCart(cartDto);

        if (isExist) {
            response.put("message", "이미 장바구니에 추가된 상품입니다.");
            return ResponseEntity.status(409).body(response); // 409 Conflict
        } else {
            response.put("message", "장바구니에 상품을 추가할 수 있습니다.");
            return ResponseEntity.ok(response);
        }
    }
    // 장바구니에서 상품 삭제
    @PostMapping ("/delete/{cartId}")
    public String deleteCartItem(@PathVariable Long cartId) {
        cartService.removeCart(cartId);
        return "redirect:/cart/cart"; // 장바구니 페이지로 리다이렉트
    }
}


