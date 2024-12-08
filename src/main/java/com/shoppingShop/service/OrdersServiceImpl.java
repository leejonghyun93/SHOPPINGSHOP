package com.shoppingShop.service;

import com.shoppingShop.dao.OrdersDao;
import com.shoppingShop.domain.OrdersDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class OrdersServiceImpl implements OrdersService {

    @Autowired
    private OrdersDao ordersDao;

    @Override
    public void placeOrder(List<OrdersDto> orders) {
        for (OrdersDto order : orders) {
            ordersDao.createOrder(order);
        }
    }

    @Override
    public List<OrdersDto> getOrderHistory(String userId) {
        return ordersDao.getOrderHistoryByUserId(userId);
    }
}