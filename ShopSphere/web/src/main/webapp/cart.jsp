<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.shopsphere.model.CartItem" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <title>ShopSphere - Shopping Cart</title>

    <style>

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: Arial, sans-serif;
            background: #f5f5f5;
            color: #333;
        }

        /* =========================
           NAVBAR
        ========================= */

        .navbar {
            background: #111827;
            color: white;
            padding: 18px 40px;

            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .navbar h1 {
            font-size: 24px;
        }

        .navbar a {
            color: white;
            text-decoration: none;
            margin-left: 25px;
        }

        /* =========================
           MAIN CONTAINER
        ========================= */

        .container {
            width: 90%;
            max-width: 1150px;
            margin: 40px auto;
        }

        .container h2 {
            margin-bottom: 25px;
        }

        /* =========================
           CART BOX
        ========================= */

        .cart-box {
            background: white;
            border-radius: 10px;
            padding: 20px;

            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
        }

        /* =========================
           TABLE
        ========================= */

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th,
        td {
            padding: 15px;
            border-bottom: 1px solid #ddd;
            text-align: left;
        }

        th {
            background: #f3f4f6;
        }

        /* =========================
           QUANTITY CONTROLS
        ========================= */

        .quantity-box {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .quantity-btn {
            display: inline-flex;

            width: 32px;
            height: 32px;

            align-items: center;
            justify-content: center;

            background: #2563eb;
            color: white;

            text-decoration: none;

            border-radius: 5px;

            font-size: 18px;
            font-weight: bold;
        }

        .quantity-btn:hover {
            background: #1d4ed8;
        }

        .quantity-value {
            min-width: 30px;

            text-align: center;

            font-weight: bold;
        }

        /* =========================
           REMOVE BUTTON
        ========================= */

        .remove-btn {
            background: #dc2626;
            color: white;

            text-decoration: none;

            padding: 8px 12px;

            border-radius: 5px;
        }

        .remove-btn:hover {
            background: #b91c1c;
        }

        /* =========================
           GRAND TOTAL
        ========================= */

        .total {
            text-align: right;

            margin-top: 25px;

            font-size: 20px;

            font-weight: bold;
        }

        /* =========================
           EMPTY CART
        ========================= */

        .empty {
            text-align: center;

            padding: 40px;
        }

        .shop-btn {
            display: inline-block;

            margin-top: 20px;

            background: #2563eb;

            color: white;

            text-decoration: none;

            padding: 12px 20px;

            border-radius: 6px;
        }

        .shop-btn:hover {
            background: #1d4ed8;
        }

    </style>

</head>


<body>

    <jsp:include page="/WEB-INF/jsp/fragments/header.jspf" />


<!-- =========================
     NAVBAR
========================= -->

<div class="navbar">

    <h1>ShopSphere</h1>

    <div>

        <a href="<%= request.getContextPath() %>/products">
            Products
        </a>

        <a href="<%= request.getContextPath() %>/cart">
            Cart
        </a>

    </div>

</div>


<!-- =========================
     MAIN CONTENT
========================= -->

<div class="container">

    <h2>Shopping Cart</h2>


    <div class="cart-box">

        <%

            List<CartItem> cart =
                    (List<CartItem>) request.getAttribute("cart");


            if (cart == null || cart.isEmpty()) {

        %>


            <!-- =========================
                 EMPTY CART
            ========================= -->

            <div class="empty">

                <h3>Your cart is empty</h3>

                <p>
                    Add some products to your cart.
                </p>

                <a class="shop-btn"
                   href="<%= request.getContextPath() %>/products">

                    Continue Shopping

                </a>

            </div>


        <%

            } else {

                double grandTotal = 0;

        %>


            <!-- =========================
                 CART TABLE
            ========================= -->

            <table>

                <thead>

                <tr>

                    <th>
                        Product
                    </th>

                    <th>
                        Price
                    </th>

                    <th>
                        Quantity
                    </th>

                    <th>
                        Total
                    </th>

                    <th>
                        Action
                    </th>

                </tr>

                </thead>


                <tbody>


                <%

                    for (CartItem item : cart) {

                        double itemTotal =
                                item.getTotal();

                        grandTotal += itemTotal;

                %>


                <tr>


                    <!-- PRODUCT NAME -->

                    <td>

                        <%= item.getProductName() %>

                    </td>


                    <!-- PRICE -->

                    <td>

                        ₹<%= item.getPrice() %>

                    </td>


                    <!-- QUANTITY -->

                    <td>

                        <div class="quantity-box">


                            <!-- MINUS BUTTON -->

                            <a class="quantity-btn"
                               href="<%= request.getContextPath() %>/cart?action=update&id=<%= item.getProductId() %>&quantity=<%= item.getQuantity() - 1 %>">

                                −

                            </a>


                            <!-- CURRENT QUANTITY -->

                            <span class="quantity-value">

                                <%= item.getQuantity() %>

                            </span>


                            <!-- PLUS BUTTON -->

                            <a class="quantity-btn"
                               href="<%= request.getContextPath() %>/cart?action=update&id=<%= item.getProductId() %>&quantity=<%= item.getQuantity() + 1 %>">

                                +

                            </a>


                        </div>

                    </td>


                    <!-- ITEM TOTAL -->

                    <td>

                        ₹<%= itemTotal %>

                    </td>


                    <!-- REMOVE -->

                    <td>

                        <a class="remove-btn"
                           href="<%= request.getContextPath() %>/cart?action=remove&id=<%= item.getProductId() %>">

                            Remove

                        </a>

                    </td>


                </tr>


                <%

                    }

                %>


                </tbody>

            </table>


            <!-- =========================
                 GRAND TOTAL
            ========================= -->

            <div class="total">

                Grand Total:
                ₹<%= grandTotal %>

            </div>

            <div style="text-align: right; margin-top: 20px;">

    <a href="<%= request.getContextPath() %>/checkout"
       style="
           display: inline-block;
           background: #16a34a;
           color: white;
           padding: 12px 24px;
           text-decoration: none;
           border-radius: 6px;
           font-weight: bold;
       ">

        Proceed to Checkout →

    </a>

</div>


        <%

            }

        %>


    </div>

</div>


</body>

</html>