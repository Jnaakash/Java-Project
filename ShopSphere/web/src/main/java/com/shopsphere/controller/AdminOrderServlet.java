package com.shopsphere.controller;

import com.shopsphere.dao.OrderDAO;
import com.shopsphere.model.Order;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/orders")
public class AdminOrderServlet extends HttpServlet {

    private OrderDAO orderDAO;

    private static final int PAGE_SIZE = 10;

    @Override
    public void init() {

        orderDAO = new OrderDAO();
    }

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        // =============================================
        // GET SEARCH KEYWORD
        // =============================================

        String keyword =
                request.getParameter("keyword");

        // =============================================
        // GET STATUS FILTER
        // =============================================

        String status =
                request.getParameter("status");

        // =============================================
        // GET CURRENT PAGE
        // =============================================

        int page = 1;

        String pageParameter =
                request.getParameter("page");

        if (pageParameter != null
                && !pageParameter.trim().isEmpty()) {

            try {

                page =
                        Integer.parseInt(
                                pageParameter
                        );

            } catch (NumberFormatException e) {

                page = 1;
            }
        }

        // Prevent invalid page number

        if (page < 1) {

            page = 1;
        }

        // =============================================
        // GET TOTAL ORDER COUNT
        // =============================================

        int totalOrders =
                orderDAO.getOrderCountForAdmin(
                        keyword,
                        status
                );

        // =============================================
        // CALCULATE TOTAL PAGES
        // =============================================

        int totalPages =
                (int) Math.ceil(
                        (double) totalOrders
                                / PAGE_SIZE
                );

        // =============================================
        // PREVENT PAGE > TOTAL PAGES
        // =============================================

        if (totalPages > 0
                && page > totalPages) {

            page = totalPages;
        }

        // =============================================
        // GET ORDERS FOR CURRENT PAGE
        // =============================================

        List<Order> orders =
                orderDAO.searchOrdersForAdmin(
                        keyword,
                        status,
                        page,
                        PAGE_SIZE
                );

        // =============================================
        // SEND DATA TO JSP
        // =============================================

        request.setAttribute(
                "orders",
                orders
        );

        request.setAttribute(
                "keyword",
                keyword
        );

        request.setAttribute(
                "status",
                status
        );

        request.setAttribute(
                "currentPage",
                page
        );

        request.setAttribute(
                "totalPages",
                totalPages
        );

        request.setAttribute(
                "totalOrders",
                totalOrders
        );

        request.setAttribute(
                "pageSize",
                PAGE_SIZE
        );

        // =============================================
        // OPEN ADMIN ORDERS PAGE
        // =============================================

        request.getRequestDispatcher(
                "/admin/orders.jsp"
        ).forward(
                request,
                response
        );
    }
}