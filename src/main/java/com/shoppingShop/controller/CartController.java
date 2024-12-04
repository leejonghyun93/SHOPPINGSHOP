package com.shoppingShop.controller;

import com.shoppingShop.domain.CartDto;
import com.shoppingShop.domain.ProductDto;
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
    @GetMapping("/cart")
    public ResponseEntity<Map<String, Object>> getCart(HttpSession session) {
        String userId = (String) session.getAttribute("userId");
        if (userId == null) {
            // 로그인하지 않은 경우 처리
            return ResponseEntity.status(401).body(Map.of("message", "로그인 후 이용해 주세요"));
        }
        List<CartDto> cartList = cartService.getCartByUserId(userId);
        return ResponseEntity.ok(Map.of("cartList", cartList));
    }
    @PostMapping("/add")
    public @ResponseBody ResponseEntity<Map<String, Object>> addToCart(@RequestBody CartDto cartDto, ProductDto productDto, HttpSession session) {
        System.out.println("Received CartDto: " + cartDto);
        System.out.println("Received ProductDto: " + productDto);

        // session에서 userId를 가져옵니다
        String userId = (String) session.getAttribute("userId");

        if (userId == null) {
            Map<String, Object> response = new HashMap<>();
            response.put("message", "로그인이 필요합니다.");
            return ResponseEntity.status(401).body(response);
        }

        // cartDto에 userId를 설정합니다
        cartDto.setUserId(userId);

        // productDto에서 값 가져오기
        cartDto.setProName(productDto.getProName());
        cartDto.setProColor(productDto.getProColor());
        cartDto.setProSize(productDto.getProSize());
        cartDto.setTotalPrice(productDto.getProPrice());

        // cartService.addCart 호출
        cartService.addCart(cartDto,productDto);

        Map<String, Object> response = new HashMap<>();
        response.put("message", "장바구니에 상품이 추가되었습니다.");
        response.put("cart", cartDto); // 추가된 데이터 반환(선택 사항)

        return ResponseEntity.ok(response); // JSON 형식으로 반환
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