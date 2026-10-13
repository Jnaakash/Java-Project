
package com.shopsphere.controller;

import com.shopsphere.dao.AddressDAO;
import com.shopsphere.dao.OrderDAO;
import com.shopsphere.dao.OrderItemDAO;
import com.shopsphere.model.Order;
import com.shopsphere.model.OrderItem;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/order-details")
public class OrderDetailsServlet extends HttpServlet {

    private OrderDAO orderDAO;
    private OrderItemDAO orderItemDAO;
    private AddressDAO addressDAO;

    @Override
    public void init() {
        orderDAO = new OrderDAO();
        orderItemDAO = new OrderItemDAO();
        addressDAO = new AddressDAO();
    }

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        // Check login session
        HttpSession session = request.getSession(false);

        if (session == null
                || !(session.getAttribute("userId") instanceof Integer)) {

            response.sendRedirect(
                    request.getContextPath() + "/login");
            return;
        }

        Integer userId = (Integer) session.getAttribute("userId");

        // Validate order ID
        String idParameter = request.getParameter("id");

        if (idParameter == null || idParameter.trim().isEmpty()) {
            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Order ID is missing");
            return;
        }

        final int orderId;

        try {
            orderId = Integer.parseInt(idParameter.trim());

            if (orderId <= 0) {
                throw new NumberFormatException("Order ID must be positive");
            }
        } catch (NumberFormatException e) {
            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid Order ID");
            return;
        }

        try {
            // Fetch only the logged-in customer's orders.
            List<Order> orders = orderDAO.getOrdersByUserId(userId);

            if (orders == null) {
                throw new ServletException(
                        "OrderDAO returned null for customer " + userId);
            }

            Order selectedOrder = null;

            for (Order order : orders) {
                if (order != null && order.getOrderId() == orderId) {
                    selectedOrder = order;
                    break;
                }
            }

            // Do not allow customers to view another customer's order.
            if (selectedOrder == null) {
                response.sendError(
                        HttpServletResponse.SC_NOT_FOUND,
                        "Order not found for this customer");
                return;
            }

            List<OrderItem> orderItems =
                    orderItemDAO.getItemsByOrderId(orderId);

            AddressDAO.AddressData address =
                    addressDAO.getAddressById(
                            selectedOrder.getAddressId());

            request.setAttribute("order", selectedOrder);
            request.setAttribute("orderItems", orderItems);
            request.setAttribute("address", address);

            request.getRequestDispatcher("/order-details.jsp")
                    .forward(request, response);

        } catch (ServletException e) {
            throw e;
        } catch (Exception e) {
            getServletContext().log(
                    "Failed to load order details. Order ID: "
                            + orderId + ", customer ID: " + userId,
                    e);

            response.sendError(
                    HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Unable to load order details. Please try again.");
        }
    }
}
