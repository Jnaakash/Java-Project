<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.shopsphere.model.CartItem" %>

<%
    String contextPath = request.getContextPath();

    List<CartItem> cart =
            (List<CartItem>) request.getAttribute("cart");

    Double grandTotal =
            (Double) request.getAttribute("grandTotal");

    if (grandTotal == null) {
        grandTotal = 0.0;
    }
%>

<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Checkout | ShopSphere</title>

    <link rel="preconnect"
          href="https://fonts.googleapis.com">

    <link rel="preconnect"
          href="https://fonts.gstatic.com"
          crossorigin>

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap"
          rel="stylesheet">

    <style>

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: 'Inter', sans-serif;
            background:
                radial-gradient(
                    circle at 10% 10%,
                    rgba(59, 130, 246, 0.10),
                    transparent 30%
                ),
                radial-gradient(
                    circle at 90% 20%,
                    rgba(139, 92, 246, 0.10),
                    transparent 30%
                ),
                #f7f9fc;
            color: #172033;
            min-height: 100vh;
        }

        /* ================================
           NAVBAR
        ================================= */

        .navbar {
            height: 74px;
            background: rgba(255, 255, 255, 0.92);
            backdrop-filter: blur(14px);
            border-bottom: 1px solid #e8edf5;

            display: flex;
            align-items: center;
            justify-content: space-between;

            padding: 0 6%;

            position: sticky;
            top: 0;
            z-index: 100;
        }

        .brand {
            display: flex;
            align-items: center;
            gap: 10px;

            text-decoration: none;
            color: #111827;
        }

        .brand-logo {
            width: 38px;
            height: 38px;

            border-radius: 11px;

            display: flex;
            align-items: center;
            justify-content: center;

            background:
                linear-gradient(
                    135deg,
                    #2563eb,
                    #7c3aed
                );

            color: white;
            font-weight: 800;
            font-size: 18px;

            box-shadow:
                0 8px 20px rgba(37, 99, 235, 0.25);
        }

        .brand-name {
            font-size: 21px;
            font-weight: 800;
            letter-spacing: -0.5px;
        }

        .nav-links {
            display: flex;
            align-items: center;
            gap: 25px;
        }

        .nav-links a {
            text-decoration: none;
            color: #64748b;
            font-size: 14px;
            font-weight: 600;

            transition: 0.25s;
        }

        .nav-links a:hover {
            color: #2563eb;
        }

        .checkout-label {
            display: flex;
            align-items: center;
            gap: 8px;

            color: #2563eb !important;
        }

        /* ================================
           PAGE
        ================================= */

        .page {
            width: 92%;
            max-width: 1250px;

            margin: 42px auto 70px;
        }

        .page-heading {
            margin-bottom: 28px;
        }

        .eyebrow {
            color: #2563eb;
            font-size: 12px;
            font-weight: 800;

            text-transform: uppercase;
            letter-spacing: 1.5px;

            margin-bottom: 8px;
        }

        .page-heading h1 {
            font-size: 34px;
            letter-spacing: -1px;
            margin-bottom: 8px;
        }

        .page-heading p {
            color: #64748b;
            font-size: 15px;
        }

        /* ================================
           CHECKOUT GRID
        ================================= */

        .checkout-grid {
            display: grid;
            grid-template-columns:
                minmax(0, 1.45fr)
                minmax(350px, 0.75fr);

            gap: 28px;

            align-items: start;
        }

        .card {
            background: rgba(255, 255, 255, 0.96);

            border: 1px solid #e7ecf4;

            border-radius: 20px;

            box-shadow:
                0 15px 45px rgba(15, 23, 42, 0.07);

            padding: 28px;
        }

        .card-header {
            display: flex;
            align-items: center;
            gap: 14px;

            margin-bottom: 25px;
        }

        .card-icon {
            width: 44px;
            height: 44px;

            border-radius: 13px;

            display: flex;
            align-items: center;
            justify-content: center;

            background: #eff6ff;
            color: #2563eb;

            font-size: 20px;
        }

        .card-header h2 {
            font-size: 19px;
            margin-bottom: 3px;
        }

        .card-header p {
            color: #94a3b8;
            font-size: 12px;
        }

        /* ================================
           FORM
        ================================= */

        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 18px;
        }

        .form-group {
            margin-bottom: 18px;
        }

        .full-width {
            grid-column: 1 / -1;
        }

        .form-group label {
            display: block;

            font-size: 13px;
            font-weight: 700;

            color: #334155;

            margin-bottom: 8px;
        }

        .required {
            color: #ef4444;
        }

        .form-group input,
        .form-group textarea,
        .form-group select {

            width: 100%;

            border: 1px solid #dbe2ec;
            background: #fbfcfe;

            border-radius: 11px;

            padding: 13px 14px;

            color: #172033;

            font-family: inherit;
            font-size: 14px;

            outline: none;

            transition:
                border-color 0.2s,
                box-shadow 0.2s,
                background 0.2s;
        }

        .form-group input:focus,
        .form-group textarea:focus,
        .form-group select:focus {

            border-color: #60a5fa;

            background: white;

            box-shadow:
                0 0 0 4px rgba(37, 99, 235, 0.09);
        }

        .form-group textarea {
            min-height: 105px;
            resize: vertical;
        }

        .form-group input::placeholder,
        .form-group textarea::placeholder {
            color: #a8b2c1;
        }

        /* ================================
           PAYMENT
        ================================= */

        .payment-title {
            margin-top: 8px;
        }

        .payment-options {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 12px;
        }

        .payment-option {
            position: relative;
        }

        .payment-option input {
            position: absolute;
            opacity: 0;
            pointer-events: none;
        }

        .payment-option label {

            display: flex;
            align-items: center;
            gap: 11px;

            padding: 14px;

            border: 1px solid #dbe2ec;

            background: #fbfcfe;

            border-radius: 12px;

            cursor: pointer;

            transition: 0.2s;
        }

        .payment-option label:hover {
            border-color: #93c5fd;
            background: #f8fbff;
        }

        .payment-option input:checked + label {
            border-color: #2563eb;
            background: #eff6ff;

            box-shadow:
                0 0 0 2px rgba(37, 99, 235, 0.08);
        }

        .payment-icon {
            width: 35px;
            height: 35px;

            border-radius: 9px;

            display: flex;
            align-items: center;
            justify-content: center;

            background: white;

            font-size: 16px;

            border: 1px solid #e6ebf2;
        }

        .payment-text strong {
            display: block;
            font-size: 13px;
            margin-bottom: 2px;
        }

        .payment-text span {
            display: block;
            font-size: 11px;
            color: #94a3b8;
        }

        /* ================================
           ORDER SUMMARY
        ================================= */

        .summary-card {
            position: sticky;
            top: 98px;
        }

        .summary-items {
            margin-top: 5px;
        }

        .product-row {

            display: flex;
            align-items: center;
            justify-content: space-between;

            gap: 15px;

            padding: 15px 0;

            border-bottom: 1px solid #edf1f6;
        }

        .product-info {
            display: flex;
            align-items: center;
            gap: 12px;

            min-width: 0;
        }

        .product-image {

            width: 52px;
            height: 52px;

            border-radius: 12px;

            background:
                linear-gradient(
                    135deg,
                    #eef4ff,
                    #f5f3ff
                );

            display: flex;
            align-items: center;
            justify-content: center;

            flex-shrink: 0;

            overflow: hidden;
        }

        .product-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .product-placeholder {
            font-size: 20px;
        }

        .product-details {
            min-width: 0;
        }

        .product-name {

            font-size: 13px;
            font-weight: 700;

            color: #1e293b;

            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;

            max-width: 190px;
        }

        .product-quantity {

            margin-top: 5px;

            color: #94a3b8;
            font-size: 12px;
        }

        .product-price {

            font-size: 13px;
            font-weight: 700;

            color: #334155;

            white-space: nowrap;
        }

        /* ================================
           TOTAL
        ================================= */

        .summary-row {

            display: flex;
            justify-content: space-between;

            padding: 9px 0;

            color: #64748b;
            font-size: 14px;
        }

        .summary-row strong {
            color: #334155;
        }

        .grand-total {

            display: flex;
            justify-content: space-between;
            align-items: center;

            margin-top: 14px;
            padding-top: 18px;

            border-top: 1px solid #dfe5ee;
        }

        .grand-total span:first-child {

            color: #172033;

            font-size: 15px;
            font-weight: 700;
        }

        .grand-total span:last-child {

            color: #2563eb;

            font-size: 24px;
            font-weight: 800;
        }

        /* ================================
           SECURITY
        ================================= */

        .secure-box {

            display: flex;
            align-items: flex-start;
            gap: 10px;

            margin-top: 18px;
            padding: 13px;

            background: #f8fafc;

            border: 1px solid #edf1f5;

            border-radius: 11px;

            color: #64748b;

            font-size: 11px;
            line-height: 1.5;
        }

        .secure-icon {
            color: #16a34a;
            font-size: 15px;
            flex-shrink: 0;
        }

        /* ================================
           BUTTON
        ================================= */

        .place-order {

            width: 100%;

            margin-top: 20px;

            padding: 15px 18px;

            border: none;
            border-radius: 12px;

            background:
                linear-gradient(
                    135deg,
                    #2563eb,
                    #4f46e5
                );

            color: white;

            font-family: inherit;

            font-size: 15px;
            font-weight: 800;

            cursor: pointer;

            box-shadow:
                0 10px 24px rgba(37, 99, 235, 0.25);

            transition:
                transform 0.2s,
                box-shadow 0.2s;
        }

        .place-order:hover {

            transform: translateY(-2px);

            box-shadow:
                0 14px 30px rgba(37, 99, 235, 0.32);
        }

        .place-order:active {
            transform: translateY(0);
        }

        /* ================================
           BACK LINK
        ================================= */

        .back-link {

            display: inline-flex;
            align-items: center;
            gap: 7px;

            margin-top: 17px;

            color: #64748b;

            text-decoration: none;

            font-size: 13px;
            font-weight: 600;
        }

        .back-link:hover {
            color: #2563eb;
        }

        /* ================================
           RESPONSIVE
        ================================= */

        @media (max-width: 900px) {

            .checkout-grid {
                grid-template-columns: 1fr;
            }

            .summary-card {
                position: static;
            }
        }

        @media (max-width: 650px) {

            .navbar {
                padding: 0 20px;
            }

            .nav-links {
                gap: 12px;
            }

            .nav-links a:not(.checkout-label) {
                display: none;
            }

            .page {
                width: 94%;
                margin-top: 28px;
            }

            .page-heading h1 {
                font-size: 28px;
            }

            .card {
                padding: 20px;
                border-radius: 16px;
            }

            .form-grid {
                grid-template-columns: 1fr;
                gap: 0;
            }

            .full-width {
                grid-column: auto;
            }

            .payment-options {
                grid-template-columns: 1fr;
            }
        }

    </style>

</head>

<body>


<!-- ================================
     NAVBAR
================================ -->

<nav class="navbar">

    <a href="<%= contextPath %>/"
       class="brand">

        <div class="brand-logo">
            S
        </div>

        <span class="brand-name">
            ShopSphere
        </span>

    </a>


    <div class="nav-links">

        <a href="<%= contextPath %>/products">
            Products
        </a>

        <a href="<%= contextPath %>/cart">
            Cart
        </a>

        <a href="<%= contextPath %>/checkout"
           class="checkout-label">

            ✓ Checkout

        </a>

    </div>

</nav>


<!-- ================================
     MAIN
================================ -->

<main class="page">


    <div class="page-heading">

        <div class="eyebrow">
            Secure Checkout
        </div>

        <h1>
            Complete your order
        </h1>

        <p>
            Enter your delivery details and choose a payment method.
        </p>

    </div>


    <div class="checkout-grid">


        <!-- =================================
             LEFT — DELIVERY INFORMATION
        ================================== -->

        <section class="card">

            <div class="card-header">

                <div class="card-icon">
                    📍
                </div>

                <div>

                    <h2>
                        Delivery Information
                    </h2>

                    <p>
                        Where should we deliver your order?
                    </p>

                </div>

            </div>


            <form
                    action="<%= contextPath %>/place-order"
                    method="post"
                    id="checkoutForm">


                <div class="form-grid">


                    <!-- ADDRESS -->

                    <div class="form-group full-width">

                        <label for="address">
                            Delivery Address
                            <span class="required">*</span>
                        </label>

                        <textarea
                                id="address"
                                name="address"
                                placeholder="House / Flat, Street, Area"
                                required></textarea>

                    </div>


                    <!-- CITY -->

                    <div class="form-group">

                        <label for="city">
                            City
                            <span class="required">*</span>
                        </label>

                        <input
                                type="text"
                                id="city"
                                name="city"
                                placeholder="e.g. Jaipur"
                                maxlength="60"
                                required>

                    </div>


                    <!-- STATE -->

                    <div class="form-group">

                        <label for="state">
                            State
                            <span class="required">*</span>
                        </label>

                        <input
                                type="text"
                                id="state"
                                name="state"
                                placeholder="e.g. Rajasthan"
                                maxlength="60"
                                required>

                    </div>


                    <!-- PINCODE -->

                    <div class="form-group">

                        <label for="pincode">
                            Pincode
                            <span class="required">*</span>
                        </label>

                        <input
                                type="text"
                                id="pincode"
                                name="pincode"
                                placeholder="6-digit pincode"
                                inputmode="numeric"
                                maxlength="6"
                                pattern="[0-9]{6}"
                                title="Please enter a valid 6-digit pincode"
                                required>

                    </div>


                    <!-- PAYMENT -->

                    <div class="form-group full-width">

                        <label class="payment-title">
                            Payment Method
                            <span class="required">*</span>
                        </label>


                        <div class="payment-options">


                            <!-- COD -->

                            <div class="payment-option">

                                <input
                                        type="radio"
                                        id="cod"
                                        name="paymentMethod"
                                        value="COD"
                                        checked>

                                <label for="cod">

                                    <div class="payment-icon">
                                        💵
                                    </div>

                                    <div class="payment-text">

                                        <strong>
                                            Cash on Delivery
                                        </strong>

                                        <span>
                                            Pay when your order arrives
                                        </span>

                                    </div>

                                </label>

                            </div>


                            <!-- UPI -->

                            <div class="payment-option">

                                <input
                                        type="radio"
                                        id="upi"
                                        name="paymentMethod"
                                        value="UPI">

                                <label for="upi">

                                    <div class="payment-icon">
                                        📱
                                    </div>

                                    <div class="payment-text">

                                        <strong>
                                            UPI
                                        </strong>

                                        <span>
                                            Demo payment option
                                        </span>

                                    </div>

                                </label>

                            </div>


                            <!-- CARD -->

                            <div class="payment-option">

                                <input
                                        type="radio"
                                        id="card"
                                        name="paymentMethod"
                                        value="CARD">

                                <label for="card">

                                    <div class="payment-icon">
                                        💳
                                    </div>

                                    <div class="payment-text">

                                        <strong>
                                            Card
                                        </strong>

                                        <span>
                                            Demo payment option
                                        </span>

                                    </div>

                                </label>

                            </div>


                            <!-- NET BANKING -->

                            <div class="payment-option">

                                <input
                                        type="radio"
                                        id="netbanking"
                                        name="paymentMethod"
                                        value="NET_BANKING">

                                <label for="netbanking">

                                    <div class="payment-icon">
                                        🏦
                                    </div>

                                    <div class="payment-text">

                                        <strong>
                                            Net Banking
                                        </strong>

                                        <span>
                                            Demo payment option
                                        </span>

                                    </div>

                                </label>

                            </div>

                        </div>

                    </div>

                </div>


                <button
                        type="submit"
                        class="place-order">

                    Place Order →
                    
                </button>


            </form>


            <a
                    href="<%= contextPath %>/cart"
                    class="back-link">

                ← Back to Cart

            </a>


        </section>


        <!-- =================================
             RIGHT — ORDER SUMMARY
        ================================== -->

        <aside class="card summary-card">


            <div class="card-header">

                <div class="card-icon">
                    🛒
                </div>

                <div>

                    <h2>
                        Order Summary
                    </h2>

                    <p>
                        Review your items
                    </p>

                </div>

            </div>


            <div class="summary-items">


                <%

                    if (cart != null
                            && !cart.isEmpty()) {

                        for (CartItem item : cart) {

                            String image =
                                    item.getImage();

                %>


                <div class="product-row">


                    <div class="product-info">


                        <div class="product-image">

                            <%
                                if (image != null
                                        && !image.trim().isEmpty()) {
                            %>

                                <img
                                        src="<%= image %>"
                                        alt="<%= item.getProductName() %>">

                            <%
                                } else {
                            %>

                                <div class="product-placeholder">
                                    📦
                                </div>

                            <%
                                }
                            %>

                        </div>


                        <div class="product-details">

                            <div class="product-name">

                                <%= item.getProductName() %>

                            </div>

                            <div class="product-quantity">

                                Qty:
                                <%= item.getQuantity() %>

                            </div>

                        </div>


                    </div>


                    <div class="product-price">

                        ₹<%= String.format(
                                "%.2f",
                                item.getTotal()
                        ) %>

                    </div>


                </div>


                <%

                        }

                    } else {

                %>

                    <p style="
                        color:#94a3b8;
                        text-align:center;
                        padding:25px 0;
                        font-size:13px;
                    ">
                        Your cart is empty.
                    </p>

                <%

                    }

                %>


            </div>


            <!-- SUBTOTAL -->

            <div class="summary-row">

                <span>
                    Subtotal
                </span>

                <strong>
                    ₹<%= String.format(
                            "%.2f",
                            grandTotal
                    ) %>
                </strong>

            </div>


            <!-- DELIVERY -->

            <div class="summary-row">

                <span>
                    Delivery
                </span>

                <strong style="color:#16a34a;">
                    FREE
                </strong>

            </div>


            <!-- TOTAL -->

            <div class="grand-total">

                <span>
                    Total
                </span>

                <span>
                    ₹<%= String.format(
                            "%.2f",
                            grandTotal
                    ) %>
                </span>

            </div>


            <!-- SECURITY -->

            <div class="secure-box">

                <span class="secure-icon">
                    🔒
                </span>

                <span>
                    Your order is processed securely.
                    Payment details are handled as a
                    demo checkout flow for this project.
                </span>

            </div>


        </aside>


    </div>

</main>


<script>

    const form =
        document.getElementById("checkoutForm");

    const pincode =
        document.getElementById("pincode");


    form.addEventListener("submit", function(event) {

        const value =
            pincode.value.trim();

        if (!/^[0-9]{6}$/.test(value)) {

            event.preventDefault();

            alert(
                "Please enter a valid 6-digit pincode."
            );

            pincode.focus();
        }

    });

</script>


</body>

</html>