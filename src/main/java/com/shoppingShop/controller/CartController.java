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
import java.util.List;

@Controller
@RequestMapping("/cart")
public class CartController {

    @Autowired
    private CartService cartService;

    // 장바구니 보기
    @GetMapping
    public String viewCart(HttpSession session, Model model) {
        String userId = (String) session.getAttribute("userId");
        if (userId == null) {
            return "redirect:/login";
        }

        List<CartDto> cartItems = cartService.getCartByUserId(userId);
        model.addAttribute("cartItems", cartItems);
        return "user/cart";
    }

    // 장바구니 추가
    @PostMapping("/add")
    public String addToCart(CartDto cartDto, HttpSession session) {
        String userId = (String) session.getAttribute("userId");

        // 사용자가 로그인하지 않았다면 로그인 페이지로 이동
        if (userId == null) {
            return "redirect:/login";
        }

        // CartDto에 사용자 ID 추가
        cartDto.setUserId(userId);

        // 장바구니에 상품 추가
        cartService.addCart(cartDto);

        return "redirect:/user/cart";  // 장바구니 페이지로 리다이렉트
    }
    // 장바구니 삭제
    @DeleteMapping("/delete/{cartId}")
    @ResponseBody
    public String deleteCart(@PathVariable Long cartId) {
        cartService.deleteCart(cartId);
        return "장바구니에서 제거되었습니다.";
    }
}
