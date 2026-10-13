package com.shopsphere.rmi;

import java.rmi.RemoteException;
import java.rmi.server.UnicastRemoteObject;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.shopsphere.network.NetworkDBConnection;

public class InventoryServiceImpl
        extends UnicastRemoteObject
        implements InventoryService {

    public InventoryServiceImpl()
            throws RemoteException {

        super();
    }

    @Override
    public String getProduct(int productId)
            throws RemoteException {

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

                    return
                            "PRODUCT_ID: "
                            + rs.getInt("product_id")
                            + "\nNAME: "
                            + rs.getString("name")
                            + "\nBRAND: "
                            + rs.getString("brand")
                            + "\nPRICE: "
                            + rs.getDouble("price")
                            + "\nSTOCK: "
                            + rs.getInt("stock")
                            + "\nSTATUS: "
                            + rs.getBoolean("status");
                }

                return "ERROR: Product not found.";
            }

        } catch (Exception e) {

            throw new RemoteException(
                    "Unable to retrieve product.",
                    e
            );
        }
    }

    @Override
    public String getStock(int productId)
            throws RemoteException {

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

                    return
                            "PRODUCT_ID: "
                            + rs.getInt("product_id")
                            + "\nNAME: "
                            + rs.getString("name")
                            + "\nSTOCK: "
                            + rs.getInt("stock")
                            + "\nSTATUS: "
                            + rs.getBoolean("status");
                }

                return "ERROR: Product not found.";
            }

        } catch (Exception e) {

            throw new RemoteException(
                    "Unable to retrieve stock.",
                    e
            );
        }
    }

    @Override
    public String searchProduct(String keyword)
            throws RemoteException {

        if (keyword == null ||
                keyword.trim().isEmpty()) {

            return "ERROR: Search keyword cannot be empty.";
        }

        String sql =
                "SELECT product_id, name, brand, "
                + "price, stock "
                + "FROM products "
                + "WHERE status = TRUE "
                + "AND (LOWER(name) LIKE ? "
                + "OR LOWER(brand) LIKE ?) "
                + "ORDER BY name";

        StringBuilder result =
                new StringBuilder();

        try (
                Connection connection =
                        NetworkDBConnection.getConnection();

                PreparedStatement ps =
                        connection.prepareStatement(sql)
        ) {

            String searchPattern =
                    "%"
                    + keyword.trim().toLowerCase()
                    + "%";

            ps.setString(1, searchPattern);
            ps.setString(2, searchPattern);

            try (ResultSet rs = ps.executeQuery()) {

                boolean found = false;

                while (rs.next()) {

                    found = true;

                    result.append(
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
                            + "\n"
                    );
                }

                if (!found) {

                    return "No active products found.";
                }

                return result.toString();
            }

        } catch (Exception e) {

            throw new RemoteException(
                    "Unable to search products.",
                    e
            );
        }
    }
}