package com.shopsphere.dao;

import com.shopsphere.model.Category;
import com.shopsphere.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class CategoryDAO {

    // =========================================================
    // GET ALL CATEGORIES
    // =========================================================

    public List<Category> getAllCategories() {

        List<Category> categories = new ArrayList<>();

        String sql =
                "SELECT category_id, name, description, status " +
                "FROM categories " +
                "ORDER BY category_id DESC";

        try (
                Connection connection = DBConnection.getConnection();
                PreparedStatement ps = connection.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()
        ) {

            while (rs.next()) {

                Category category = new Category();

                category.setCategoryId(
                        rs.getInt("category_id")
                );

                category.setName(
                        rs.getString("name")
                );

                category.setDescription(
                        rs.getString("description")
                );

                category.setStatus(
                        rs.getBoolean("status")
                );

                categories.add(category);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return categories;
    }

    // =========================================================
    // GET CATEGORY BY ID
    // =========================================================

    public Category getCategoryById(int categoryId) {

        String sql =
                "SELECT category_id, name, description, status " +
                "FROM categories " +
                "WHERE category_id = ?";

        try (
                Connection connection = DBConnection.getConnection();
                PreparedStatement ps = connection.prepareStatement(sql)
        ) {

            ps.setInt(1, categoryId);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {

                    Category category = new Category();

                    category.setCategoryId(
                            rs.getInt("category_id")
                    );

                    category.setName(
                            rs.getString("name")
                    );

                    category.setDescription(
                            rs.getString("description")
                    );

                    category.setStatus(
                            rs.getBoolean("status")
                    );

                    return category;
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    // =========================================================
    // INSERT CATEGORY
    // =========================================================

    public boolean insertCategory(Category category) {

        String sql =
                "INSERT INTO categories " +
                "(name, description, status) " +
                "VALUES (?, ?, ?)";

        try (
                Connection connection = DBConnection.getConnection();
                PreparedStatement ps = connection.prepareStatement(sql)
        ) {

            ps.setString(
                    1,
                    category.getName()
            );

            ps.setString(
                    2,
                    category.getDescription()
            );

            ps.setBoolean(
                    3,
                    category.isStatus()
            );

            return ps.executeUpdate() > 0;

        } catch (Exception e) {

            e.printStackTrace();
            return false;
        }
    }

    // =========================================================
    // UPDATE CATEGORY
    // =========================================================

    public boolean updateCategory(Category category) {

        String sql =
                "UPDATE categories SET " +
                "name = ?, " +
                "description = ?, " +
                "status = ? " +
                "WHERE category_id = ?";

        try (
                Connection connection = DBConnection.getConnection();
                PreparedStatement ps = connection.prepareStatement(sql)
        ) {

            ps.setString(
                    1,
                    category.getName()
            );

            ps.setString(
                    2,
                    category.getDescription()
            );

            ps.setBoolean(
                    3,
                    category.isStatus()
            );

            ps.setInt(
                    4,
                    category.getCategoryId()
            );

            return ps.executeUpdate() > 0;

        } catch (Exception e) {

            e.printStackTrace();
            return false;
        }
    }

    // =========================================================
    // DEACTIVATE CATEGORY
    // =========================================================

    public boolean deactivateCategory(int categoryId) {

        String sql =
                "UPDATE categories " +
                "SET status = FALSE " +
                "WHERE category_id = ?";

        try (
                Connection connection = DBConnection.getConnection();
                PreparedStatement ps = connection.prepareStatement(sql)
        ) {

            ps.setInt(1, categoryId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {

            e.printStackTrace();
            return false;
        }
    }

    // =========================================================
    // ACTIVATE CATEGORY
    // =========================================================

    public boolean activateCategory(int categoryId) {

        String sql =
                "UPDATE categories " +
                "SET status = TRUE " +
                "WHERE category_id = ?";

        try (
                Connection connection = DBConnection.getConnection();
                PreparedStatement ps = connection.prepareStatement(sql)
        ) {

            ps.setInt(1, categoryId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {

            e.printStackTrace();
            return false;
        }
    }

    // =========================================================
    // GET ACTIVE CATEGORIES
    // =========================================================

    public List<Category> getActiveCategories() {

        List<Category> categories = new ArrayList<>();

        String sql =
                "SELECT category_id, name, description, status " +
                "FROM categories " +
                "WHERE status = TRUE " +
                "ORDER BY name";

        try (
                Connection connection = DBConnection.getConnection();
                PreparedStatement ps = connection.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()
        ) {

            while (rs.next()) {

                Category category = new Category();

                category.setCategoryId(
                        rs.getInt("category_id")
                );

                category.setName(
                        rs.getString("name")
                );

                category.setDescription(
                        rs.getString("description")
                );

                category.setStatus(
                        rs.getBoolean("status")
                );

                categories.add(category);
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return categories;
    }

    // =========================================================
    // FIND EXISTING CATEGORY OR CREATE NEW
    // =========================================================

    public int findOrCreateCategory(
            String name,
            String description) {

        if (name == null || name.trim().isEmpty()) {
            return -1;
        }

        String cleanName = name.trim();

        String cleanDescription =
                description == null
                        ? ""
                        : description.trim();

        // -----------------------------------------------------
        // CHECK EXISTING CATEGORY
        // -----------------------------------------------------

        String findSql =
                "SELECT category_id " +
                "FROM categories " +
                "WHERE LOWER(name) = LOWER(?) " +
                "LIMIT 1";

        try (
                Connection connection = DBConnection.getConnection();
                PreparedStatement findPs =
                        connection.prepareStatement(findSql)
        ) {

            findPs.setString(1, cleanName);

            try (ResultSet rs = findPs.executeQuery()) {

                if (rs.next()) {

                    return rs.getInt("category_id");
                }
            }

            // -------------------------------------------------
            // CREATE NEW CATEGORY
            // -------------------------------------------------

            String insertSql =
                    "INSERT INTO categories " +
                    "(name, description, status) " +
                    "VALUES (?, ?, TRUE)";

            try (
                    PreparedStatement insertPs =
                            connection.prepareStatement(
                                    insertSql,
                                    Statement.RETURN_GENERATED_KEYS
                            )
            ) {

                insertPs.setString(1, cleanName);
                insertPs.setString(2, cleanDescription);

                int affectedRows =
                        insertPs.executeUpdate();

                if (affectedRows == 0) {
                    return -1;
                }

                try (
                        ResultSet keys =
                                insertPs.getGeneratedKeys()
                ) {

                    if (keys.next()) {
                        return keys.getInt(1);
                    }
                }
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return -1;
    }
}