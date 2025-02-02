package com.shoppingShop.controller;

import com.shoppingShop.domain.CartDto;
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

@Controller // 이 클래스가 Spring MVC의 컨트롤러임을 나타냅니다.
@RequestMapping("/cart") // 이 컨트롤러의 요청 경로 기본값을 "/cart"로 설정합니다.
public class CartController {

    @Autowired // CartService 빈을 자동으로 주입합니다.
    private CartService cartService;

    // 장바구니 조회
    @GetMapping("/cart") // HTTP GET 요청이 "/cart/cart"로 들어올 때 이 메서드가 호출됩니다.
    public String getCart(HttpSession session, Model model) {
        String userId = (String) session.getAttribute("userId"); // 세션에서 사용자 ID를 가져옵니다.
        if (userId == null) { // 사용자가 로그인하지 않은 경우
            model.addAttribute("message", "로그인 후 이용해 주세요."); // 모델에 메시지를 추가합니다.
            return "login/login"; // 로그인 페이지로 이동합니다.
        }

        List<CartDto> cartItems = cartService.getCartByUserId(userId); // 사용자 ID로 장바구니 항목을 가져옵니다.
        model.addAttribute("cartItems", cartItems); // 모델에 장바구니 항목을 추가합니다.
        return "user/cart"; // 장바구니 페이지로 이동합니다.
    }

    // 장바구니에 상품 추가
    @PostMapping("/add") // HTTP POST 요청이 "/cart/add"로 들어올 때 이 메서드가 호출됩니다.
    public ResponseEntity<Map<String, Object>> addToCart(@RequestBody CartDto cartDto, HttpSession session) {
        String userId = (String) session.getAttribute("userId"); // 세션에서 사용자 ID를 가져옵니다.
        Map<String, Object> response = new HashMap<>(); // 응답 데이터를 저장할 맵을 생성합니다.

        if (userId == null) { // 사용자가 로그인하지 않은 경우
            response.put("message", "로그인이 필요합니다."); // 응답 맵에 메시지를 추가합니다.
            return ResponseEntity.status(401).body(response); // 401 Unauthorized 상태로 응답합니다.
        }

        cartDto.setUserId(userId); // CartDto에 사용자 ID를 설정합니다.

        try {
            cartService.addCart(cartDto); // 장바구니에 상품을 추가합니다.
            response.put("message", "장바구니에 상품이 추가되었습니다."); // 성공 메시지를 응답 맵에 추가합니다.
            response.put("cart", cartDto); // 추가된 장바구니 항목을 응답 맵에 추가합니다.
            return ResponseEntity.ok(response); // 200 OK 상태로 응답합니다.
        } catch (IllegalArgumentException e) { // 잘못된 인자가 전달된 경우
            response.put("message", e.getMessage()); // 예외 메시지를 응답 맵에 추가합니다.
            return ResponseEntity.status(400).body(response); // 400 Bad Request 상태로 응답합니다.
        }
    }

    // 장바구니에 동일한 상품이 있는지 확인
    @PostMapping("/checkCartItem") // HTTP POST 요청이 "/cart/checkCartItem"으로 들어올 때 이 메서드가 호출됩니다.
    public ResponseEntity<Map<String, Object>> checkCartItem(@RequestBody CartDto cartDto, HttpSession session) {
        String userId = (String) session.getAttribute("userId"); // 세션에서 사용자 ID를 가져옵니다.
        Map<String, Object> response = new HashMap<>(); // 응답 데이터를 저장할 맵을 생성합니다.

        if (userId == null) { // 사용자가 로그인하지 않은 경우
            response.put("message", "로그인이 필요합니다."); // 응답 맵에 메시지를 추가합니다.
            return ResponseEntity.status(401).body(response); // 401 Unauthorized 상태로 응답합니다.
        }

        cartDto.setUserId(userId); // CartDto에 사용자 ID를 설정합니다.

        boolean isExist = cartService.isItemInCart(cartDto); // 장바구니에 동일한 상품이 있는지 확인합니다.

        if (isExist) { // 동일한 상품이 이미 있는 경우
            response.put("message", "이미 장바구니에 추가된 상품입니다."); // 응답 맵에 메시지를 추가합니다.
            return ResponseEntity.status(409).body(response); // 409 Conflict 상태로 응답합니다.
        } else { // 동일한 상품이 없는 경우
            response.put("message", "장바구니에 상품을 추가할 수 있습니다."); // 응답 맵에 메시지를 추가합니다.
            return ResponseEntity.ok(response); // 200 OK 상태로 응답합니다.
        }
    }

    // 장바구니에서 상품 삭제
    @PostMapping("/delete/{cartId}") // HTTP POST 요청이 "/cart/delete/{cartId}"로 들어올 때 이 메서드가 호출됩니다.
    public String deleteCartItem(@PathVariable Long cartId) {
        cartService.removeCart(cartId); // cartId에 해당하는 장바구니 항목을 삭제합니다.
        return "redirect:/cart/cart"; // 장바구니 페이지로 리다이렉트합니다.
    }

    // 장바구니 비우기
    @PostMapping("/clearCart") // HTTP POST 요청이 "/cart/clearCart"로 들어올 때 이 메서드가 호출됩니다.
    public String deleteAllCart(HttpSession session) {
        String userId = (String) session.getAttribute("userId"); // 세션에서 사용자 ID를 가져옵니다.

        if (userId == null) { // 사용자가 로그인하지 않은 경우
            return "redirect:/login/login"; // 로그인 페이지로 리다이렉트합니다.
        }

        cartService.clearCartByUserId(userId); // 사용자 ID에 해당하는 모든 장바구니 항목을 삭제합니다.
        return "redirect:/cart/cart"; // 장바구니 페이지로 리다이렉트합니다.
    }
}
