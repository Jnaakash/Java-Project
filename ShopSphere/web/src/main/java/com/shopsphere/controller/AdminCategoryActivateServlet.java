package com.shopsphere.controller;

import com.shopsphere.dao.CategoryDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/admin/categories/activate")
public class AdminCategoryActivateServlet extends HttpServlet {

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

            boolean activated =
                    categoryDAO.activateCategory(
                            categoryId
                    );

            if (activated) {

                response.sendRedirect(
                        request.getContextPath()
                                + "/admin/categories?success=activated"
                );

            } else {

                response.sendRedirect(
                        request.getContextPath()
                                + "/admin/categories?error=activate"
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