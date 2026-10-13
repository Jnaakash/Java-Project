package com.shopsphere.network;

import java.sql.Connection;

public class NetworkDBTest {

    public static void main(String[] args) {

        System.out.println("=================================");
        System.out.println("   ShopSphere Network DB Test");
        System.out.println("=================================");

        System.out.println("Connecting to MySQL...");

        try (Connection connection =
                     NetworkDBConnection.getConnection()) {

            if (connection != null &&
                    !connection.isClosed()) {

                System.out.println();
                System.out.println(
                        "SUCCESS: Database connection established!"
                );

                System.out.println(
                        "Database: shopsphere"
                );

                System.out.println(
                        "Connection is active."
                );
            }

        } catch (Exception e) {

            System.out.println();
            System.out.println(
                    "ERROR: Database connection failed."
            );

            System.out.println(
                    "Message: " + e.getMessage()
            );

            e.printStackTrace();
        }
    }
}