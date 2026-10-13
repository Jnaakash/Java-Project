package com.shopsphere.swing.controller;

import com.shopsphere.swing.dao.CategoryDAO;

import java.util.List;

public class CategoryController {

    private final CategoryDAO categoryDAO;

    public CategoryController() {
        categoryDAO = new CategoryDAO();
    }

    // Load all categories
    public List<Object[]> getAllCategories() {
        return categoryDAO.getAllCategories();
    }

    // Add category
    public boolean addCategory(
            String name,
            boolean status) {

        if (name == null || name.trim().isEmpty()) {
            return false;
        }

        return categoryDAO.addCategory(
                name.trim(),
                status
        );
    }

    // Update category
    public boolean updateCategory(
            int categoryId,
            String name,
            boolean status) {

        if (categoryId <= 0) {
            return false;
        }

        if (name == null || name.trim().isEmpty()) {
            return false;
        }

        return categoryDAO.updateCategory(
                categoryId,
                name.trim(),
                status
        );
    }

    // Deactivate category
    public boolean deactivateCategory(int categoryId) {

        if (categoryId <= 0) {
            return false;
        }

        return categoryDAO.deactivateCategory(
                categoryId
        );
    }

    // Activate category
    public boolean activateCategory(int categoryId) {

        if (categoryId <= 0) {
            return false;
        }

        return categoryDAO.activateCategory(
                categoryId
        );
    }
}