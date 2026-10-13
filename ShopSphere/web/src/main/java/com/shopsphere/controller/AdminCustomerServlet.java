package com.shopsphere.controller;

import com.shopsphere.dao.UserDAO;
import com.shopsphere.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/customers")
public class AdminCustomerServlet extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() {

        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        // ============================================
        // GET ALL CUSTOMERS
        // ============================================

        List<User> customers =
                userDAO.getAllCustomers();


        // ============================================
        // SEND CUSTOMERS TO JSP
        // ============================================

        request.setAttribute(
                "customers",
                customers
        );


        // ============================================
        // OPEN CUSTOMER MANAGEMENT PAGE
        // ============================================

        request.getRequestDispatcher(
                "/admin/customers.jsp"
        ).forward(
                request,
                response
        );
    }
}