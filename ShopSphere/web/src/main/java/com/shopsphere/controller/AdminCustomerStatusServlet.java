package com.shopsphere.controller;

import com.shopsphere.dao.UserDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/admin/customer-status")
public class AdminCustomerStatusServlet extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        try {

            int userId =
                    Integer.parseInt(
                            request.getParameter("userId")
                    );

            String status =
                    request.getParameter("status");

            if (status == null ||
                    (!status.equals("activate")
                    && !status.equals("deactivate"))) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/admin/customers?error=invalid"
                );

                return;
            }

            boolean newStatus =
                    status.equals("activate");

            boolean updated =
                    userDAO.updateCustomerStatus(
                            userId,
                            newStatus
                    );

            if (updated) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/admin/customers?success=updated"
                );

            } else {

                response.sendRedirect(
                        request.getContextPath()
                        + "/admin/customers?error=update"
                );
            }

        } catch (NumberFormatException e) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/admin/customers?error=invalid"
            );

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    request.getContextPath()
                    + "/admin/customers?error=server"
            );
        }
    }
}