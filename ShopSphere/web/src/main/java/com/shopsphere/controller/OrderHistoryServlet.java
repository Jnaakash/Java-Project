package com.shopsphere.controller;

import com.shopsphere.dao.OrderDAO;
import com.shopsphere.model.Order;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/orders")
public class OrderHistoryServlet extends HttpServlet {

    private OrderDAO orderDAO;

    @Override
    public void init() {
        orderDAO = new OrderDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        // Get logged-in user's ID
        Integer userId =
                (Integer) session.getAttribute("userId");

        // User must be logged in
        if (userId == null) {

            response.sendRedirect(
                    request.getContextPath() + "/login"
            );

            return;
        }

        // Get orders belonging to this user
        List<Order> orders =
                orderDAO.getOrdersByUserId(userId);

        // Send orders to JSP
        request.setAttribute(
                "orders",
                orders
        );

        // Open orders.jsp
        request.getRequestDispatcher(
                "/orders.jsp"
        ).forward(
                request,
                response
        );
    }
}