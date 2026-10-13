package com.shopsphere.controller;

import com.shopsphere.model.CartItem;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        List<CartItem> cart =
                (List<CartItem>) session.getAttribute("cart");

        // Cart empty hai to cart page par bhejo
        if (cart == null || cart.isEmpty()) {

            response.sendRedirect(
                    request.getContextPath() + "/cart"
            );

            return;
        }

        // Cart ko checkout page ke liye available karo
        request.setAttribute("cart", cart);

        // Total calculate karo
        double grandTotal = 0;

        for (CartItem item : cart) {

            grandTotal += item.getTotal();
        }

        request.setAttribute(
                "grandTotal",
                grandTotal
        );

        // Checkout JSP open karo
        request.getRequestDispatcher(
                "/checkout.jsp"
        ).forward(
                request,
                response
        );
    }
}