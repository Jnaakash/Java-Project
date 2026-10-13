package com.shopsphere.swing.controller;

import com.shopsphere.swing.dao.OrderDAO;

import java.util.List;

public class OrderController {

    private final OrderDAO orderDAO;

    public OrderController() {
        orderDAO = new OrderDAO();
    }

    public List<Object[]> getAllOrders() {
        return orderDAO.getAllOrders();
    }

    public boolean updateOrderStatus(int orderId, String status) {

        if (orderId <= 0) {
            return false;
        }

        if (status == null || status.trim().isEmpty()) {
            return false;
        }

        return orderDAO.updateOrderStatus(
                orderId,
                status.trim()
        );
    }

    public List<Object[]> getOrderItems(int orderId) {

        if (orderId <= 0) {
            return List.of();
        }

        return orderDAO.getOrderItems(orderId);
    }
}