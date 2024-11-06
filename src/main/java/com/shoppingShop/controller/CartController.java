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
    public String viewCart(HttpSession session, @RequestParam("userId") String userId, Model model) {

        // 세션에서 색상과 사이즈 정보 가져오기
        String color = (String) session.getAttribute("selectedColor");
        String size = (String) session.getAttribute("selectedSize");

        // 색상과 사이즈가 있을 경우 장바구니에 추가
        if (color != null && size != null) {
            CartDto cart = new CartDto();

            cartService.addCart(cart);
            session.removeAttribute("selectedColor");  // 세션에서 색상과 사이즈 삭제
            session.removeAttribute("selectedSize");
        }

        // 사용자의 장바구니 아이템을 가져와 모델에 추가
        List<CartDto> cartItems = cartService.getCartByUserId(userId);
        model.addAttribute("cartItems", cartItems);

        // 장바구니 페이지 반환
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
