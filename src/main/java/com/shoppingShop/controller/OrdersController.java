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

        // 단순히 주문 데이터를 서비스에 넘겨 저장
        ordersService.placeOrder(userId, cartIds);

        // 주문 완료 후 주문 내역 페이지로 리다이렉트
        return "redirect:/orders/history";
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
    public String getOrderList(HttpSession session,Model model){
        String userId = (String) session.getAttribute("userId");

        List<OrdersDto> getOrderList = ordersService.getSelectOrderList(userId);
        model.addAttribute("orderList",getOrderList);

        return "user/orderList";

    }
}

