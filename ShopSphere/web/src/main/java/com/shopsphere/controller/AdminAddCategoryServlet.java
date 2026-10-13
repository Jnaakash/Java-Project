package com.shopsphere.controller;

import com.shopsphere.dao.CategoryDAO;
import com.shopsphere.model.Category;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/admin/categories/add")
public class AdminAddCategoryServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private CategoryDAO categoryDAO;

    @Override
    public void init() throws ServletException {
        categoryDAO = new CategoryDAO();
    }

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher(
                "/admin/add-category.jsp"
        ).forward(request, response);
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String statusValue = request.getParameter("status");

        if (name == null || name.trim().isEmpty()) {
            response.sendRedirect(
                    request.getContextPath()
                            + "/admin/categories/add?error=name"
            );
            return;
        }

        Category category = new Category();

        category.setName(name.trim());

        category.setDescription(
                description == null
                        ? ""
                        : description.trim()
        );

        category.setStatus(
                !"false".equalsIgnoreCase(statusValue)
        );

        boolean success =
                categoryDAO.insertCategory(category);

        if (success) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/admin/categories?success=1"
            );

        } else {

            response.sendRedirect(
                    request.getContextPath()
                            + "/admin/categories/add?error=database"
            );
        }
    }
}