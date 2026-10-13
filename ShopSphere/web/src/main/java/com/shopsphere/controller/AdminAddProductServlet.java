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

@WebServlet("/admin/add-product")
public class AdminAddProductServlet extends HttpServlet {

    private ProductDAO productDAO;
    private CategoryDAO categoryDAO;

    @Override
    public void init() {

        productDAO = new ProductDAO();
        categoryDAO = new CategoryDAO();
    }


    // ==========================================
    // SHOW ADD PRODUCT PAGE
    // ==========================================

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute(
                "categories",
                categoryDAO.getActiveCategories()
        );

        request.getRequestDispatcher(
                "/admin/add-product.jsp"
        ).forward(
                request,
                response
        );
    }


    // ==========================================
    // ADD PRODUCT
    // ==========================================

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            // ==========================================
            // CATEGORY
            // ==========================================

            String categoryValue =
                    request.getParameter("categoryId");

            int categoryId;


            if ("OTHER".equals(categoryValue)) {

                String newCategoryName =
                        request.getParameter(
                                "newCategoryName"
                        );

                String newCategoryDescription =
                        request.getParameter(
                                "newCategoryDescription"
                        );


                // Validate new category name

                if (newCategoryName == null
                        || newCategoryName.trim().isEmpty()) {

                    response.sendRedirect(
                            request.getContextPath()
                                    + "/admin/add-product?error=category"
                    );

                    return;
                }


                // Create/find category

                categoryId =
                        categoryDAO.findOrCreateCategory(
                                newCategoryName.trim(),
                                newCategoryDescription
                        );


                if (categoryId <= 0) {

                    response.sendRedirect(
                            request.getContextPath()
                                    + "/admin/add-product?error=category"
                    );

                    return;
                }

            } else {

                if (categoryValue == null
                        || categoryValue.trim().isEmpty()) {

                    response.sendRedirect(
                            request.getContextPath()
                                    + "/admin/add-product?error=1"
                    );

                    return;
                }


                categoryId =
                        Integer.parseInt(categoryValue);
            }


            // ==========================================
            // PRODUCT VALUES
            // ==========================================

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
                                + "/admin/add-product?error=1"
                );

                return;
            }


            // ==========================================
            // CREATE PRODUCT
            // ==========================================

            Product product =
                    new Product();

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

            product.setStatus(true);


            // ==========================================
            // INSERT PRODUCT
            // ==========================================

            boolean success =
                    productDAO.insertProduct(
                            product
                    );


            // ==========================================
            // RESULT
            // ==========================================

            if (success) {

                response.sendRedirect(
                        request.getContextPath()
                                + "/admin/products?success=added"
                );

            } else {

                response.sendRedirect(
                        request.getContextPath()
                                + "/admin/add-product?error=1"
                );
            }


        } catch (NumberFormatException e) {

            e.printStackTrace();

            response.sendRedirect(
                    request.getContextPath()
                            + "/admin/add-product?error=1"
            );

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    request.getContextPath()
                            + "/admin/add-product?error=1"
            );
        }
    }
}