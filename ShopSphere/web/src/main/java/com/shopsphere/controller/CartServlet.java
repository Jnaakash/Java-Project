package com.shopsphere.controller;

import com.shopsphere.dao.ProductDAO;
import com.shopsphere.model.CartItem;
import com.shopsphere.model.Product;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {

    private final ProductDAO productDAO = new ProductDAO();

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("add".equalsIgnoreCase(action)) {

            addToCart(request, response);

        } else if ("remove".equalsIgnoreCase(action)) {

            removeFromCart(request, response);

        } else if ("update".equalsIgnoreCase(action)) {

            updateCart(request, response);

        } else {

            showCart(request, response);
        }
    }


    // =====================================================
    // ADD PRODUCT TO CART
    // =====================================================

    private void addToCart(
            HttpServletRequest request,
            HttpServletResponse response)
            throws IOException {

        Integer productId = parsePositiveInt(
                request.getParameter("id")
        );

        if (productId == null) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid product ID"
            );

            return;
        }

        Product product =
                productDAO.getProductById(productId);

        // getProductById() already returns only active products.
        if (product == null) {

            response.sendError(
                    HttpServletResponse.SC_NOT_FOUND,
                    "Product not found or inactive"
            );

            return;
        }

        // No stock available.
        if (product.getStock() <= 0) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/products?error=outofstock"
            );

            return;
        }

        HttpSession session =
                request.getSession();

        List<CartItem> cart =
                getOrCreateCart(session);

        boolean found = false;

        for (CartItem cartItem : cart) {

            if (cartItem.getProductId() == productId) {

                int newQuantity =
                        cartItem.getQuantity() + 1;

                // Never allow cart quantity
                // to exceed current database stock.
                if (newQuantity > product.getStock()) {

                    response.sendRedirect(
                            request.getContextPath()
                                    + "/cart?error=stock"
                    );

                    return;
                }

                cartItem.setQuantity(newQuantity);

                // Refresh current DB price.
                cartItem.setPrice(product.getPrice());

                // Refresh image.
                cartItem.setImage(
                        product.getImageUrl()
                );

                found = true;

                break;
            }
        }

        // Add new product.
        if (!found) {

            CartItem item =
                    new CartItem(
                            product.getProductId(),
                            product.getName(),
                            product.getPrice(),
                            1,
                            product.getImageUrl()
                    );

            cart.add(item);
        }

        session.setAttribute("cart", cart);

        response.sendRedirect(
                request.getContextPath()
                        + "/cart"
        );
    }


    // =====================================================
    // REMOVE PRODUCT FROM CART
    // =====================================================

    private void removeFromCart(
            HttpServletRequest request,
            HttpServletResponse response)
            throws IOException {

        Integer productId = parsePositiveInt(
                request.getParameter("id")
        );

        if (productId == null) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid product ID"
            );

            return;
        }

        HttpSession session =
                request.getSession();

        List<CartItem> cart =
                getOrCreateCart(session);

        cart.removeIf(
                item ->
                        item.getProductId() == productId
        );

        session.setAttribute(
                "cart",
                cart
        );

        response.sendRedirect(
                request.getContextPath()
                        + "/cart"
        );
    }


    // =====================================================
    // UPDATE CART QUANTITY
    // =====================================================

    private void updateCart(
            HttpServletRequest request,
            HttpServletResponse response)
            throws IOException {

        Integer productId = parsePositiveInt(
                request.getParameter("id")
        );

        Integer quantity = parseInteger(
                request.getParameter("quantity")
        );

        if (productId == null || quantity == null) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid product ID or quantity"
            );

            return;
        }

        HttpSession session =
                request.getSession();

        List<CartItem> cart =
                getOrCreateCart(session);

        CartItem selectedItem = null;

        for (CartItem item : cart) {

            if (item.getProductId() == productId) {

                selectedItem = item;
                break;
            }
        }

        // Product is not present in cart.
        if (selectedItem == null) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/cart"
            );

            return;
        }

        // Quantity 0 or negative = remove.
        if (quantity <= 0) {

            cart.remove(selectedItem);

            session.setAttribute(
                    "cart",
                    cart
            );

            response.sendRedirect(
                    request.getContextPath()
                            + "/cart"
            );

            return;
        }

        // Get latest product information from DB.
        Product product =
                productDAO.getProductById(productId);

        if (product == null) {

            // Product is no longer active.
            cart.remove(selectedItem);

            session.setAttribute(
                    "cart",
                    cart
            );

            response.sendRedirect(
                    request.getContextPath()
                            + "/cart?error=product"
            );

            return;
        }

        // Quantity cannot exceed current stock.
        if (quantity > product.getStock()) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/cart?error=stock"
            );

            return;
        }

        selectedItem.setQuantity(quantity);

        // Refresh current price from DB.
        selectedItem.setPrice(
                product.getPrice()
        );

        // Refresh current image.
        selectedItem.setImage(
                product.getImageUrl()
        );

        session.setAttribute(
                "cart",
                cart
        );

        response.sendRedirect(
                request.getContextPath()
                        + "/cart"
        );
    }


    // =====================================================
    // SHOW CART
    // =====================================================

    private void showCart(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession();

        List<CartItem> cart =
                getOrCreateCart(session);

        request.setAttribute(
                "cart",
                cart
        );

        request.getRequestDispatcher(
                "/cart.jsp"
        ).forward(
                request,
                response
        );
    }


    // =====================================================
    // GET / CREATE SESSION CART
    // =====================================================

    @SuppressWarnings("unchecked")
    private List<CartItem> getOrCreateCart(
            HttpSession session) {

        Object cartObject =
                session.getAttribute("cart");

        if (cartObject instanceof List<?>) {

            return (List<CartItem>) cartObject;
        }

        List<CartItem> cart =
                new ArrayList<>();

        session.setAttribute(
                "cart",
                cart
        );

        return cart;
    }


    // =====================================================
    // PARSE POSITIVE INTEGER
    // =====================================================

    private Integer parsePositiveInt(
            String value) {

        try {

            if (value == null ||
                    value.trim().isEmpty()) {

                return null;
            }

            int number =
                    Integer.parseInt(value.trim());

            if (number <= 0) {
                return null;
            }

            return number;

        } catch (NumberFormatException e) {

            return null;
        }
    }


    // =====================================================
    // PARSE INTEGER
    // =====================================================

    private Integer parseInteger(
            String value) {

        try {

            if (value == null ||
                    value.trim().isEmpty()) {

                return null;
            }

            return Integer.parseInt(
                    value.trim()
            );

        } catch (NumberFormatException e) {

            return null;
        }
    }
}