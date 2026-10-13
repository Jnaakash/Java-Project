package com.shopsphere.controller;

import com.shopsphere.dao.AddressDAO;
import com.shopsphere.dao.OrderDAO;
import com.shopsphere.model.CartItem;
import com.shopsphere.model.Order;
import com.shopsphere.model.OrderItem;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/place-order")
public class OrderServlet extends HttpServlet {

    private AddressDAO addressDAO;
    private OrderDAO orderDAO;

    @Override
    public void init() {

        addressDAO = new AddressDAO();
        orderDAO = new OrderDAO();
    }


    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        // =====================================================
        // STEP 1: CHECK LOGIN
        // =====================================================

        HttpSession session =
                request.getSession();

        Integer userId =
                (Integer) session.getAttribute("userId");

        if (userId == null) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/login"
            );

            return;
        }


        // =====================================================
        // STEP 2: GET CART
        // =====================================================

        List<CartItem> cart =
                (List<CartItem>)
                session.getAttribute("cart");

        if (cart == null || cart.isEmpty()) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/cart"
            );

            return;
        }


        // =====================================================
        // STEP 3: GET FORM DATA
        // =====================================================

        String addressLine =
                request.getParameter("address");

        String city =
                request.getParameter("city");

        String state =
                request.getParameter("state");

        String pincode =
                request.getParameter("pincode");

        String paymentMethod =
                request.getParameter("paymentMethod");


        // =====================================================
        // STEP 4: BASIC ADDRESS VALIDATION
        // =====================================================

        if (isBlank(addressLine)
                || isBlank(city)
                || isBlank(state)
                || isBlank(pincode)
                || isBlank(paymentMethod)) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/checkout"
            );

            return;
        }


        // =====================================================
        // STEP 5: PINCODE VALIDATION
        // =====================================================

        if (!pincode.trim().matches("\\d{6}")) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/checkout"
            );

            return;
        }


        // =====================================================
        // STEP 6: PAYMENT METHOD VALIDATION
        // =====================================================

        if (!isValidPaymentMethod(paymentMethod)) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/checkout"
            );

            return;
        }


        // =====================================================
        // STEP 7: SAVE ADDRESS
        // =====================================================

        int addressId =
                addressDAO.saveAddress(
                        userId,
                        addressLine.trim(),
                        city.trim(),
                        state.trim(),
                        pincode.trim(),
                        "HOME"
                );

        if (addressId == -1) {

            response.sendError(
                    HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Unable to save delivery address"
            );

            return;
        }


        // =====================================================
        // STEP 8: PREPARE ORDER ITEMS
        // =====================================================
        //
        // IMPORTANT:
        // Price from CartItem is NOT trusted.
        // OrderDAO will re-read the current DB price.
        //
        // =====================================================

        List<OrderItem> orderItems =
                new ArrayList<>();

        for (CartItem cartItem : cart) {

            if (cartItem == null) {
                continue;
            }

            if (cartItem.getProductId() <= 0) {
                response.sendError(
                        HttpServletResponse.SC_BAD_REQUEST,
                        "Invalid product in cart"
                );
                return;
            }

            if (cartItem.getQuantity() <= 0) {
                response.sendError(
                        HttpServletResponse.SC_BAD_REQUEST,
                        "Invalid quantity in cart"
                );
                return;
            }

            OrderItem orderItem =
                    new OrderItem();

            orderItem.setProductId(
                    cartItem.getProductId()
            );

            orderItem.setQuantity(
                    cartItem.getQuantity()
            );

            // This value will be replaced by the
            // current database price inside OrderDAO.
            orderItem.setPrice(0.0);

            orderItems.add(orderItem);
        }


        if (orderItems.isEmpty()) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/cart"
            );

            return;
        }


        // =====================================================
        // STEP 9: CREATE ORDER OBJECT
        // =====================================================

        Order order =
                new Order();

        order.setUserId(userId);

        order.setAddressId(addressId);

        // OrderDAO calculates this from DB prices.
        order.setTotalAmount(0.0);

        order.setDiscount(0.00);

        order.setPaymentMethod(
                paymentMethod.trim().toUpperCase()
        );

        order.setPaymentStatus(
                "PENDING"
        );

        order.setOrderStatus(
                "PLACED"
        );


        // =====================================================
        // STEP 10: CREATE ORDER
        // =====================================================

        int orderId =
                orderDAO.createOrder(
                        order,
                        orderItems
                );


        // =====================================================
        // STEP 11: CHECK RESULT
        // =====================================================

        if (orderId == -1) {

            response.sendError(
                    HttpServletResponse.SC_CONFLICT,
                    "Unable to place order. " +
                    "Product may be out of stock or unavailable."
            );

            return;
        }


        // =====================================================
        // STEP 12: CLEAR CART
        // =====================================================
        //
        // Cart is cleared ONLY after successful DB commit.
        //
        // =====================================================

        session.removeAttribute("cart");


        // =====================================================
        // STEP 13: SUCCESS
        // =====================================================

        response.sendRedirect(
                request.getContextPath()
                + "/order-success?orderId="
                + orderId
        );
    }


    // =====================================================
    // CHECK EMPTY STRING
    // =====================================================

    private boolean isBlank(String value) {

        return value == null
                || value.trim().isEmpty();
    }


    // =====================================================
    // VALID PAYMENT METHODS
    // =====================================================

    private boolean isValidPaymentMethod(
            String paymentMethod) {

        if (paymentMethod == null) {
            return false;
        }

        String method =
                paymentMethod.trim().toUpperCase();

        return method.equals("COD")
                || method.equals("UPI")
                || method.equals("CARD")
                || method.equals("NET_BANKING");
    }
}