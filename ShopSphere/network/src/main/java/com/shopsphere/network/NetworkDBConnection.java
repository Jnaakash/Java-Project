package com.shopsphere.network;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class NetworkDBConnection {

    private static final String URL =
            "jdbc:mysql://localhost:3306/shopsphere";

    private static final String USER = "root";

    /*
     * Use the same MySQL password that your working
     * ShopSphere web DBConnection.java uses.
     */
    private static final String PASSWORD =
            "@k@sh0706";

    public static Connection getConnection()
            throws SQLException {

        try {
            Class.forName(
                    "com.mysql.cj.jdbc.Driver"
            );

        } catch (ClassNotFoundException e) {

            throw new SQLException(
                    "MySQL JDBC Driver not found.",
                    e
            );
        }

        return DriverManager.getConnection(
                URL,
                USER,
                PASSWORD
        );
    }
}