<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>ShopSphere - Order #${order.orderId}</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap"
          rel="stylesheet">


    <style>

        :root {

            --primary: #2563eb;
            --primary-dark: #1d4ed8;
            --purple: #4f46e5;

            --dark: #111827;
            --text: #334155;
            --muted: #64748b;

            --white: #ffffff;
            --border: #e2e8f0;
            --soft: #f8fafc;

            --green: #16a34a;
            --green-bg: #dcfce7;

            --yellow: #d97706;
            --yellow-bg: #fef3c7;

            --red: #dc2626;
            --red-bg: #fee2e2;

            --cyan: #0891b2;
            --cyan-bg: #cffafe;
        }


        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }


        body {

            min-height: 100vh;

            font-family:
                "Inter",
                "Segoe UI",
                Arial,
                sans-serif;

            color: var(--text);

            background:
                radial-gradient(
                    circle at 10% 10%,
                    rgba(37,99,235,.13),
                    transparent 30%
                ),

                radial-gradient(
                    circle at 90% 85%,
                    rgba(79,70,229,.11),
                    transparent 30%
                ),

                #f7f9fc;

            overflow-x: hidden;
        }


        /* =====================================================
           PAGE
           ===================================================== */

        .page {

            width: 100%;

            max-width: 1120px;

            margin: auto;

            padding:
                35px 22px 60px;
        }


        /* =====================================================
           TOP NAVIGATION
           ===================================================== */

        .top-nav {

            display: flex;

            justify-content: space-between;

            align-items: center;

            margin-bottom: 28px;
        }


        .brand {

            text-decoration: none;

            font-size: 23px;

            font-weight: 800;

            letter-spacing: -.7px;

            color: var(--dark);
        }


        .brand span {
            color: var(--primary);
        }


        .nav-actions {

            display: flex;

            align-items: center;

            gap: 10px;
        }


        .nav-button {

            display: inline-flex;

            align-items: center;

            gap: 7px;

            padding:
                9px 14px;

            border-radius: 10px;

            text-decoration: none;

            color: #475569;

            background: white;

            border:
                1px solid
                var(--border);

            font-size: 12px;

            font-weight: 700;

            transition: .2s;
        }


        .nav-button:hover {

            color: var(--primary);

            border-color:
                #bfdbfe;

            transform:
                translateY(-1px);
        }


        /* =====================================================
           ORDER HERO
           ===================================================== */

        .order-hero {

            background:
                linear-gradient(
                    135deg,
                    #ffffff,
                    #f8fbff
                );

            border:
                1px solid
                rgba(255,255,255,.9);

            border-radius: 24px;

            padding:
                28px 30px;

            margin-bottom: 22px;

            box-shadow:
                0 18px 55px
                rgba(15,23,42,.08);
        }


        .hero-top {

            display: flex;

            justify-content: space-between;

            align-items: flex-start;

            gap: 20px;
        }


        .hero-left {

            display: flex;

            align-items: center;

            gap: 16px;
        }


        .order-icon {

            width: 60px;

            height: 60px;

            display: grid;

            place-items: center;

            border-radius: 17px;

            font-size: 27px;

            background:
                linear-gradient(
                    135deg,
                    #2563eb,
                    #4f46e5
                );

            box-shadow:
                0 10px 25px
                rgba(37,99,235,.22);
        }


        .hero-left h1 {

            color: var(--dark);

            font-size: 28px;

            margin-bottom: 6px;

            letter-spacing: -.6px;
        }


        .hero-left p {

            color: var(--muted);

            font-size: 13px;
        }


        /* =====================================================
           STATUS BADGE
           ===================================================== */

        .status-badge {

            display: inline-flex;

            align-items: center;

            gap: 7px;

            padding:
                8px 14px;

            border-radius: 30px;

            font-size: 11px;

            font-weight: 800;

            text-transform: uppercase;

            letter-spacing: .4px;

            white-space: nowrap;
        }


        .status-badge::before {

            content: "";

            width: 7px;

            height: 7px;

            border-radius: 50%;

            background: currentColor;
        }


        .status-placed {

            color: #1d4ed8;

            background: #dbeafe;
        }


        .status-confirmed {

            color: #4338ca;

            background: #e0e7ff;
        }


        .status-processing {

            color: #b45309;

            background: #fef3c7;
        }


        .status-shipped {

            color: #0e7490;

            background: #cffafe;
        }


        .status-delivered {

            color: #15803d;

            background: #dcfce7;
        }


        .status-cancelled {

            color: #dc2626;

            background: #fee2e2;
        }


        /* =====================================================
           TRACKING TIMELINE
           ===================================================== */

        .tracking {

            margin-top: 28px;

            padding-top: 25px;

            border-top:
                1px solid
                #e5e7eb;
        }


        .tracking-title {

            font-size: 14px;

            font-weight: 800;

            color: var(--dark);

            margin-bottom: 20px;
        }


        .timeline {

            display: grid;

            grid-template-columns:
                repeat(4, 1fr);

            position: relative;
        }


        .timeline::before {

            content: "";

            position: absolute;

            top: 14px;

            left: 8%;

            right: 8%;

            height: 3px;

            background:
                #e5e7eb;

            z-index: 0;
        }


        .timeline-item {

            position: relative;

            z-index: 1;

            text-align: center;
        }


        .timeline-dot {

            width: 30px;

            height: 30px;

            margin:
                0 auto 10px;

            border-radius: 50%;

            display: grid;

            place-items: center;

            background: white;

            border:
                3px solid
                #cbd5e1;

            color: #94a3b8;

            font-size: 12px;

            font-weight: 800;
        }


        .timeline-item.active .timeline-dot {

            background:
                #2563eb;

            border-color:
                #2563eb;

            color: white;

            box-shadow:
                0 0 0 5px
                rgba(37,99,235,.10);
        }


        .timeline-item.completed .timeline-dot {

            background:
                #16a34a;

            border-color:
                #16a34a;

            color: white;
        }


        .timeline-label {

            font-size: 11px;

            color: #94a3b8;

            font-weight: 700;
        }


        .timeline-item.active .timeline-label,
        .timeline-item.completed .timeline-label {

            color: var(--dark);
        }


        /* =====================================================
           MAIN GRID
           ===================================================== */

        .main-grid {

            display: grid;

            grid-template-columns:
                minmax(0, 1.7fr)
                minmax(300px, 1fr);

            gap: 22px;

            align-items: start;
        }


        .card {

            background:
                rgba(255,255,255,.95);

            border:
                1px solid
                #e8edf3;

            border-radius: 20px;

            padding: 24px;

            margin-bottom: 22px;

            box-shadow:
                0 14px 40px
                rgba(15,23,42,.07);
        }


        .section-title {

            display: flex;

            align-items: center;

            gap: 10px;

            font-size: 17px;

            font-weight: 800;

            color: var(--dark);

            margin-bottom: 20px;
        }


        .section-icon {

            width: 36px;

            height: 36px;

            display: grid;

            place-items: center;

            border-radius: 10px;

            background: #eff6ff;

            font-size: 17px;
        }


        /* =====================================================
           PRODUCTS
           ===================================================== */

        .product-item {

            display: grid;

            grid-template-columns:
                64px
                minmax(0, 1fr)
                auto
                auto;

            align-items: center;

            gap: 15px;

            padding:
                16px 0;

            border-bottom:
                1px solid
                #edf2f7;
        }


        .product-item:first-of-type {
            padding-top: 0;
        }


        .product-item:last-child {

            border-bottom: none;

            padding-bottom: 0;
        }


        .product-image {

            width: 64px;

            height: 64px;

            display: grid;

            place-items: center;

            border-radius: 14px;

            background:
                linear-gradient(
                    135deg,
                    #eff6ff,
                    #eef2ff
                );

            font-size: 27px;
        }


        .product-name {

            color: var(--dark);

            font-size: 14px;

            font-weight: 800;

            margin-bottom: 5px;

            line-height: 1.4;
        }


        .product-price {

            color: var(--muted);

            font-size: 12px;
        }


        .quantity {

            min-width: 35px;

            padding: 6px 9px;

            border-radius: 8px;

            background:
                #f1f5f9;

            color: #475569;

            font-size: 12px;

            font-weight: 800;

            text-align: center;
        }


        .item-total {

            color: var(--dark);

            font-size: 14px;

            font-weight: 800;

            min-width: 85px;

            text-align: right;
        }


        /* =====================================================
           PRICE SUMMARY
           ===================================================== */

        .price-row {

            display: flex;

            justify-content: space-between;

            align-items: center;

            padding:
                10px 0;

            color: var(--muted);

            font-size: 13px;
        }


        .price-row strong {

            color: var(--dark);
        }


        .discount {

            color: #16a34a !important;
        }


        .grand-total {

            display: flex;

            justify-content: space-between;

            align-items: center;

            border-top:
                1px solid
                #e5e7eb;

            margin-top: 12px;

            padding-top: 17px;
        }


        .grand-total span:first-child {

            color: var(--dark);

            font-size: 15px;

            font-weight: 800;
        }


        .grand-total span:last-child {

            color: var(--primary);

            font-size: 24px;

            font-weight: 900;
        }


        /* =====================================================
           INFO GRID
           ===================================================== */

        .info-grid {

            display: grid;

            grid-template-columns:
                repeat(2, 1fr);

            gap: 12px;
        }


        .info-box {

            padding: 14px;

            border-radius: 13px;

            background:
                #f8fafc;

            border:
                1px solid
                #edf2f7;
        }


        .info-label {

            color: #94a3b8;

            font-size: 10px;

            font-weight: 800;

            text-transform: uppercase;

            letter-spacing: .5px;

            margin-bottom: 6px;
        }


        .info-value {

            color: var(--dark);

            font-size: 13px;

            font-weight: 700;

            word-break: break-word;
        }


        /* =====================================================
           ADDRESS
           ===================================================== */

        .address-box {

            padding: 17px;

            border-radius: 14px;

            background:
                linear-gradient(
                    135deg,
                    #f8fafc,
                    #f1f5f9
                );

            border:
                1px solid
                #e5e7eb;

            line-height: 1.75;

            font-size: 13px;

            color: #475569;
        }


        .address-type {

            display: inline-flex;

            margin-bottom: 8px;

            padding: 5px 9px;

            border-radius: 7px;

            color: #1d4ed8;

            background: #dbeafe;

            font-size: 10px;

            font-weight: 800;

            text-transform: uppercase;
        }


        .address-box strong {

            color: var(--dark);
        }


        /* =====================================================
           PAYMENT
           ===================================================== */

        .payment-box {

            display: flex;

            align-items: center;

            justify-content: space-between;

            gap: 15px;

            padding: 15px;

            border-radius: 13px;

            background: #f8fafc;

            border:
                1px solid
                #edf2f7;
        }


        .payment-left {

            display: flex;

            align-items: center;

            gap: 11px;
        }


        .payment-icon {

            width: 38px;

            height: 38px;

            display: grid;

            place-items: center;

            border-radius: 10px;

            background:
                #eff6ff;

            font-size: 17px;
        }


        .payment-title {

            font-size: 12px;

            font-weight: 800;

            color: var(--dark);
        }


        .payment-method {

            color: var(--muted);

            font-size: 11px;

            margin-top: 3px;
        }


        .payment-status {

            padding: 6px 10px;

            border-radius: 20px;

            background:
                #fef3c7;

            color:
                #b45309;

            font-size: 10px;

            font-weight: 800;

            text-transform: uppercase;
        }


        /* =====================================================
           ACTIONS
           ===================================================== */

        .actions {

            display: flex;

            gap: 10px;

            flex-wrap: wrap;

            margin-top: 3px;
        }


        .button {

            flex: 1;

            min-width: 170px;

            display: inline-flex;

            justify-content: center;

            align-items: center;

            gap: 8px;

            padding:
                12px 16px;

            border-radius: 11px;

            text-decoration: none;

            font-size: 12px;

            font-weight: 800;

            transition: .2s;
        }


        .button-primary {

            color: white;

            background:
                linear-gradient(
                    135deg,
                    var(--primary),
                    var(--purple)
                );

            box-shadow:
                0 8px 20px
                rgba(37,99,235,.18);
        }


        .button-primary:hover {

            transform:
                translateY(-2px);

            box-shadow:
                0 12px 26px
                rgba(37,99,235,.25);
        }


        .button-secondary {

            color: #475569;

            background: white;

            border:
                1px solid
                var(--border);
        }


        .button-secondary:hover {

            color: var(--primary);

            border-color:
                #bfdbfe;

            transform:
                translateY(-2px);
        }


        /* =====================================================
           RESPONSIVE
           ===================================================== */

        @media (max-width: 850px) {

            .main-grid {

                grid-template-columns: 1fr;
            }

            .hero-top {

                flex-direction: column;
            }

            .status-badge {

                align-self: flex-start;
            }
        }


        @media (max-width: 650px) {

            .page {

                padding:
                    20px 14px 45px;
            }


            .top-nav {

                margin-bottom: 20px;
            }


            .nav-button:first-child {

                display: none;
            }


            .order-hero {

                padding: 22px 18px;

                border-radius: 18px;
            }


            .hero-left h1 {

                font-size: 23px;
            }


            .timeline {

                grid-template-columns:
                    repeat(4, 1fr);
            }


            .timeline::before {

                left: 5%;

                right: 5%;
            }


            .timeline-label {

                font-size: 9px;
            }


            .card {

                padding: 19px;

                border-radius: 17px;
            }


            .product-item {

                grid-template-columns:
                    52px
                    minmax(0, 1fr);

                gap: 12px;
            }


            .product-image {

                width: 52px;

                height: 52px;
            }


            .quantity {

                grid-column: 2;

                width: fit-content;
            }


            .item-total {

                grid-column: 2;

                text-align: left;

                min-width: auto;
            }


            .info-grid {

                grid-template-columns: 1fr;
            }


            .payment-box {

                align-items: flex-start;

                flex-direction: column;
            }


            .payment-status {

                margin-left: 49px;
            }


            .button {

                width: 100%;

                flex: none;
            }
        }


        @media (max-width: 430px) {

            .hero-left {

                align-items: flex-start;
            }


            .order-icon {

                width: 50px;

                height: 50px;

                font-size: 22px;
            }


            .timeline-label {

                display: none;
            }


            .timeline-dot {

                margin-bottom: 0;
            }
        }


        @media (prefers-reduced-motion: reduce) {

            * {

                scroll-behavior: auto !important;
                transition: none !important;
            }
        }

    </style>

</head>


<body>


<div class="page">


    <!-- =====================================================
         TOP NAVIGATION
         ===================================================== -->

    <div class="top-nav">

        <a
            class="brand"
            href="${pageContext.request.contextPath}/">

            Shop<span>Sphere</span>

        </a>


        <div class="nav-actions">

            <a
                class="nav-button"
                href="${pageContext.request.contextPath}/products">

                🛍️ Products

            </a>


            <a
                class="nav-button"
                href="${pageContext.request.contextPath}/orders">

                ← My Orders

            </a>

        </div>

    </div>


    <!-- =====================================================
         ORDER HERO
         ===================================================== -->

    <div class="order-hero">

        <div class="hero-top">


            <div class="hero-left">

                <div class="order-icon">
                    📦
                </div>


                <div>

                    <h1>
                        Order #${order.orderId}
                    </h1>

                    <p>
                        Placed on ${order.createdAt}
                    </p>

                </div>

            </div>


            <c:set
                var="orderStatus"
                value="${order.orderStatus}" />

            <c:set
                var="statusClass"
                value="status-placed" />


            <c:choose>

                <c:when test="${orderStatus == 'CONFIRMED'}">
                    <c:set
                        var="statusClass"
                        value="status-confirmed" />
                </c:when>

                <c:when test="${orderStatus == 'PROCESSING'}">
                    <c:set
                        var="statusClass"
                        value="status-processing" />
                </c:when>

                <c:when test="${orderStatus == 'SHIPPED'}">
                    <c:set
                        var="statusClass"
                        value="status-shipped" />
                </c:when>

                <c:when test="${orderStatus == 'DELIVERED'}">
                    <c:set
                        var="statusClass"
                        value="status-delivered" />
                </c:when>

                <c:when test="${orderStatus == 'CANCELLED'}">
                    <c:set
                        var="statusClass"
                        value="status-cancelled" />
                </c:when>

            </c:choose>


            <span class="status-badge ${statusClass}">

                ${orderStatus}

            </span>


        </div>


        <!-- =================================================
             ORDER TRACKING
             ================================================= -->

        <c:if test="${orderStatus != 'CANCELLED'}">

            <div class="tracking">

                <div class="tracking-title">
                    Order Progress
                </div>


                <div class="timeline">


                    <div class="timeline-item completed">

                        <div class="timeline-dot">
                            ✓
                        </div>

                        <div class="timeline-label">
                            Placed
                        </div>

                    </div>


                    <div class="timeline-item
                        ${orderStatus == 'CONFIRMED' ||
                          orderStatus == 'PROCESSING' ||
                          orderStatus == 'SHIPPED' ||
                          orderStatus == 'DELIVERED'
                          ? 'completed' : ''}">

                        <div class="timeline-dot">

                            <c:choose>

                                <c:when test="${orderStatus == 'CONFIRMED' ||
                                               orderStatus == 'PROCESSING' ||
                                               orderStatus == 'SHIPPED' ||
                                               orderStatus == 'DELIVERED'}">
                                    ✓
                                </c:when>

                                <c:otherwise>
                                    2
                                </c:otherwise>

                            </c:choose>

                        </div>

                        <div class="timeline-label">
                            Confirmed
                        </div>

                    </div>


                    <div class="timeline-item
                        ${orderStatus == 'PROCESSING' ||
                          orderStatus == 'SHIPPED' ||
                          orderStatus == 'DELIVERED'
                          ? 'completed' : ''}">

                        <div class="timeline-dot">

                            <c:choose>

                                <c:when test="${orderStatus == 'PROCESSING' ||
                                               orderStatus == 'SHIPPED' ||
                                               orderStatus == 'DELIVERED'}">
                                    ✓
                                </c:when>

                                <c:otherwise>
                                    3
                                </c:otherwise>

                            </c:choose>

                        </div>

                        <div class="timeline-label">
                            Processing
                        </div>

                    </div>


                    <div class="timeline-item
                        ${orderStatus == 'DELIVERED'
                          ? 'completed' : ''}">

                        <div class="timeline-dot">

                            <c:choose>

                                <c:when test="${orderStatus == 'DELIVERED'}">
                                    ✓
                                </c:when>

                                <c:otherwise>
                                    4
                                </c:otherwise>

                            </c:choose>

                        </div>

                        <div class="timeline-label">
                            Delivered
                        </div>

                    </div>


                </div>

            </div>

        </c:if>


        <c:if test="${orderStatus == 'CANCELLED'}">

            <div class="tracking">

                <div class="tracking-title">
                    Order Status
                </div>

                <div
                    style="
                        padding:15px;
                        border-radius:12px;
                        background:#fee2e2;
                        color:#b91c1c;
                        font-size:13px;
                        font-weight:700;
                    ">

                    ✕ This order has been cancelled.

                </div>

            </div>

        </c:if>

    </div>


    <!-- =====================================================
         MAIN CONTENT
         ===================================================== -->

    <div class="main-grid">


        <!-- =================================================
             LEFT COLUMN
             ================================================= -->

        <div>


            <!-- PRODUCTS -->

            <div class="card">

                <div class="section-title">

                    <div class="section-icon">
                        🛒
                    </div>

                    Ordered Products

                </div>


                <c:forEach
                    var="item"
                    items="${orderItems}">


                    <div class="product-item">


                        <div class="product-image">
                            📦
                        </div>


                        <div>

                            <div class="product-name">

                                ${item.productName}

                            </div>

                            <div class="product-price">

                                ₹${item.price} per item

                            </div>

                        </div>


                        <div class="quantity">

                            × ${item.quantity}

                        </div>


                        <div class="item-total">

                            ₹${item.total}

                        </div>


                    </div>


                </c:forEach>


                <!-- PRICE SUMMARY -->

                <div style="margin-top:22px;">

                    <div class="price-row">

                        <span>
                            Items Total
                        </span>

                        <strong>
                            ₹${order.totalAmount}
                        </strong>

                    </div>


                    <div class="price-row">

                        <span>
                            Discount
                        </span>

                        <strong class="discount">

                            - ₹${order.discount}

                        </strong>

                    </div>


                    <div class="price-row">

                        <span>
                            Delivery
                        </span>

                        <strong class="discount">
                            FREE
                        </strong>

                    </div>


                    <div class="grand-total">

                        <span>
                            Order Total
                        </span>

                        <span>
                            ₹${order.totalAmount}
                        </span>

                    </div>

                </div>

            </div>


            <!-- DELIVERY ADDRESS -->

            <div class="card">

                <div class="section-title">

                    <div class="section-icon">
                        📍
                    </div>

                    Delivery Address

                </div>


                <c:if test="${not empty address}">

                    <div class="address-box">

                        <span class="address-type">

                            ${address.addressType}

                        </span>

                        <br>


                        <strong>
                            Delivery Address
                        </strong>

                        <br>

                        ${address.addressLine}

                        <br>

                        ${address.city},
                        ${address.state}

                        <br>

                        PIN Code:
                        <strong>
                            ${address.pincode}
                        </strong>

                    </div>

                </c:if>


                <c:if test="${empty address}">

                    <div class="address-box">

                        Delivery address is not available.

                    </div>

                </c:if>

            </div>

        </div>


        <!-- =================================================
             RIGHT COLUMN
             ================================================= -->

        <div>


            <!-- ORDER INFORMATION -->

            <div class="card">

                <div class="section-title">

                    <div class="section-icon">
                        ℹ️
                    </div>

                    Order Information

                </div>


                <div class="info-grid">


                    <div class="info-box">

                        <div class="info-label">
                            Order ID
                        </div>

                        <div class="info-value">
                            #${order.orderId}
                        </div>

                    </div>


                    <div class="info-box">

                        <div class="info-label">
                            Address ID
                        </div>

                        <div class="info-value">
                            #${order.addressId}
                        </div>

                    </div>


                    <div class="info-box">

                        <div class="info-label">
                            Order Status
                        </div>

                        <div class="info-value">
                            ${order.orderStatus}
                        </div>

                    </div>


                    <div class="info-box">

                        <div class="info-label">
                            Payment Status
                        </div>

                        <div class="info-value">
                            ${order.paymentStatus}
                        </div>

                    </div>

                </div>

            </div>


            <!-- PAYMENT -->

            <div class="card">

                <div class="section-title">

                    <div class="section-icon">
                        💳
                    </div>

                    Payment

                </div>


                <div class="payment-box">


                    <div class="payment-left">

                        <div class="payment-icon">
                            💳
                        </div>


                        <div>

                            <div class="payment-title">
                                Payment Method
                            </div>

                            <div class="payment-method">

                                ${order.paymentMethod}

                            </div>

                        </div>

                    </div>


                    <span class="payment-status">

                        ${order.paymentStatus}

                    </span>


                </div>

            </div>


            <!-- ACTIONS -->

            <div class="card">

                <div class="section-title">

                    <div class="section-icon">
                        ⚡
                    </div>

                    Quick Actions

                </div>


                <div class="actions">


                    <a
                        class="button button-secondary"
                        href="${pageContext.request.contextPath}/orders">

                        ← My Orders

                    </a>


                    <a
                        class="button button-primary"
                        href="${pageContext.request.contextPath}/products">

                        🛍️ Continue Shopping

                    </a>


                </div>

            </div>

        </div>


    </div>

</div>


</body>

</html>