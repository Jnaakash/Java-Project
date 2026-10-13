package com.shopsphere.swing.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class CategoryDAO {

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

    // Get all categories
    public List<Object[]> getAllCategories() {

        List<Object[]> categories = new ArrayList<>();

        String sql = """
                SELECT category_id, name, status
                FROM categories
                ORDER BY category_id
                """;

        try (
                Connection connection = getConnection();
                PreparedStatement statement =
                        connection.prepareStatement(sql);
                ResultSet resultSet =
                        statement.executeQuery()
        ) {

            while (resultSet.next()) {

                Object[] category = {
                        resultSet.getInt("category_id"),
                        resultSet.getString("name"),
                        resultSet.getBoolean("status")
                                ? "ACTIVE"
                                : "INACTIVE"
                };

                categories.add(category);
            }

        } catch (Exception e) {

            System.out.println(
                    "Error loading categories: "
                            + e.getMessage()
            );
        }

        return categories;
    }

    // Add category
    public boolean addCategory(
            String name,
            boolean status
    ) {

        String sql = """
                INSERT INTO categories
                (name, status)
                VALUES (?, ?)
                """;

        try (
                Connection connection = getConnection();
                PreparedStatement statement =
                        connection.prepareStatement(sql)
        ) {

            statement.setString(1, name);
            statement.setBoolean(2, status);

            return statement.executeUpdate() > 0;

        } catch (Exception e) {

            System.out.println(
                    "Error adding category: "
                            + e.getMessage()
            );

            return false;
        }
    }

    // Update category
    public boolean updateCategory(
            int categoryId,
            String name,
            boolean status
    ) {

        String sql = """
                UPDATE categories
                SET name = ?,
                    status = ?
                WHERE category_id = ?
                """;

        try (
                Connection connection = getConnection();
                PreparedStatement statement =
                        connection.prepareStatement(sql)
        ) {

            statement.setString(1, name);
            statement.setBoolean(2, status);
            statement.setInt(3, categoryId);

            return statement.executeUpdate() > 0;

        } catch (Exception e) {

            System.out.println(
                    "Error updating category: "
                            + e.getMessage()
            );

            return false;
        }
    }

    // Deactivate category
    public boolean deactivateCategory(int categoryId) {

        String sql = """
                UPDATE categories
                SET status = FALSE
                WHERE category_id = ?
                """;

        try (
                Connection connection = getConnection();
                PreparedStatement statement =
                        connection.prepareStatement(sql)
        ) {

            statement.setInt(1, categoryId);

            return statement.executeUpdate() > 0;

        } catch (Exception e) {

            System.out.println(
                    "Error deactivating category: "
                            + e.getMessage()
            );

            return false;
        }
    }

    // Activate category
    public boolean activateCategory(int categoryId) {

        String sql = """
                UPDATE categories
                SET status = TRUE
                WHERE category_id = ?
                """;

        try (
                Connection connection = getConnection();
                PreparedStatement statement =
                        connection.prepareStatement(sql)
        ) {

            statement.setInt(1, categoryId);

            return statement.executeUpdate() > 0;

        } catch (Exception e) {

            System.out.println(
                    "Error activating category: "
                            + e.getMessage()
            );

            return false;
        }
    }
}