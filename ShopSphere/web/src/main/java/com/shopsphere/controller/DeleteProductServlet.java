package com.shopsphere.controller;

import com.shopsphere.dao.ProductDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/admin/delete-product")
public class DeleteProductServlet extends HttpServlet {

    private ProductDAO productDAO;

    @Override
    public void init() {
        productDAO = new ProductDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request,
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

            boolean success =
                    productDAO.deactivateProduct(productId);

            if (success) {

                response.sendRedirect(
                        request.getContextPath()
                                + "/admin/products"
                );

            } else {

                response.sendError(
                        HttpServletResponse.SC_NOT_FOUND,
                        "Product could not be deactivated"
                );
            }

        } catch (NumberFormatException e) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid Product ID"
            );
        }
    }
}