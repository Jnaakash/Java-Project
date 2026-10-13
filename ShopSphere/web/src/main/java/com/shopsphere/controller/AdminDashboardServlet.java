package com.shopsphere.controller;

import com.shopsphere.dao.OrderDAO;
import com.shopsphere.dao.ProductDAO;
import com.shopsphere.dao.UserDAO;
import com.shopsphere.model.Order;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {

    private ProductDAO productDAO;
    private OrderDAO orderDAO;
    private UserDAO userDAO;

    @Override
    public void init() {

        productDAO = new ProductDAO();
        orderDAO = new OrderDAO();
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        int activeProductCount =
                productDAO.getActiveProductCount();

        int totalOrderCount =
                orderDAO.getTotalOrderCount();

        int pendingOrderCount =
                orderDAO.getPendingOrderCount();

        int deliveredOrderCount =
                orderDAO.getDeliveredOrderCount();

        int activeCustomerCount =
                userDAO.getActiveCustomerCount();

        int inactiveCustomerCount =
                userDAO.getInactiveCustomerCount();

        double totalSales =
                orderDAO.getTotalSales();

        List<Order> recentOrders =
                orderDAO.getRecentOrders();


        request.setAttribute(
                "activeProductCount",
                activeProductCount
        );

        request.setAttribute(
                "totalOrderCount",
                totalOrderCount
        );

        request.setAttribute(
                "pendingOrderCount",
                pendingOrderCount
        );

        request.setAttribute(
                "deliveredOrderCount",
                deliveredOrderCount
        );

        request.setAttribute(
                "activeCustomerCount",
                activeCustomerCount
        );

        request.setAttribute(
                "inactiveCustomerCount",
                inactiveCustomerCount
        );

        request.setAttribute(
                "totalSales",
                totalSales
        );

        request.setAttribute(
                "recentOrders",
                recentOrders
        );


        request.getRequestDispatcher(
                "/admin/dashboard.jsp"
        ).forward(
                request,
                response
        );
    }
}