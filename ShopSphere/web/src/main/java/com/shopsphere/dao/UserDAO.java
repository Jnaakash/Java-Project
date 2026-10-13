package com.shopsphere.dao;

import com.shopsphere.model.User;
import com.shopsphere.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {

    // =====================================================
    // REGISTER CUSTOMER
    // =====================================================

    public boolean registerUser(User user) {

        String checkSql =
                "SELECT user_id FROM users WHERE email = ?";

        String insertSql =
                "INSERT INTO users " +
                "(name, email, password, mobile, role, status) " +
                "VALUES (?, ?, ?, ?, 'CUSTOMER', TRUE)";

        try (
                Connection connection =
                        DBConnection.getConnection();

                PreparedStatement checkStatement =
                        connection.prepareStatement(checkSql)
        ) {

            checkStatement.setString(
                    1,
                    user.getEmail()
            );

            try (ResultSet rs =
                         checkStatement.executeQuery()) {

                if (rs.next()) {
                    return false;
                }
            }

            try (
                    PreparedStatement insertStatement =
                            connection.prepareStatement(insertSql)
            ) {

                insertStatement.setString(
                        1,
                        user.getName()
                );

                insertStatement.setString(
                        2,
                        user.getEmail()
                );

                insertStatement.setString(
                        3,
                        user.getPassword()
                );

                insertStatement.setString(
                        4,
                        user.getMobile()
                );

                return insertStatement.executeUpdate() > 0;
            }

        } catch (Exception e) {

            e.printStackTrace();

            return false;
        }
    }


    // =====================================================
    // LOGIN USER
    // =====================================================

    public User loginUser(
            String email,
            String password) {

        String sql =
                "SELECT user_id, name, email, password, " +
                "mobile, role, status " +
                "FROM users " +
                "WHERE email = ? AND password = ? " +
                "AND status = TRUE";

        try (
                Connection connection =
                        DBConnection.getConnection();

                PreparedStatement statement =
                        connection.prepareStatement(sql)
        ) {

            statement.setString(1, email);
            statement.setString(2, password);

            try (ResultSet rs =
                         statement.executeQuery()) {

                if (!rs.next()) {
                    return null;
                }

                return mapUser(rs);
            }

        } catch (Exception e) {

            e.printStackTrace();

            return null;
        }
    }


    // =====================================================
    // GET ALL CUSTOMERS
    // =====================================================

    public List<User> getAllCustomers() {

        List<User> customers =
                new ArrayList<>();

        String sql =
                "SELECT user_id, name, email, password, " +
                "mobile, role, status " +
                "FROM users " +
                "WHERE role = 'CUSTOMER' " +
                "ORDER BY user_id DESC";

        try (
                Connection connection =
                        DBConnection.getConnection();

                PreparedStatement statement =
                        connection.prepareStatement(sql);

                ResultSet rs =
                        statement.executeQuery()
        ) {

            while (rs.next()) {

                customers.add(
                        mapUser(rs)
                );
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return customers;
    }


    // =====================================================
    // UPDATE CUSTOMER STATUS
    // =====================================================

    public boolean updateCustomerStatus(
            int userId,
            boolean status) {

        String sql =
                "UPDATE users " +
                "SET status = ? " +
                "WHERE user_id = ? " +
                "AND role = 'CUSTOMER'";

        try (
                Connection connection =
                        DBConnection.getConnection();

                PreparedStatement statement =
                        connection.prepareStatement(sql)
        ) {

            statement.setBoolean(1, status);
            statement.setInt(2, userId);

            return statement.executeUpdate() > 0;

        } catch (Exception e) {

            e.printStackTrace();

            return false;
        }
    }


    // =====================================================
    // ACTIVE CUSTOMER COUNT
    // =====================================================

    public int getActiveCustomerCount() {

        return getCustomerCount(true);
    }


    // =====================================================
    // INACTIVE CUSTOMER COUNT
    // =====================================================

    public int getInactiveCustomerCount() {

        return getCustomerCount(false);
    }


    // =====================================================
    // CUSTOMER COUNT
    // =====================================================

    private int getCustomerCount(
            boolean status) {

        String sql =
                "SELECT COUNT(*) " +
                "FROM users " +
                "WHERE role = 'CUSTOMER' " +
                "AND status = ?";

        try (
                Connection connection =
                        DBConnection.getConnection();

                PreparedStatement statement =
                        connection.prepareStatement(sql)
        ) {

            statement.setBoolean(1, status);

            try (ResultSet rs =
                         statement.executeQuery()) {

                if (rs.next()) {
                    return rs.getInt(1);
                }
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return 0;
    }


    // =====================================================
    // MAP USER
    // =====================================================

    private User mapUser(ResultSet rs)
            throws Exception {

        User user = new User();

        user.setUserId(
                rs.getInt("user_id")
        );

        user.setName(
                rs.getString("name")
        );

        user.setEmail(
                rs.getString("email")
        );

        user.setPassword(
                rs.getString("password")
        );

        user.setMobile(
                rs.getString("mobile")
        );

        user.setRole(
                rs.getString("role")
        );

        user.setStatus(
                rs.getBoolean("status")
        );

        return user;
    }
}