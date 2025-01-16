package com.shoppingShop.service;

import com.shoppingShop.dao.CartDao;
import com.shoppingShop.dao.OrdersDao;
import com.shoppingShop.domain.OrdersDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class OrdersServiceImpl implements OrdersService {

    @Autowired
    private OrdersDao ordersDao;

    @Autowired
    private CartDao cartDao;

    /**
     * 사용자 ID와 장바구니 항목 ID 목록을 받아 주문을 생성하고 장바구니 항목을 삭제합니다.
     *
     * @param userId  사용자 ID
     * @param cartIds 장바구니 항목 ID 목록
     */
    @Override
    @Transactional
    public void placeOrder(String userId, List<Long> cartIds) {
        // 1. 장바구니 항목 조회
        List<OrdersDto> cartItems = cartDao.getCartItemsByIds(cartIds);
        System.out.println("Cart items retrieved: " + cartItems);

        // 2. 주문 처리
        for (OrdersDto cartItem : cartItems) {
            System.out.println("Processing Cart Item - ID: " + cartItem.getCartId() + ", Product ID: " + cartItem.getProId());
            OrdersDto order = new OrdersDto();

            // 주문 데이터 설정
            order.setUserId(userId);
            order.setOdStatus("결제완료");
            order.setQuantity(1); // 수량 기본값 설정
            order.setUnitPrice(cartItem.getUnitPrice());
            order.setShippingFee(cartItem.getShippingFee());
            order.setOdTotalPrice(order.getQuantity() * order.getUnitPrice() + order.getShippingFee());
            order.setCartId(cartItem.getCartId());
            order.setProId(cartItem.getProId());
            order.setCreatedAt(LocalDateTime.now());

            // 주문 DB 저장
            try {
                // 주문 저장 전에 로그를 추가하여 데이터 확인
                System.out.println("Inserting order with details: " + order);
                int result = ordersDao.createOrder(order);
                if (result > 0) {
                    System.out.println("Order created successfully with ID: " + order.getOrderId());
                } else {
                    System.err.println("Failed to create order for Cart Item ID: " + cartItem.getCartId());
                }
            } catch (Exception e) {
                System.err.println("Error inserting order for Cart Item ID: " + cartItem.getCartId() + ". " + e.getMessage());
                e.printStackTrace();
            }
        }

        // 3. 장바구니 항목 삭제
        try {
            deleteCartItemsAfterOrder(cartIds);
        } catch (Exception e) {
            System.err.println("Error during cart item deletion: " + e.getMessage());
            e.printStackTrace();
        }
    }


    /**
     * 주문 생성 후 장바구니 항목 삭제 (별도의 트랜잭션에서 처리)
     *
     * @param cartIds 장바구니 항목 ID 목록
     */
    @Transactional(propagation = Propagation.REQUIRES_NEW)  // 새로운 트랜잭션에서 실행
    public void deleteCartItemsAfterOrder(List<Long> cartIds) {
        try {
            cartDao.deleteCartItems(cartIds);
            System.out.println("Cart items deleted successfully.");
        } catch (Exception e) {
            System.err.println("Error deleting cart items: " + e.getMessage());
            e.printStackTrace();
            throw e; // 트랜잭션 롤백을 위해 예외 다시 던짐
        }
    }

    @Override
    public List<OrdersDto> getOrderHistory(String userId) {
        try {
            return ordersDao.getOrderHistoryByUserId(userId);
        } catch (Exception e) {
            System.err.println("Error retrieving order history for User ID: " + userId + ". " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }

    /**
     * 선택한 주문 목록을 조회합니다.
     *
     * @param userId 사용자 ID
     * @return 선택한 주문 목록
     */
    @Override
    public List<OrdersDto> getSelectOrderList(String userId) {
        try {
            return ordersDao.getSelectOrderList(userId);
        } catch (Exception e) {
            System.err.println("Error retrieving selected orders for User ID: " + userId + ". " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }
}
