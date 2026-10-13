package com.shopsphere.controller;

import com.shopsphere.dao.CategoryDAO;
import com.shopsphere.model.Category;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/admin/categories/edit")
public class AdminEditCategoryServlet extends HttpServlet {

    private CategoryDAO categoryDAO;

    @Override
    public void init() {
        categoryDAO = new CategoryDAO();
    }

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String idParameter =
                request.getParameter("id");

        if (idParameter == null
                || idParameter.trim().isEmpty()) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/admin/categories?error=invalid"
            );

            return;
        }

        try {

            int categoryId =
                    Integer.parseInt(idParameter);

            Category category =
                    categoryDAO.getCategoryById(
                            categoryId
                    );

            if (category == null) {

                response.sendRedirect(
                        request.getContextPath()
                                + "/admin/categories?error=notfound"
                );

                return;
            }

            request.setAttribute(
                    "category",
                    category
            );

            request.getRequestDispatcher(
                    "/admin/edit-category.jsp"
            ).forward(
                    request,
                    response
            );

        } catch (NumberFormatException e) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/admin/categories?error=invalid"
            );
        }
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String idParameter =
                request.getParameter("categoryId");

        String name =
                request.getParameter("name");

        String description =
                request.getParameter("description");

        String statusParameter =
                request.getParameter("status");

        if (idParameter == null
                || idParameter.trim().isEmpty()) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/admin/categories?error=invalid"
            );

            return;
        }

        try {

            int categoryId =
                    Integer.parseInt(idParameter);

            name =
                    name == null
                            ? ""
                            : name.trim();

            description =
                    description == null
                            ? ""
                            : description.trim();

            if (name.isEmpty()) {

                response.sendRedirect(
                        request.getContextPath()
                                + "/admin/categories/edit?id="
                                + categoryId
                                + "&error=name"
                );

                return;
            }

            boolean status =
                    "true".equalsIgnoreCase(
                            statusParameter
                    );

            Category category =
                    new Category();

            category.setCategoryId(categoryId);
            category.setName(name);
            category.setDescription(description);
            category.setStatus(status);

            boolean updated =
                    categoryDAO.updateCategory(
                            category
                    );

            if (updated) {

                response.sendRedirect(
                        request.getContextPath()
                                + "/admin/categories?success=updated"
                );

            } else {

                response.sendRedirect(
                        request.getContextPath()
                                + "/admin/categories/edit?id="
                                + categoryId
                                + "&error=database"
                );
            }

        } catch (NumberFormatException e) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/admin/categories?error=invalid"
            );
        }
    }
}