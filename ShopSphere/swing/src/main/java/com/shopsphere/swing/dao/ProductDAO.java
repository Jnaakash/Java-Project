package com.shopsphere.swing.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {

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

    // Get all products
    public List<Object[]> getAllProducts() {

        List<Object[]> products = new ArrayList<>();

        String sql = """
                SELECT product_id, name, brand, price, stock
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

                Object[] product = {
                        resultSet.getInt("product_id"),
                        resultSet.getString("name"),
                        resultSet.getString("brand"),
                        resultSet.getDouble("price"),
                        resultSet.getInt("stock")
                };

                products.add(product);
            }

        } catch (Exception e) {

            System.out.println(
                    "Error loading products: "
                            + e.getMessage()
            );
        }

        return products;
    }

    // Add product
    public boolean addProduct(
            String name,
            String brand,
            double price,
            int stock
    ) {

        String sql = """
                INSERT INTO products
                (name, brand, price, stock, status)
                VALUES (?, ?, ?, ?, TRUE)
                """;

        try (
                Connection connection = getConnection();
                PreparedStatement statement =
                        connection.prepareStatement(sql)
        ) {

            statement.setString(1, name);
            statement.setString(2, brand);
            statement.setDouble(3, price);
            statement.setInt(4, stock);

            return statement.executeUpdate() > 0;

        } catch (Exception e) {

            System.out.println(
                    "Error adding product: "
                            + e.getMessage()
            );

            return false;
        }
    }

    // Update product
    public boolean updateProduct(
            int productId,
            String name,
            String brand,
            double price,
            int stock
    ) {

        String sql = """
                UPDATE products
                SET name = ?,
                    brand = ?,
                    price = ?,
                    stock = ?
                WHERE product_id = ?
                """;

        try (
                Connection connection = getConnection();
                PreparedStatement statement =
                        connection.prepareStatement(sql)
        ) {

            statement.setString(1, name);
            statement.setString(2, brand);
            statement.setDouble(3, price);
            statement.setInt(4, stock);
            statement.setInt(5, productId);

            return statement.executeUpdate() > 0;

        } catch (Exception e) {

            System.out.println(
                    "Error updating product: "
                            + e.getMessage()
            );

            return false;
        }
    }

    // Deactivate product
    public boolean deactivateProduct(int productId) {

        String sql = """
                UPDATE products
                SET status = FALSE
                WHERE product_id = ?
                """;

        try (
                Connection connection = getConnection();
                PreparedStatement statement =
                        connection.prepareStatement(sql)
        ) {

            statement.setInt(1, productId);

            return statement.executeUpdate() > 0;

        } catch (Exception e) {

            System.out.println(
                    "Error deactivating product: "
                            + e.getMessage()
            );

            return false;
        }
    }
}