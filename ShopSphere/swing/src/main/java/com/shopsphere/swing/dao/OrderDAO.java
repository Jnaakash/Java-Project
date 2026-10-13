package com.shopsphere.swing.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {

    private static final String URL =
            "jdbc:mysql://localhost:3306/shopsphere";

    private static final String USER = "root";

    private static final String PASSWORD =
            "@k@sh0706";

    private Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }

    // Load all orders
    public List<Object[]> getAllOrders() {

        List<Object[]> orders = new ArrayList<>();

        String sql = """
                SELECT
                    o.order_id,
                    u.name AS customer_name,
                    o.total_amount,
                    o.created_at,
                    o.order_status
                FROM orders o
                JOIN users u
                    ON o.user_id = u.user_id
                ORDER BY o.order_id DESC
                """;

        try (
                Connection connection = getConnection();
                PreparedStatement statement =
                        connection.prepareStatement(sql);
                ResultSet resultSet = statement.executeQuery()
        ) {

            while (resultSet.next()) {

                Object[] order = {
                        resultSet.getInt("order_id"),
                        resultSet.getString("customer_name"),
                        resultSet.getDouble("total_amount"),
                        resultSet.getTimestamp("created_at"),
                        resultSet.getString("order_status")
                };

                orders.add(order);
            }

        } catch (Exception e) {
            System.out.println(
                    "Error loading orders: " + e.getMessage()
            );
        }

        return orders;
    }

    // Update order status
    public boolean updateOrderStatus(
            int orderId,
            String status
    ) {

        String sql = """
                UPDATE orders
                SET order_status = ?
                WHERE order_id = ?
                """;

        try (
                Connection connection = getConnection();
                PreparedStatement statement =
                        connection.prepareStatement(sql)
        ) {

            statement.setString(1, status);
            statement.setInt(2, orderId);

            return statement.executeUpdate() > 0;

        } catch (Exception e) {

            System.out.println(
                    "Error updating order status: "
                    + e.getMessage()
            );

            return false;
        }
    }

    // Get order item details
    public List<Object[]> getOrderItems(int orderId) {

        List<Object[]> items = new ArrayList<>();

        String sql = """
                SELECT
                    p.name AS product_name,
                    oi.quantity,
                    oi.price,
                    (oi.quantity * oi.price) AS line_total
                FROM order_items oi
                JOIN products p
                    ON oi.product_id = p.product_id
                WHERE oi.order_id = ?
                ORDER BY oi.order_item_id
                """;

        try (
                Connection connection = getConnection();
                PreparedStatement statement =
                        connection.prepareStatement(sql)
        ) {

            statement.setInt(1, orderId);

            try (ResultSet resultSet =
                         statement.executeQuery()) {

                while (resultSet.next()) {

                    Object[] item = {
                            resultSet.getString("product_name"),
                            resultSet.getInt("quantity"),
                            resultSet.getDouble("price"),
                            resultSet.getDouble("line_total")
                    };

                    items.add(item);
                }
            }

        } catch (Exception e) {

            System.out.println(
                    "Error loading order items: "
                    + e.getMessage()
            );
        }

        return items;
    }
}