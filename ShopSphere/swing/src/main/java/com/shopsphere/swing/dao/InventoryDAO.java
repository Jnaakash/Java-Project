package com.shopsphere.swing.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class InventoryDAO {

    private static final String URL =
            "jdbc:mysql://localhost:3306/shopsphere";

    private static final String USER = "root";

    private static final String PASSWORD =
            "@k@sh0706";

    private Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");

        return DriverManager.getConnection(
                URL,
                USER,
                PASSWORD
        );
    }

    public List<Object[]> getAllInventory() {

        List<Object[]> inventory = new ArrayList<>();

        String sql = """
                SELECT
                    product_id,
                    name,
                    brand,
                    stock,
                    status
                FROM products
                ORDER BY product_id
                """;

        try (
                Connection connection = getConnection();
                PreparedStatement statement =
                        connection.prepareStatement(sql);
                ResultSet resultSet =
                        statement.executeQuery()
        ) {

            while (resultSet.next()) {

                int stock =
                        resultSet.getInt("stock");

                String stockStatus;

                if (stock <= 0) {
                    stockStatus = "OUT OF STOCK";
                } else if (stock <= 10) {
                    stockStatus = "LOW STOCK";
                } else {
                    stockStatus = "IN STOCK";
                }

                Object[] row = {
                        resultSet.getInt("product_id"),
                        resultSet.getString("name"),
                        resultSet.getString("brand"),
                        stock,
                        stockStatus
                };

                inventory.add(row);
            }

        } catch (Exception e) {

            System.out.println(
                    "Error loading inventory: "
                    + e.getMessage()
            );
        }

        return inventory;
    }

    public boolean updateStock(
            int productId,
            int stock
    ) {

        String sql = """
                UPDATE products
                SET stock = ?
                WHERE product_id = ?
                """;

        try (
                Connection connection = getConnection();
                PreparedStatement statement =
                        connection.prepareStatement(sql)
        ) {

            statement.setInt(1, stock);
            statement.setInt(2, productId);

            return statement.executeUpdate() > 0;

        } catch (Exception e) {

            System.out.println(
                    "Error updating stock: "
                    + e.getMessage()
            );

            return false;
        }
    }

    public boolean restock(
            int productId,
            int quantity
    ) {

        String sql = """
                UPDATE products
                SET stock = stock + ?
                WHERE product_id = ?
                """;

        try (
                Connection connection = getConnection();
                PreparedStatement statement =
                        connection.prepareStatement(sql)
        ) {

            statement.setInt(1, quantity);
            statement.setInt(2, productId);

            return statement.executeUpdate() > 0;

        } catch (Exception e) {

            System.out.println(
                    "Error restocking product: "
                    + e.getMessage()
            );

            return false;
        }
    }
}