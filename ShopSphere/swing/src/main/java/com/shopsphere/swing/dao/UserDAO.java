package com.shopsphere.swing.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {

    private Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");

        return java.sql.DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/shopsphere",
            "root",
            "@k@sh0706"
        );
    }

    public boolean validateAdmin(String username, String password) {

        String sql = """
            SELECT user_id, email, role, status, password
            FROM users
            WHERE email = ?
        """;

        try (
            Connection connection = getConnection();
            PreparedStatement statement = connection.prepareStatement(sql)
        ) {

            statement.setString(1, username);

            try (ResultSet rs = statement.executeQuery()) {

                if (!rs.next()) {
                    System.out.println("DEBUG: Email not found = " + username);
                    return false;
                }

                String dbPassword = rs.getString("password");
                String dbRole = rs.getString("role");
                boolean dbStatus = rs.getBoolean("status");

                System.out.println("DEBUG: Email found");
                System.out.println("DEBUG: Role = " + dbRole);
                System.out.println("DEBUG: Status = " + dbStatus);
                System.out.println("DEBUG: Password length in DB = "
                        + (dbPassword == null ? 0 : dbPassword.length()));
                System.out.println("DEBUG: Entered password length = "
                        + (password == null ? 0 : password.length()));

                boolean passwordMatch = password.equals(dbPassword);
                boolean adminMatch = "ADMIN".equalsIgnoreCase(dbRole);

                System.out.println("DEBUG: Password match = " + passwordMatch);
                System.out.println("DEBUG: Admin match = " + adminMatch);

                return passwordMatch && adminMatch && dbStatus;
            }

        } catch (Exception e) {
            System.out.println("DEBUG: DATABASE ERROR");
            e.printStackTrace();
            return false;
        }
    }
}