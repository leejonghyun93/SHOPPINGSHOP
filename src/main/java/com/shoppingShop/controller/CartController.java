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

    // 장바구니 보기
    @GetMapping
    public String viewCart(HttpSession session, Model model) {
        String userId = (String) session.getAttribute("userId");

        if (userId == null) {
            return "redirect:/login"; // 로그인 페이지로 리다이렉트
        }

        // 사용자 ID로 장바구니 항목 가져오기
        List<CartDto> cartItems = cartService.selectCartByUserId(userId);
        model.addAttribute("cartItems", cartItems);

        return "user/cart";  // JSP 파일 경로 (예: /WEB-INF/views/user/cart.jsp)
    }

    // 장바구니 항목 추가
    @PostMapping("/add")
    public ResponseEntity<Map<String, Object>> addToCart(@RequestBody CartDto cartDto) {
        try {
            // DTO 매핑된 값 출력 확인
            System.out.println("Received CartDto: " + cartDto);

            // 로직 처리
            Map<String, Object> response = new HashMap<>();
            response.put("message", "장바구니에 상품이 추가되었습니다.");
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
        }
    }



    // 장바구니 항목 삭제
    @DeleteMapping("/delete/{cartId}")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> deleteCart(@PathVariable Long cartId, HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        String userId = (String) session.getAttribute("userId");

        if (userId == null) {
            response.put("success", false);
            response.put("message", "로그인이 필요합니다.");
            return ResponseEntity.status(401).body(response);
        }

        // 장바구니 항목 삭제
        cartService.deleteCart(cartId);
        response.put("success", true);
        response.put("message", "장바구니에서 삭제되었습니다.");
        return ResponseEntity.ok(response);
    }
}
