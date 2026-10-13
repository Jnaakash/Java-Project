package com.shopsphere.controller;

import com.shopsphere.dao.CategoryDAO;
import com.shopsphere.dao.ProductDAO;
import com.shopsphere.model.Product;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/admin/edit-product")
public class EditProductServlet extends HttpServlet {

    private ProductDAO productDAO;
    private CategoryDAO categoryDAO;

    @Override
    public void init() {

        productDAO = new ProductDAO();
        categoryDAO = new CategoryDAO();
    }

    // ==========================================
    // SHOW EDIT PRODUCT PAGE
    // ==========================================
    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String idParameter =
                request.getParameter("id");

        if (idParameter == null ||
                idParameter.trim().isEmpty()) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Product ID is missing"
            );

            return;
        }

        try {

            int productId =
                    Integer.parseInt(idParameter);

            Product product =
                    productDAO.getProductById(productId);

            if (product == null) {

                response.sendError(
                        HttpServletResponse.SC_NOT_FOUND,
                        "Product not found"
                );

                return;
            }

            // ==========================================
            // LOAD ACTIVE CATEGORIES
            // ==========================================

            request.setAttribute(
                    "categories",
                    categoryDAO.getActiveCategories()
            );

            // ==========================================
            // SEND PRODUCT TO JSP
            // ==========================================

            request.setAttribute(
                    "product",
                    product
            );

            request.getRequestDispatcher(
                    "/admin/edit-product.jsp"
            ).forward(
                    request,
                    response
            );

        } catch (NumberFormatException e) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid Product ID"
            );
        }
    }

    // ==========================================
    // UPDATE PRODUCT
    // ==========================================
    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            int productId =
                    Integer.parseInt(
                            request.getParameter("productId")
                    );

            int categoryId =
                    Integer.parseInt(
                            request.getParameter("categoryId")
                    );

            String name =
                    request.getParameter("name");

            String brand =
                    request.getParameter("brand");

            String description =
                    request.getParameter("description");

            double price =
                    Double.parseDouble(
                            request.getParameter("price")
                    );

            double discount =
                    Double.parseDouble(
                            request.getParameter("discount")
                    );

            int stock =
                    Integer.parseInt(
                            request.getParameter("stock")
                    );

            String imageUrl =
                    request.getParameter("imageUrl");

            String statusParameter =
                    request.getParameter("status");

            boolean status =
                    "true".equalsIgnoreCase(
                            statusParameter
                    );

            // ==========================================
            // VALIDATION
            // ==========================================

            if (categoryId <= 0
                    || name == null
                    || name.trim().isEmpty()
                    || brand == null
                    || brand.trim().isEmpty()
                    || description == null
                    || description.trim().isEmpty()
                    || price < 0
                    || discount < 0
                    || discount > 100
                    || stock < 0) {

                response.sendRedirect(
                        request.getContextPath()
                                + "/admin/edit-product?id="
                                + productId
                                + "&error=1"
                );

                return;
            }

            // ==========================================
            // CREATE PRODUCT OBJECT
            // ==========================================

            Product product =
                    new Product();

            product.setProductId(
                    productId
            );

            product.setCategoryId(
                    categoryId
            );

            product.setName(
                    name.trim()
            );

            product.setBrand(
                    brand.trim()
            );

            product.setDescription(
                    description.trim()
            );

            product.setPrice(
                    price
            );

            product.setDiscount(
                    discount
            );

            product.setStock(
                    stock
            );

            product.setImageUrl(
                    imageUrl == null
                            ? ""
                            : imageUrl.trim()
            );

            product.setStatus(
                    status
            );

            // ==========================================
            // UPDATE DATABASE
            // ==========================================

            boolean success =
                    productDAO.updateProduct(
                            product
                    );

            // ==========================================
            // RESULT
            // ==========================================

            if (success) {

                response.sendRedirect(
                        request.getContextPath()
                                + "/admin/products"
                );

            } else {

                response.sendRedirect(
                        request.getContextPath()
                                + "/admin/edit-product?id="
                                + productId
                                + "&error=1"
                );
            }

        } catch (NumberFormatException e) {

            e.printStackTrace();

            response.sendRedirect(
                    request.getContextPath()
                            + "/admin/products"
            );

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    request.getContextPath()
                            + "/admin/products"
            );
        }
    }
}