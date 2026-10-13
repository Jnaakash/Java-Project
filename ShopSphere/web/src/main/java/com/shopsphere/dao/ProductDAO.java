package com.shopsphere.dao;

import com.shopsphere.model.Product;
import com.shopsphere.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {

    // ==============================
    // GET ALL PRODUCTS
    // ==============================
    public List<Product> getAllProducts() {

        List<Product> products = new ArrayList<>();

        String sql = "SELECT * FROM products WHERE status = TRUE";

        try (
            Connection connection = DBConnection.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery()
        ) {

            while (rs.next()) {

                Product product = new Product();

                product.setProductId(rs.getInt("product_id"));
                product.setCategoryId(rs.getInt("category_id"));
                product.setName(rs.getString("name"));
                product.setBrand(rs.getString("brand"));
                product.setDescription(rs.getString("description"));
                product.setPrice(rs.getDouble("price"));
                product.setDiscount(rs.getDouble("discount"));
                product.setStock(rs.getInt("stock"));
                product.setImageUrl(rs.getString("image_url"));
                product.setStatus(rs.getBoolean("status"));

                products.add(product);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return products;
    }


    // ==============================
    // GET PRODUCT BY ID
    // ==============================
    public Product getProductById(int productId) {

        String sql =
                "SELECT * FROM products " +
                "WHERE product_id = ? AND status = TRUE";

        try (
            Connection connection = DBConnection.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql)
        ) {

            ps.setInt(1, productId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                Product product = new Product();

                product.setProductId(rs.getInt("product_id"));
                product.setCategoryId(rs.getInt("category_id"));
                product.setName(rs.getString("name"));
                product.setBrand(rs.getString("brand"));
                product.setDescription(rs.getString("description"));
                product.setPrice(rs.getDouble("price"));
                product.setDiscount(rs.getDouble("discount"));
                product.setStock(rs.getInt("stock"));
                product.setImageUrl(rs.getString("image_url"));
                product.setStatus(rs.getBoolean("status"));

                return product;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }


    // ==============================
    // INSERT PRODUCT
    // ==============================
    public boolean insertProduct(Product product) {

        String sql =
                "INSERT INTO products " +
                "(category_id, name, brand, description, price, " +
                "discount, stock, image_url, status) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (
            Connection connection = DBConnection.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql)
        ) {

            ps.setInt(1, product.getCategoryId());
            ps.setString(2, product.getName());
            ps.setString(3, product.getBrand());
            ps.setString(4, product.getDescription());
            ps.setDouble(5, product.getPrice());
            ps.setDouble(6, product.getDiscount());
            ps.setInt(7, product.getStock());
            ps.setString(8, product.getImageUrl());
            ps.setBoolean(9, product.isStatus());

            int rows = ps.executeUpdate();

            return rows > 0;

        } catch (Exception e) {

            e.printStackTrace();
        }

        return false;
    }


    // ==============================
    // UPDATE PRODUCT
    // ==============================
    public boolean updateProduct(Product product) {

        String sql =
                "UPDATE products SET " +
                "category_id = ?, " +
                "name = ?, " +
                "brand = ?, " +
                "description = ?, " +
                "price = ?, " +
                "discount = ?, " +
                "stock = ?, " +
                "image_url = ?, " +
                "status = ? " +
                "WHERE product_id = ?";

        try (
            Connection connection = DBConnection.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql)
        ) {

            ps.setInt(1, product.getCategoryId());
            ps.setString(2, product.getName());
            ps.setString(3, product.getBrand());
            ps.setString(4, product.getDescription());
            ps.setDouble(5, product.getPrice());
            ps.setDouble(6, product.getDiscount());
            ps.setInt(7, product.getStock());
            ps.setString(8, product.getImageUrl());
            ps.setBoolean(9, product.isStatus());
            ps.setInt(10, product.getProductId());

            int rows = ps.executeUpdate();

            return rows > 0;

        } catch (Exception e) {

            e.printStackTrace();
        }

        return false;
    }


    // ==============================
    // DEACTIVATE PRODUCT
    // ==============================
    public boolean deactivateProduct(int productId) {

        String sql =
                "UPDATE products " +
                "SET status = FALSE " +
                "WHERE product_id = ?";

        try (
            Connection connection = DBConnection.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql)
        ) {

            ps.setInt(1, productId);

            int rows = ps.executeUpdate();

            return rows > 0;

        } catch (Exception e) {

            e.printStackTrace();
        }

        return false;
    }


    // =====================================================
    // GET ACTIVE PRODUCT COUNT - ADMIN DASHBOARD
    // =====================================================
    public int getActiveProductCount() {

        String sql =
                "SELECT COUNT(*) " +
                "FROM products " +
                "WHERE status = TRUE";

        try (
            Connection connection = DBConnection.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery()
        ) {

            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return 0;
    }


    // =====================================================
    // GET ALL PRODUCTS - ADMIN
    // =====================================================
    public List<Product> getAllProductsForAdmin() {

        List<Product> products = new ArrayList<>();

        String sql =
                "SELECT * FROM products " +
                "ORDER BY product_id DESC";

        try (
            Connection connection = DBConnection.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery()
        ) {

            while (rs.next()) {

                Product product = mapProduct(rs);

                products.add(product);
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return products;
    }


    // =====================================================
    // ACTIVATE PRODUCT - ADMIN
    // =====================================================
    public boolean activateProduct(int productId) {

        String sql =
                "UPDATE products " +
                "SET status = TRUE " +
                "WHERE product_id = ?";

        try (
            Connection connection = DBConnection.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql)
        ) {

            ps.setInt(1, productId);

            int rows = ps.executeUpdate();

            return rows > 0;

        } catch (Exception e) {

            e.printStackTrace();
        }

        return false;
    }


    // =====================================================
    // SEARCH AND FILTER PRODUCTS - ADMIN
    // WITH PAGINATION
    // =====================================================
    public List<Product> searchProductsForAdmin(
            String keyword,
            String statusFilter,
            int page,
            int pageSize) {

        List<Product> products = new ArrayList<>();

        StringBuilder sql =
                new StringBuilder(
                        "SELECT * FROM products WHERE 1=1"
                );

        if (keyword != null
                && !keyword.trim().isEmpty()) {

            sql.append(
                    " AND (LOWER(name) LIKE ? " +
                    "OR LOWER(brand) LIKE ?)"
            );
        }

        if (statusFilter != null
                && !statusFilter.trim().isEmpty()
                && !statusFilter.equalsIgnoreCase("ALL")) {

            sql.append(" AND status = ?");
        }

        sql.append(
                " ORDER BY product_id DESC LIMIT ? OFFSET ?"
        );

        try (
            Connection connection =
                    DBConnection.getConnection();

            PreparedStatement ps =
                    connection.prepareStatement(
                            sql.toString()
                    )
        ) {

            int parameterIndex = 1;

            if (keyword != null
                    && !keyword.trim().isEmpty()) {

                String searchKeyword =
                        "%" + keyword.trim().toLowerCase() + "%";

                ps.setString(
                        parameterIndex++,
                        searchKeyword
                );

                ps.setString(
                        parameterIndex++,
                        searchKeyword
                );
            }

            if (statusFilter != null
                    && !statusFilter.trim().isEmpty()
                    && !statusFilter.equalsIgnoreCase("ALL")) {

                boolean status =
                        statusFilter.equalsIgnoreCase("ACTIVE");

                ps.setBoolean(
                        parameterIndex++,
                        status
                );
            }

            int offset =
                    (page - 1) * pageSize;

            ps.setInt(
                    parameterIndex++,
                    pageSize
            );

            ps.setInt(
                    parameterIndex,
                    offset
            );

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {

                    Product product = mapProduct(rs);

                    products.add(product);
                }
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return products;
    }


    // =====================================================
    // GET TOTAL PRODUCT COUNT - ADMIN PAGINATION
    // =====================================================
    public int getProductCountForAdmin(
            String keyword,
            String statusFilter) {

        int count = 0;

        StringBuilder sql =
                new StringBuilder(
                        "SELECT COUNT(*) " +
                        "FROM products " +
                        "WHERE 1=1"
                );

        if (keyword != null
                && !keyword.trim().isEmpty()) {

            sql.append(
                    " AND (LOWER(name) LIKE ? " +
                    "OR LOWER(brand) LIKE ?)"
            );
        }

        if (statusFilter != null
                && !statusFilter.trim().isEmpty()
                && !statusFilter.equalsIgnoreCase("ALL")) {

            sql.append(" AND status = ?");
        }

        try (
            Connection connection =
                    DBConnection.getConnection();

            PreparedStatement ps =
                    connection.prepareStatement(
                            sql.toString()
                    )
        ) {

            int parameterIndex = 1;

            if (keyword != null
                    && !keyword.trim().isEmpty()) {

                String searchKeyword =
                        "%" + keyword.trim().toLowerCase() + "%";

                ps.setString(
                        parameterIndex++,
                        searchKeyword
                );

                ps.setString(
                        parameterIndex++,
                        searchKeyword
                );
            }

            if (statusFilter != null
                    && !statusFilter.trim().isEmpty()
                    && !statusFilter.equalsIgnoreCase("ALL")) {

                boolean status =
                        statusFilter.equalsIgnoreCase("ACTIVE");

                ps.setBoolean(
                        parameterIndex,
                        status
                );
            }

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {
                    count = rs.getInt(1);
                }
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return count;
    }


    // =====================================================
    // MAP RESULTSET TO PRODUCT OBJECT
    // =====================================================
    private Product mapProduct(ResultSet rs)
            throws Exception {

        Product product = new Product();

        product.setProductId(
                rs.getInt("product_id")
        );

        product.setCategoryId(
                rs.getInt("category_id")
        );

        product.setName(
                rs.getString("name")
        );

        product.setBrand(
                rs.getString("brand")
        );

        product.setDescription(
                rs.getString("description")
        );

        product.setPrice(
                rs.getDouble("price")
        );

        product.setDiscount(
                rs.getDouble("discount")
        );

        product.setStock(
                rs.getInt("stock")
        );

        product.setImageUrl(
                rs.getString("image_url")
        );

        product.setStatus(
                rs.getBoolean("status")
        );

        return product;
    }

    // =====================================================
// SEARCH ACTIVE PRODUCTS - CUSTOMER
// =====================================================
public List<Product> searchProducts(String keyword) {

    List<Product> products = new ArrayList<>();

    String sql =
            "SELECT * FROM products " +
            "WHERE status = TRUE " +
            "AND (LOWER(name) LIKE ? " +
            "OR LOWER(brand) LIKE ? " +
            "OR LOWER(description) LIKE ?) " +
            "ORDER BY product_id DESC";

    try (
        Connection connection = DBConnection.getConnection();
        PreparedStatement ps = connection.prepareStatement(sql)
    ) {

        String searchKeyword =
                "%" + keyword.trim().toLowerCase() + "%";

        ps.setString(1, searchKeyword);
        ps.setString(2, searchKeyword);
        ps.setString(3, searchKeyword);

        try (ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {

                Product product = mapProduct(rs);

                products.add(product);
            }
        }

    } catch (Exception e) {
        e.printStackTrace();
    }

    return products;
}
}