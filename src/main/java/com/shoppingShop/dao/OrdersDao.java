package com.shoppingShop.dao;

import com.shoppingShop.domain.OrdersDto;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface OrdersDao {
    void createOrder(OrdersDto order);

    List<OrdersDto> getOrderHistoryByUserId(String userId);


    List<OrdersDto> getSelectOrderList(String userId);
}
