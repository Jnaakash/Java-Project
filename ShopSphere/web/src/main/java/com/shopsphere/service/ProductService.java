package com.shopsphere.service;

import com.shopsphere.dao.ProductDAO;
import com.shopsphere.model.Product;

import java.util.List;

public class ProductService {

    private ProductDAO productDAO;

    public ProductService() {
        productDAO = new ProductDAO();
    }

    // Get all products
    public List<Product> getAllProducts() {
        return productDAO.getAllProducts();
    }

    // Get product by ID
    public Product getProductById(int productId) {
        return productDAO.getProductById(productId);
    }

    // Search products
    public List<Product> searchProducts(String keyword) {
        return productDAO.searchProducts(keyword);
    }
}