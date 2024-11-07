package com.shoppingShop.controller;

import com.shoppingShop.domain.CartDto;
import com.shoppingShop.service.CartService;
import org.springframework.beans.factory.annotation.Autowired;
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

    // 장바구니 아이템 보기 및 추가 기능
    @GetMapping
    public String viewCart(HttpSession session, Model model) {
        // 세션에서 userId를 가져옵니다.
        String userId = (String) session.getAttribute("userId");

        if (userId == null) {
            // userId가 없으면 로그인 페이지로 리다이렉트
            return "redirect:/login";
        }

        // 세션에서 선택한 색상과 사이즈 정보 가져오기
        String color = (String) session.getAttribute("selectedColor");
        String size = (String) session.getAttribute("selectedSize");

        // 색상과 사이즈가 있을 경우 장바구니에 추가
        if (color != null && size != null) {
            CartDto cart = new CartDto();
            cart.setUserId(userId); // 장바구니에 사용자 ID 설정

            cartService.addCart(cart);
            session.removeAttribute("selectedColor");
            session.removeAttribute("selectedSize");
        }

        // 사용자의 장바구니 아이템을 가져와 모델에 추가
        List<CartDto> cartItems = cartService.getCartByUserId(userId);
        model.addAttribute("cartItems", cartItems);

        return "user/cart";
    }

    // 장바구니에서 상품 제거
    @DeleteMapping("/delete/{cartId}")
    @ResponseBody
    public String deleteCart(@PathVariable Long cartId) {
        cartService.deleteCart(cartId);
        return "장바구니에서 제거되었습니다.";
    }

    // 색상과 사이즈를 세션에 저장하는 기능 추가 (주로 선택 시 호출)
    @PostMapping("/select")
    @ResponseBody
    public String selectColorAndSize(@RequestParam String color, @RequestParam String size, HttpSession session) {
        session.setAttribute("selectedColor", color);
        session.setAttribute("selectedSize", size);
        return "색상과 사이즈가 선택되었습니다.";
    }
}
