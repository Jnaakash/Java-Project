package com.shopsphere.controller;

import com.shopsphere.dao.CategoryDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/admin/categories/deactivate")
public class AdminCategoryDeactivateServlet extends HttpServlet {

    private CategoryDAO categoryDAO;

    @Override
    public void init() {
        categoryDAO = new CategoryDAO();
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            int categoryId =
                    Integer.parseInt(
                            request.getParameter("id")
                    );

            boolean deactivated =
                    categoryDAO.deactivateCategory(
                            categoryId
                    );

            if (deactivated) {

                response.sendRedirect(
                        request.getContextPath()
                                + "/admin/categories?success=deactivated"
                );

            } else {

                response.sendRedirect(
                        request.getContextPath()
                                + "/admin/categories?error=deactivate"
                );
            }

        } catch (NumberFormatException e) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/admin/categories?error=invalid"
            );

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    request.getContextPath()
                            + "/admin/categories?error=server"
            );
        }
    }
}