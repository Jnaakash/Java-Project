package com.shopsphere.controller;

import com.shopsphere.dao.ProductDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/admin/products/deactivate")
public class AdminProductDeactivateServlet extends HttpServlet {

    private ProductDAO productDAO;

    @Override
    public void init() {
        productDAO = new ProductDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        try {

            int productId =
                    Integer.parseInt(
                            request.getParameter("id")
                    );

            boolean deactivated =
                    productDAO.deactivateProduct(productId);

            if (deactivated) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/admin/products?success=deactivated"
                );

            } else {

                response.sendRedirect(
                        request.getContextPath()
                        + "/admin/products?error=deactivate"
                );
            }

        } catch (NumberFormatException e) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/admin/products?error=invalid"
            );

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    request.getContextPath()
                    + "/admin/products?error=server"
            );
        }
    }
}