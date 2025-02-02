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
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Controller // 이 클래스가 Spring MVC의 컨트롤러임을 나타냅니다.
@RequestMapping("/orders") // "/orders" 경로로 들어오는 요청을 이 컨트롤러에서 처리합니다.
public class OrdersController {

    @Autowired // OrdersService 빈을 자동으로 주입합니다.
    private OrdersService ordersService;

    @PostMapping("/checkout") // "/orders/checkout" 경로로 들어오는 POST 요청을 처리합니다.
    @ResponseBody // 메서드의 반환값을 HTTP 응답 본문으로 직접 반환합니다.
    public ResponseEntity<String> checkout(@RequestBody Map<String, List<Long>> payload, HttpSession session) {
        // HTTP 요청 본문을 Map으로 받아오고, 현재 세션을 가져옵니다.

        String userId = (String) session.getAttribute("userId");
        // 세션에서 "userId"를 가져옵니다.

        if (userId == null) {
            // 세션에 "userId"가 없으면
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("로그인 상태가 아닙니다.");
            // 401 Unauthorized 상태 코드와 메시지를 반환합니다.
        }

        List<Long> cartIds = payload.get("cartIds");
        // 요청 본문에서 "cartIds" 리스트를 가져옵니다.

        if (cartIds != null && !cartIds.isEmpty()) {
            // "cartIds"가 null이 아니고 비어있지 않으면
            try {
                ordersService.placeOrder(userId, cartIds);
                // 주문을 처리합니다.
                return ResponseEntity.ok("주문이 완료되었습니다.");
                // 200 OK 상태 코드와 성공 메시지를 반환합니다.
            } catch (Exception e) {
                // 주문 처리 중 예외가 발생하면
                return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("주문 처리에 실패했습니다.");
                // 500 Internal Server Error 상태 코드와 에러 메시지를 반환합니다.
            }
        } else {
            // "cartIds"가 null이거나 비어있으면
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("선택된 상품이 없습니다.");
            // 400 Bad Request 상태 코드와 에러 메시지를 반환합니다.
        }
    }

    @GetMapping("/history") // "/orders/history" 경로로 들어오는 GET 요청을 처리합니다.
    public String orderHistory(HttpSession session, Model model) {
        // 현재 세션과 모델 객체를 가져옵니다.

        String userId = (String) session.getAttribute("userId");
        // 세션에서 "userId"를 가져옵니다.

        List<OrdersDto> orderHistory = ordersService.getOrderHistory(userId);
        // 사용자의 주문 내역을 가져옵니다.

        model.addAttribute("orderHistory", orderHistory);
        // 모델에 주문 내역을 추가합니다.

        return "user/orderHistory";
        // "user/orderHistory" 뷰를 반환합니다.
    }

    @GetMapping("/list") // "/orders/list" 경로로 들어오는 GET 요청을 처리합니다.
    public String getOrderList(HttpSession session, Model model) {
        // 현재 세션과 모델 객체를 가져옵니다.

        String userId = (String) session.getAttribute("userId");
        // 세션에서 "userId"를 가져옵니다.

        List<OrdersDto> orders = ordersService.getSelectOrderList(userId);
        // 사용자의 주문 목록을 가져옵니다.

        Map<String, List<OrdersDto>> groupedOrders = orders.stream()
                .collect(Collectors.groupingBy(order -> order.getCreatedAt().toLocalDate().toString()));
        // 주문을 생성일자별로 그룹화합니다.

        model.addAttribute("ordersByDate", groupedOrders);
        // 모델에 날짜별로 그룹화된 주문 데이터를 추가합니다.

        model.addAttribute("hasOrders", !groupedOrders.isEmpty());
        // 주문이 있는지 여부를 모델에 추가합니다.

        return "user/orderList";
        // "user/orderList" 뷰를 반환합니다.
    }
}
