package com.shopsphere.swing.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class CustomerDAO {

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

    // ==============================
    // GET ALL CUSTOMERS
    // ==============================

    public List<Object[]> getAllCustomers() {

        List<Object[]> customers = new ArrayList<>();

        String sql = """
                SELECT user_id, name, email, phone, status
                FROM users
                WHERE role = 'CUSTOMER'
                ORDER BY user_id
                """;

        try (
                Connection connection = getConnection();
                PreparedStatement statement =
                        connection.prepareStatement(sql);
                ResultSet resultSet =
                        statement.executeQuery()
        ) {

            while (resultSet.next()) {

                Object[] customer = {

                        resultSet.getInt("user_id"),

                        resultSet.getString("name"),

                        resultSet.getString("email"),

                        resultSet.getString("phone"),

                        resultSet.getBoolean("status")
                                ? "ACTIVE"
                                : "INACTIVE"
                };

                customers.add(customer);
            }

        } catch (Exception e) {

            System.out.println(
                    "Error loading customers: "
                            + e.getMessage()
            );
        }

        return customers;
    }


    // ==============================
    // UPDATE CUSTOMER
    // ==============================

    public boolean updateCustomer(
            int userId,
            String name,
            String email,
            String phone
    ) {

        String sql = """
                UPDATE users
                SET name = ?,
                    email = ?,
                    phone = ?
                WHERE user_id = ?
                  AND role = 'CUSTOMER'
                """;

        try (
                Connection connection = getConnection();
                PreparedStatement statement =
                        connection.prepareStatement(sql)
        ) {

            statement.setString(1, name);
            statement.setString(2, email);
            statement.setString(3, phone);
            statement.setInt(4, userId);

            return statement.executeUpdate() > 0;

        } catch (Exception e) {

            System.out.println(
                    "Error updating customer: "
                            + e.getMessage()
            );

            return false;
        }
    }


    // ==============================
    // DEACTIVATE CUSTOMER
    // ==============================

    public boolean deactivateCustomer(int userId) {

        String sql = """
                UPDATE users
                SET status = FALSE
                WHERE user_id = ?
                  AND role = 'CUSTOMER'
                """;

        try (
                Connection connection = getConnection();
                PreparedStatement statement =
                        connection.prepareStatement(sql)
        ) {

            statement.setInt(1, userId);

            return statement.executeUpdate() > 0;

        } catch (Exception e) {

            System.out.println(
                    "Error deactivating customer: "
                            + e.getMessage()
            );

            return false;
        }
    }


    // ==============================
    // ACTIVATE CUSTOMER
    // ==============================

    public boolean activateCustomer(int userId) {

        String sql = """
                UPDATE users
                SET status = TRUE
                WHERE user_id = ?
                  AND role = 'CUSTOMER'
                """;

        try (
                Connection connection = getConnection();
                PreparedStatement statement =
                        connection.prepareStatement(sql)
        ) {

            statement.setInt(1, userId);

            return statement.executeUpdate() > 0;

        } catch (Exception e) {

            System.out.println(
                    "Error activating customer: "
                            + e.getMessage()
            );

            return false;
        }
    }
}