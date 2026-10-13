
package com.shopsphere.controller;

import com.shopsphere.dao.OrderDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.Set;

@WebServlet("/admin/update-order-status")
public class UpdateOrderStatusServlet extends HttpServlet {

    private OrderDAO orderDAO;

    private static final Set<String> ALLOWED_STATUSES = Set.of(
            "PLACED",
            "CONFIRMED",
            "PROCESSING",
            "SHIPPED",
            "DELIVERED",
            "CANCELLED"
    );

    @Override
    public void init() {
        orderDAO = new OrderDAO();
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String orderIdParameter = request.getParameter("orderId");

        // IMPORTANT: JSP sends the parameter named "status".
        String orderStatus = request.getParameter("status");

        int orderId;

        try {
            if (orderIdParameter == null
                    || orderIdParameter.isBlank()) {
                throw new NumberFormatException("Missing order ID");
            }

            orderId = Integer.parseInt(orderIdParameter.trim());

            if (orderId <= 0) {
                throw new NumberFormatException("Invalid order ID");
            }

        } catch (NumberFormatException e) {
            response.sendRedirect(
                    request.getContextPath()
                            + "/admin/orders?error=invalid");
            return;
        }

        if (orderStatus == null
                || !ALLOWED_STATUSES.contains(orderStatus.trim())) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/admin/orders?error=invalid");
            return;
        }

        orderStatus = orderStatus.trim();

        try {
            boolean updated = orderDAO.updateOrderStatus(
                    orderId,
                    orderStatus
            );

            if (updated) {
                response.sendRedirect(
                        request.getContextPath()
                                + "/admin/orders?success=status");
            } else {
                response.sendRedirect(
                        request.getContextPath()
                                + "/admin/orders?error=update");
            }

        } catch (Exception e) {
            getServletContext().log(
                    "Failed to update order status for order ID: "
                            + orderId,
                    e
            );

            response.sendRedirect(
                    request.getContextPath()
                            + "/admin/orders?error=server");
        }
    }
}
