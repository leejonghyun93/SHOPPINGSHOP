package com.shoppingShop.controller;

import com.shoppingShop.domain.OrdersDto;
import com.shoppingShop.service.OrdersService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/orders")
public class OrdersController {

    @Autowired
    private OrdersService ordersService;

    @PostMapping("/checkout")
    @ResponseBody
    public ResponseEntity<String> checkout(@RequestBody Map<String, List<Long>> payload, HttpSession session) {
        // 세션에서 userId를 가져옵니다.
        String userId = (String) session.getAttribute("userId");

        // 세션에 userId가 없으면 주문을 처리할 수 없으므로 400 오류를 반환합니다.
        if (userId == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("로그인 상태가 아닙니다.");
        }

        List<Long> cartIds = payload.get("cartIds");

        // cartIds가 비어있지 않다면 주문을 처리
        if (cartIds != null && !cartIds.isEmpty()) {
            try {
                // 주문 처리 메서드 호출, userId와 cartIds를 함께 전달
                ordersService.placeOrder(userId, cartIds);
                return ResponseEntity.ok("주문이 완료되었습니다.");
            } catch (Exception e) {
                return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("주문 처리에 실패했습니다.");
            }
        } else {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("선택된 상품이 없습니다.");
        }
    }

    @GetMapping("/history")
    public String orderHistory(HttpSession session, Model model) {
        String userId = (String) session.getAttribute("userId");

        // 주문 내역 가져오기
        List<OrdersDto> orderHistory = ordersService.getOrderHistory(userId);

        // 모델에 주문 내역 추가
        model.addAttribute("orderHistory", orderHistory);

        return "user/orderHistory"; // 주문 내역 JSP 페이지
    }

    @GetMapping("/list")
    public String getOrderList(HttpSession session, Model model) {
        String userId = (String) session.getAttribute("userId");

        List<OrdersDto> orders = ordersService.getSelectOrderList(userId);

        // 날짜별로 주문 데이터를 그룹화
        Map<String, List<OrdersDto>> groupedOrders = orders.stream()
                .collect(Collectors.groupingBy(order -> order.getCreatedAt().toLocalDate().toString()));

        // JSP에서 접근할 수 있도록 데이터 전달
        model.addAttribute("ordersByDate", groupedOrders);

        // 주문이 없을 때를 위해 추가
        model.addAttribute("hasOrders", !groupedOrders.isEmpty());

        return "user/orderList";
    }
}

