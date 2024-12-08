package com.shoppingShop.controller;

import com.shoppingShop.domain.OrdersDto;
import com.shoppingShop.service.OrdersService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/orders")
public class OrdersController {

    @Autowired
    private OrdersService ordersService;

    @PostMapping("/checkout")
    public String checkout(@RequestParam("cartIds") List<Long> cartIds, HttpSession session) {
        String userId = (String) session.getAttribute("userId");

        // Mock 데이터
        List<OrdersDto> orders = new ArrayList<>();
        for (Long cartId : cartIds) {
            OrdersDto order = new OrdersDto();
            order.setUserId(userId);
            order.setCartId(cartId);
            order.setOdStatus("결제완료");
            order.setQuantity(1); // 임시 수량
            order.setUnitPrice(50000); // 임시 단가
            order.setShippingFee(2500); // 임시 배송비
            order.setOdTotalPrice(order.getQuantity() * order.getUnitPrice() + order.getShippingFee());
            orders.add(order);
        }

        // 주문 생성
        ordersService.placeOrder(orders);

        return "redirect:/orders/history";
    }

    @GetMapping("/history")
    public String orderHistory(HttpSession session, Model model) {
        String userId = (String) session.getAttribute("userId");
        List<OrdersDto> orderHistory = ordersService.getOrderHistory(userId);

        model.addAttribute("orderHistory", orderHistory);
        return "orderHistory"; // 주문 내역 JSP 페이지
    }
}