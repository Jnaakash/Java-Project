package com.shopsphere.network;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.ServerSocket;
import java.net.Socket;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class InventoryServer {

    private static final int PORT = 5000;

    public static void main(String[] args) {

        System.out.println("=================================");
        System.out.println("   ShopSphere Inventory Server");
        System.out.println("=================================");

        System.out.println("Starting server...");

        try (ServerSocket serverSocket =
                     new ServerSocket(PORT)) {

            System.out.println("Server started successfully.");
            System.out.println("Listening on port: " + PORT);
            System.out.println("Waiting for client connection...");

            while (true) {

                Socket clientSocket =
                        serverSocket.accept();

                System.out.println();
                System.out.println(
                        "Client connected: "
                                + clientSocket.getInetAddress()
                );

                handleClient(clientSocket);
            }

        } catch (IOException e) {

            System.out.println(
                    "Server error: "
                            + e.getMessage()
            );

            e.printStackTrace();
        }
    }

    private static void handleClient(
            Socket clientSocket) {

        try (
                Socket socket = clientSocket;

                BufferedReader reader =
                        new BufferedReader(
                                new InputStreamReader(
                                        socket.getInputStream()
                                )
                        );

                PrintWriter writer =
                        new PrintWriter(
                                socket.getOutputStream(),
                                true
                        )
        ) {

            writer.println(
                    "CONNECTED: ShopSphere Inventory Server"
            );

            String command;

            while ((command = reader.readLine()) != null) {

                command = command.trim();

                System.out.println(
                        "Received command: "
                                + command
                );

                if (command.equalsIgnoreCase("EXIT")) {

                    writer.println("DISCONNECTED");
                    break;

                } else if (command.toUpperCase()
                        .startsWith("GET_PRODUCT ")) {

                    String productIdText =
                            command.substring(
                                    "GET_PRODUCT ".length()
                            ).trim();

                    getProduct(productIdText, writer);

                } else if (command.toUpperCase()
                        .startsWith("GET_STOCK ")) {

                    String productIdText =
                            command.substring(
                                    "GET_STOCK ".length()
                            ).trim();

                    getStock(productIdText, writer);

                } else if (command.toUpperCase()
                        .startsWith("SEARCH_PRODUCT ")) {

                    String keyword =
                            command.substring(
                                    "SEARCH_PRODUCT ".length()
                            ).trim();

                    searchProduct(keyword, writer);

                } else {

                    writer.println(
                            "ERROR: Unknown command."
                    );

                    writer.println(
                            "Use: GET_PRODUCT <id>"
                    );

                    writer.println(
                            "Use: GET_STOCK <id>"
                    );

                    writer.println(
                            "Use: SEARCH_PRODUCT <keyword>"
                    );
                }
            }

            System.out.println("Client disconnected.");

        } catch (IOException e) {

            System.out.println(
                    "Client communication error: "
                            + e.getMessage()
            );
        }
    }

    private static void getProduct(
            String productIdText,
            PrintWriter writer) {

        try {

            int productId =
                    Integer.parseInt(productIdText);

            String sql =
                    "SELECT product_id, name, brand, "
                    + "price, stock, status "
                    + "FROM products "
                    + "WHERE product_id = ?";

            try (
                    Connection connection =
                            NetworkDBConnection.getConnection();

                    PreparedStatement ps =
                            connection.prepareStatement(sql)
            ) {

                ps.setInt(1, productId);

                try (ResultSet rs = ps.executeQuery()) {
if (rs.next()) {

    writer.println(
            "PRODUCT_ID: "
                    + rs.getInt("product_id")
    );

    writer.println(
            "NAME: "
                    + rs.getString("name")
    );

    writer.println(
            "BRAND: "
                    + rs.getString("brand")
    );

    writer.println(
            "PRICE: "
                    + rs.getDouble("price")
    );

    writer.println(
            "STOCK: "
                    + rs.getInt("stock")
    );

    writer.println(
            "STATUS: "
                    + rs.getBoolean("status")
    );

    writer.println("END");

} else {

    writer.println(
            "ERROR: Product not found."
    );

    writer.println("END");
}
                }
            }

        } catch (NumberFormatException e) {

            writer.println(
                    "ERROR: Product ID must be a number."
            );

        } catch (Exception e) {

            writer.println(
                    "ERROR: Unable to retrieve product."
            );

            System.out.println(
                    "Database error: "
                            + e.getMessage()
            );
        }
    }

    private static void getStock(
            String productIdText,
            PrintWriter writer) {

        try {

            int productId =
                    Integer.parseInt(productIdText);

            String sql =
                    "SELECT product_id, name, stock, status "
                    + "FROM products "
                    + "WHERE product_id = ?";

            try (
                    Connection connection =
                            NetworkDBConnection.getConnection();

                    PreparedStatement ps =
                            connection.prepareStatement(sql)
            ) {

                ps.setInt(1, productId);

                try (ResultSet rs = ps.executeQuery()) {

                    if (rs.next()) {

    writer.println(
            "PRODUCT_ID: "
                    + rs.getInt("product_id")
    );

    writer.println(
            "NAME: "
                    + rs.getString("name")
    );

    writer.println(
            "STOCK: "
                    + rs.getInt("stock")
    );

    writer.println(
            "STATUS: "
                    + rs.getBoolean("status")
    );

    writer.println("END");

} else {

    writer.println(
            "ERROR: Product not found."
    );

    writer.println("END");
}
                }
            }

        } catch (NumberFormatException e) {

            writer.println(
                    "ERROR: Product ID must be a number."
            );

        } catch (Exception e) {

            writer.println(
                    "ERROR: Unable to retrieve stock."
            );

            System.out.println(
                    "Database error: "
                            + e.getMessage()
            );
        }
    }

    private static void searchProduct(
            String keyword,
            PrintWriter writer) {

        if (keyword.isEmpty()) {

            writer.println(
                    "ERROR: Search keyword cannot be empty."
            );

            return;
        }

        String sql =
                "SELECT product_id, name, brand, "
                + "price, stock "
                + "FROM products "
                + "WHERE status = TRUE "
                + "AND (LOWER(name) LIKE ? "
                + "OR LOWER(brand) LIKE ?) "
                + "ORDER BY name";

        try (
                Connection connection =
                        NetworkDBConnection.getConnection();

                PreparedStatement ps =
                        connection.prepareStatement(sql)
        ) {

            String searchPattern =
                    "%" + keyword.toLowerCase() + "%";

            ps.setString(1, searchPattern);
            ps.setString(2, searchPattern);

            try (ResultSet rs = ps.executeQuery()) {

                boolean found = false;

                while (rs.next()) {

                    found = true;

                    writer.println(
                            "PRODUCT_ID: "
                                    + rs.getInt("product_id")
                            + " | NAME: "
                                    + rs.getString("name")
                            + " | BRAND: "
                                    + rs.getString("brand")
                            + " | PRICE: "
                                    + rs.getDouble("price")
                            + " | STOCK: "
                                    + rs.getInt("stock")
                    );
                }

                if (!found) {

                    writer.println(
                            "No active products found."
                    );
                }

                writer.println("END");

            }

        } catch (Exception e) {

            writer.println(
                    "ERROR: Unable to search products."
            );

            writer.println("END");

            System.out.println(
                    "Database error: "
                            + e.getMessage()
            );
        }
    }
}