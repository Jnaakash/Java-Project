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

@WebServlet("/admin/orders/details")
public class AdminOrderDetailsServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private OrderDAO orderDAO;
    private OrderItemDAO orderItemDAO;
    private AddressDAO addressDAO;

    @Override
    public void init() throws ServletException {
        orderDAO = new OrderDAO();
        orderItemDAO = new OrderItemDAO();
        addressDAO = new AddressDAO();
    }

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // Check login
        if (session == null) {
            response.sendRedirect(
                    request.getContextPath() + "/login"
            );
            return;
        }

        // Check admin role
        Object role = session.getAttribute("role");

        if (role == null ||
                !"ADMIN".equalsIgnoreCase(role.toString())) {

            response.sendError(
                    HttpServletResponse.SC_FORBIDDEN,
                    "Access Denied"
            );
            return;
        }

        // Get order ID
        String idParameter =
                request.getParameter("id");

        if (idParameter == null ||
                idParameter.trim().isEmpty()) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/admin/orders?error=invalid"
            );
            return;
        }

        try {

            int orderId =
                    Integer.parseInt(idParameter);

            // Get all orders
            List<Order> allOrders =
                    orderDAO.getAllOrders();

            Order selectedOrder = null;

            // Find requested order
            for (Order order : allOrders) {

                if (order.getOrderId() == orderId) {

                    selectedOrder = order;
                    break;
                }
            }

            // Order not found
            if (selectedOrder == null) {

                response.sendRedirect(
                        request.getContextPath()
                                + "/admin/orders?error=notfound"
                );
                return;
            }

            // Get order items
            List<OrderItem> items =
                    orderItemDAO.getItemsByOrderId(orderId);

            // Get delivery address
            AddressDAO.AddressData address =
                    addressDAO.getAddressById(
                            selectedOrder.getAddressId()
                    );

            // Send data to JSP
            request.setAttribute(
                    "order",
                    selectedOrder
            );

            request.setAttribute(
                    "items",
                    items
            );

            request.setAttribute(
                    "address",
                    address
            );

            // Forward to JSP
            request.getRequestDispatcher(
                    "/admin/order-details.jsp"
            ).forward(
                    request,
                    response
            );

        } catch (NumberFormatException e) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/admin/orders?error=invalid"
            );

        } catch (Exception e) {

            e.printStackTrace();

            response.sendError(
                    HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Unable to load order details"
            );
        }
    }
}