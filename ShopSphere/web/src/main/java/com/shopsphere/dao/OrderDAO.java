package com.shopsphere.dao;

import com.shopsphere.model.Order;
import com.shopsphere.model.OrderItem;
import com.shopsphere.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {

    // =====================================================
    // CREATE ORDER + ORDER ITEMS + STOCK UPDATE
    // =====================================================
    public int createOrder(Order order,
                           List<OrderItem> orderItems) {

        String productSql =
                "SELECT price, stock, status " +
                "FROM products " +
                "WHERE product_id = ? " +
                "FOR UPDATE";

        String orderSql =
                "INSERT INTO orders " +
                "(user_id, address_id, total_amount, discount, " +
                "payment_method, payment_status, order_status) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?)";

        String itemSql =
                "INSERT INTO order_items " +
                "(order_id, product_id, quantity, price) " +
                "VALUES (?, ?, ?, ?)";

        String stockSql =
                "UPDATE products " +
                "SET stock = stock - ? " +
                "WHERE product_id = ? " +
                "AND status = TRUE " +
                "AND stock >= ?";

        Connection connection = null;

        try {

            connection = DBConnection.getConnection();
            connection.setAutoCommit(false);

            // =================================================
            // STEP 1: VERIFY PRODUCTS + STOCK + GET DB PRICES
            // =================================================

            double calculatedTotal = 0.0;

            try (PreparedStatement productPS =
                         connection.prepareStatement(productSql)) {

                for (OrderItem item : orderItems) {

                    if (item.getQuantity() <= 0) {
                        throw new Exception(
                                "Invalid product quantity"
                        );
                    }

                    productPS.setInt(
                            1,
                            item.getProductId()
                    );

                    try (ResultSet rs =
                                 productPS.executeQuery()) {

                        if (!rs.next()) {
                            throw new Exception(
                                    "Product not found: "
                                    + item.getProductId()
                            );
                        }

                        double dbPrice =
                                rs.getDouble("price");

                        int stock =
                                rs.getInt("stock");

                        boolean active =
                                rs.getBoolean("status");

                        if (!active) {
                            throw new Exception(
                                    "Product is inactive: "
                                    + item.getProductId()
                            );
                        }

                        if (stock < item.getQuantity()) {
                            throw new Exception(
                                    "Insufficient stock for product: "
                                    + item.getProductId()
                            );
                        }

                        // -----------------------------------------
                        // IMPORTANT:
                        // Always use CURRENT DATABASE PRICE
                        // -----------------------------------------

                        item.setPrice(dbPrice);

                        calculatedTotal +=
                                dbPrice *
                                item.getQuantity();
                    }
                }
            }

            // =================================================
            // STEP 2: SET SERVER-SIDE TOTAL
            // =================================================

            order.setTotalAmount(calculatedTotal);
            order.setDiscount(0.00);

            // =================================================
            // STEP 3: INSERT ORDER
            // =================================================

            int orderId;

            try (PreparedStatement ps =
                         connection.prepareStatement(
                                 orderSql,
                                 PreparedStatement.RETURN_GENERATED_KEYS
                         )) {

                ps.setInt(
                        1,
                        order.getUserId()
                );

                ps.setInt(
                        2,
                        order.getAddressId()
                );

                ps.setDouble(
                        3,
                        order.getTotalAmount()
                );

                ps.setDouble(
                        4,
                        order.getDiscount()
                );

                ps.setString(
                        5,
                        order.getPaymentMethod()
                );

                ps.setString(
                        6,
                        order.getPaymentStatus()
                );

                ps.setString(
                        7,
                        order.getOrderStatus()
                );

                ps.executeUpdate();

                try (ResultSet rs =
                             ps.getGeneratedKeys()) {

                    if (!rs.next()) {

                        throw new Exception(
                                "Order ID could not be generated"
                        );
                    }

                    orderId =
                            rs.getInt(1);
                }
            }

            // =================================================
            // STEP 4: INSERT ORDER ITEMS
            // =================================================

            try (PreparedStatement ps =
                         connection.prepareStatement(itemSql)) {

                for (OrderItem item : orderItems) {

                    ps.setInt(
                            1,
                            orderId
                    );

                    ps.setInt(
                            2,
                            item.getProductId()
                    );

                    ps.setInt(
                            3,
                            item.getQuantity()
                    );

                    ps.setDouble(
                            4,
                            item.getPrice()
                    );

                    ps.addBatch();
                }

                ps.executeBatch();
            }

            // =================================================
            // STEP 5: DECREASE STOCK
            // =================================================

            try (PreparedStatement stockPS =
                         connection.prepareStatement(stockSql)) {

                for (OrderItem item : orderItems) {

                    stockPS.setInt(
                            1,
                            item.getQuantity()
                    );

                    stockPS.setInt(
                            2,
                            item.getProductId()
                    );

                    stockPS.setInt(
                            3,
                            item.getQuantity()
                    );

                    int updatedRows =
                            stockPS.executeUpdate();

                    if (updatedRows != 1) {

                        throw new Exception(
                                "Stock update failed for product: "
                                + item.getProductId()
                        );
                    }
                }
            }

            // =================================================
            // STEP 6: COMMIT
            // =================================================

            connection.commit();

            return orderId;

        } catch (Exception e) {

            // =================================================
            // ROLLBACK EVERYTHING
            // =================================================

            if (connection != null) {

                try {
                    connection.rollback();

                } catch (Exception rollbackException) {

                    rollbackException.printStackTrace();
                }
            }

            e.printStackTrace();

            return -1;

        } finally {

            if (connection != null) {

                try {

                    connection.setAutoCommit(true);
                    connection.close();

                } catch (Exception e) {

                    e.printStackTrace();
                }
            }
        }
    }


    // =====================================================
    // GET ORDERS BY USER ID
    // =====================================================
    public List<Order> getOrdersByUserId(int userId) {

        List<Order> orders =
                new ArrayList<>();

        String sql =
                "SELECT * FROM orders " +
                "WHERE user_id = ? " +
                "ORDER BY created_at DESC";

        try (
                Connection connection =
                        DBConnection.getConnection();

                PreparedStatement ps =
                        connection.prepareStatement(sql)
        ) {

            ps.setInt(1, userId);

            try (ResultSet rs =
                         ps.executeQuery()) {

                while (rs.next()) {

                    Order order =
                            mapOrder(rs);

                    orders.add(order);
                }
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return orders;
    }


    // =====================================================
    // GET ALL ORDERS - ADMIN
    // =====================================================
    public List<Order> getAllOrders() {

        List<Order> orders =
                new ArrayList<>();

        String sql =
                "SELECT * FROM orders " +
                "ORDER BY created_at DESC";

        try (
                Connection connection =
                        DBConnection.getConnection();

                PreparedStatement ps =
                        connection.prepareStatement(sql);

                ResultSet rs =
                        ps.executeQuery()
        ) {

            while (rs.next()) {

                orders.add(
                        mapOrder(rs)
                );
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return orders;
    }


    // =====================================================
    // SEARCH AND FILTER ORDERS - ADMIN
    // =====================================================
    public List<Order> searchOrdersForAdmin(
            String keyword,
            String statusFilter,
            int page,
            int pageSize) {

        List<Order> orders =
                new ArrayList<>();

        StringBuilder sql =
                new StringBuilder(
                        "SELECT * FROM orders WHERE 1=1"
                );

        if (keyword != null
                && !keyword.trim().isEmpty()) {

            sql.append(
                    " AND (" +
                    "CAST(order_id AS CHAR) LIKE ? " +
                    "OR CAST(user_id AS CHAR) LIKE ?" +
                    ")"
            );
        }

        if (statusFilter != null
                && !statusFilter.trim().isEmpty()
                && !statusFilter.equalsIgnoreCase("ALL")) {

            sql.append(
                    " AND order_status = ?"
            );
        }

        sql.append(
                " ORDER BY created_at DESC " +
                "LIMIT ? OFFSET ?"
        );

        try (
                Connection connection =
                        DBConnection.getConnection();

                PreparedStatement ps =
                        connection.prepareStatement(
                                sql.toString()
                        )
        ) {

            int parameterIndex = 1;

            if (keyword != null
                    && !keyword.trim().isEmpty()) {

                String searchKeyword =
                        "%" + keyword.trim() + "%";

                ps.setString(
                        parameterIndex++,
                        searchKeyword
                );

                ps.setString(
                        parameterIndex++,
                        searchKeyword
                );
            }

            if (statusFilter != null
                    && !statusFilter.trim().isEmpty()
                    && !statusFilter.equalsIgnoreCase("ALL")) {

                ps.setString(
                        parameterIndex++,
                        statusFilter
                );
            }

            int offset =
                    Math.max(0, page - 1)
                    * pageSize;

            ps.setInt(
                    parameterIndex++,
                    pageSize
            );

            ps.setInt(
                    parameterIndex,
                    offset
            );

            try (ResultSet rs =
                         ps.executeQuery()) {

                while (rs.next()) {

                    orders.add(
                            mapOrder(rs)
                    );
                }
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return orders;
    }


    // =====================================================
    // GET ORDER COUNT - ADMIN
    // =====================================================
    public int getOrderCountForAdmin(
            String keyword,
            String statusFilter) {

        int count = 0;

        StringBuilder sql =
                new StringBuilder(
                        "SELECT COUNT(*) " +
                        "FROM orders " +
                        "WHERE 1=1"
                );

        if (keyword != null
                && !keyword.trim().isEmpty()) {

            sql.append(
                    " AND (" +
                    "CAST(order_id AS CHAR) LIKE ? " +
                    "OR CAST(user_id AS CHAR) LIKE ?" +
                    ")"
            );
        }

        if (statusFilter != null
                && !statusFilter.trim().isEmpty()
                && !statusFilter.equalsIgnoreCase("ALL")) {

            sql.append(
                    " AND order_status = ?"
            );
        }

        try (
                Connection connection =
                        DBConnection.getConnection();

                PreparedStatement ps =
                        connection.prepareStatement(
                                sql.toString()
                        )
        ) {

            int parameterIndex = 1;

            if (keyword != null
                    && !keyword.trim().isEmpty()) {

                String searchKeyword =
                        "%" + keyword.trim() + "%";

                ps.setString(
                        parameterIndex++,
                        searchKeyword
                );

                ps.setString(
                        parameterIndex++,
                        searchKeyword
                );
            }

            if (statusFilter != null
                    && !statusFilter.trim().isEmpty()
                    && !statusFilter.equalsIgnoreCase("ALL")) {

                ps.setString(
                        parameterIndex,
                        statusFilter
                );
            }

            try (ResultSet rs =
                         ps.executeQuery()) {

                if (rs.next()) {

                    count =
                            rs.getInt(1);
                }
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return count;
    }


    // =====================================================
    // UPDATE ORDER STATUS - ADMIN
    // =====================================================
    public boolean updateOrderStatus(
            int orderId,
            String orderStatus) {

        String sql =
                "UPDATE orders " +
                "SET order_status = ? " +
                "WHERE order_id = ?";

        try (
                Connection connection =
                        DBConnection.getConnection();

                PreparedStatement ps =
                        connection.prepareStatement(sql)
        ) {

            ps.setString(
                    1,
                    orderStatus
            );

            ps.setInt(
                    2,
                    orderId
            );

            return ps.executeUpdate() > 0;

        } catch (Exception e) {

            e.printStackTrace();
        }

        return false;
    }


    // =====================================================
    // GET TOTAL ORDER COUNT
    // =====================================================
    public int getTotalOrderCount() {

        String sql =
                "SELECT COUNT(*) FROM orders";

        try (
                Connection connection =
                        DBConnection.getConnection();

                PreparedStatement ps =
                        connection.prepareStatement(sql);

                ResultSet rs =
                        ps.executeQuery()
        ) {

            if (rs.next()) {

                return rs.getInt(1);
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return 0;
    }


    // =====================================================
    // GET PENDING ORDER COUNT
    // =====================================================
    public int getPendingOrderCount() {

        String sql =
                "SELECT COUNT(*) " +
                "FROM orders " +
                "WHERE order_status = 'PLACED'";

        try (
                Connection connection =
                        DBConnection.getConnection();

                PreparedStatement ps =
                        connection.prepareStatement(sql);

                ResultSet rs =
                        ps.executeQuery()
        ) {

            if (rs.next()) {

                return rs.getInt(1);
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return 0;
    }


    // =====================================================
    // GET DELIVERED ORDER COUNT
    // =====================================================
    public int getDeliveredOrderCount() {

        String sql =
                "SELECT COUNT(*) " +
                "FROM orders " +
                "WHERE order_status = 'DELIVERED'";

        try (
                Connection connection =
                        DBConnection.getConnection();

                PreparedStatement ps =
                        connection.prepareStatement(sql);

                ResultSet rs =
                        ps.executeQuery()
        ) {

            if (rs.next()) {

                return rs.getInt(1);
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return 0;
    }


    // =====================================================
    // GET RECENT ORDERS
    // =====================================================
    public List<Order> getRecentOrders() {

        List<Order> orders =
                new ArrayList<>();

        String sql =
                "SELECT * FROM orders " +
                "ORDER BY created_at DESC " +
                "LIMIT 5";

        try (
                Connection connection =
                        DBConnection.getConnection();

                PreparedStatement ps =
                        connection.prepareStatement(sql);

                ResultSet rs =
                        ps.executeQuery()
        ) {

            while (rs.next()) {

                orders.add(
                        mapOrder(rs)
                );
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return orders;
    }


    // =====================================================
    // GET TOTAL SALES
    // =====================================================
    public double getTotalSales() {

        String sql =
                "SELECT COALESCE(SUM(total_amount), 0) " +
                "FROM orders " +
                "WHERE order_status != 'CANCELLED'";

        try (
                Connection connection =
                        DBConnection.getConnection();

                PreparedStatement ps =
                        connection.prepareStatement(sql);

                ResultSet rs =
                        ps.executeQuery()
        ) {

            if (rs.next()) {

                return rs.getDouble(1);
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return 0.0;
    }


    // =====================================================
    // COMMON ORDER MAPPER
    // =====================================================
    private Order mapOrder(ResultSet rs)
            throws Exception {

        Order order =
                new Order();

        order.setOrderId(
                rs.getInt("order_id")
        );

        order.setUserId(
                rs.getInt("user_id")
        );

        order.setAddressId(
                rs.getInt("address_id")
        );

        order.setTotalAmount(
                rs.getDouble("total_amount")
        );

        order.setDiscount(
                rs.getDouble("discount")
        );

        order.setPaymentMethod(
                rs.getString("payment_method")
        );

        order.setPaymentStatus(
                rs.getString("payment_status")
        );

        order.setOrderStatus(
                rs.getString("order_status")
        );

        order.setCreatedAt(
                rs.getTimestamp("created_at")
        );

        return order;
    }
}