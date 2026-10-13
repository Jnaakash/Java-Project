package com.shopsphere.dao;

import com.shopsphere.model.OrderItem;
import com.shopsphere.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class OrderItemDAO {

    public List<OrderItem> getItemsByOrderId(int orderId) {

        List<OrderItem> items = new ArrayList<>();

        String sql =
                "SELECT oi.order_item_id, " +
                "oi.order_id, " +
                "oi.product_id, " +
                "oi.quantity, " +
                "oi.price, " +
                "p.name AS product_name " +
                "FROM order_items oi " +
                "JOIN products p " +
                "ON oi.product_id = p.product_id " +
                "WHERE oi.order_id = ?";

        try (
            Connection connection = DBConnection.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql)
        ) {

            ps.setInt(1, orderId);

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {

                    OrderItem item = new OrderItem();

                    item.setOrderItemId(
                            rs.getInt("order_item_id")
                    );

                    item.setOrderId(
                            rs.getInt("order_id")
                    );

                    item.setProductId(
                            rs.getInt("product_id")
                    );

                    item.setQuantity(
                            rs.getInt("quantity")
                    );

                    item.setPrice(
                            rs.getDouble("price")
                    );

                    item.setProductName(
                            rs.getString("product_name")
                    );

                    items.add(item);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return items;
    }
}