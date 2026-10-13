<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>ShopSphere - My Orders</title>


    <style>

        :root {

            --primary: #2563eb;
            --primary-dark: #1d4ed8;
            --purple: #4f46e5;

            --dark: #111827;
            --text: #1f2937;
            --muted: #64748b;

            --white: #ffffff;

            --border: #e2e8f0;

            --green: #16a34a;
            --green-bg: #dcfce7;

            --orange: #ea580c;
            --orange-bg: #ffedd5;

            --blue-bg: #dbeafe;
        }


        * {

            box-sizing: border-box;

            margin: 0;

            padding: 0;
        }


        /* =====================================================
           BODY
           ===================================================== */

        body {

            min-height: 100vh;

            font-family:
                Inter,
                "Segoe UI",
                Arial,
                sans-serif;

            color: var(--text);

            background:

                linear-gradient(
                    -45deg,
                    #eef5ff,
                    #f4f1ff,
                    #eaf3ff,
                    #f8faff,
                    #edf0ff
                );

            background-size: 400% 400%;

            animation:
                backgroundMove 15s ease infinite;

            position: relative;

            overflow-x: hidden;
        }


        @keyframes backgroundMove {

            0% {
                background-position: 0% 50%;
            }

            25% {
                background-position: 50% 100%;
            }

            50% {
                background-position: 100% 50%;
            }

            75% {
                background-position: 50% 0%;
            }

            100% {
                background-position: 0% 50%;
            }
        }


        /* =====================================================
           BACKGROUND GLOW
           ===================================================== */

        body::before {

            content: "";

            position: fixed;

            width: 420px;
            height: 420px;

            border-radius: 50%;

            background:

                radial-gradient(
                    circle,
                    rgba(37,99,235,.18),
                    rgba(37,99,235,.05) 40%,
                    transparent 70%
                );

            top: -160px;

            right: -100px;

            filter: blur(5px);

            pointer-events: none;

            animation:
                glowOne 10s ease-in-out infinite alternate;

            z-index: 0;
        }


        body::after {

            content: "";

            position: fixed;

            width: 380px;
            height: 380px;

            border-radius: 50%;

            background:

                radial-gradient(
                    circle,
                    rgba(79,70,229,.16),
                    rgba(79,70,229,.05) 40%,
                    transparent 70%
                );

            bottom: -150px;

            left: -100px;

            filter: blur(5px);

            pointer-events: none;

            animation:
                glowTwo 12s ease-in-out infinite alternate;

            z-index: 0;
        }


        @keyframes glowOne {

            0% {
                transform:
                    translate(0,0)
                    scale(1);
            }

            100% {
                transform:
                    translate(-80px,120px)
                    scale(1.15);
            }
        }


        @keyframes glowTwo {

            0% {
                transform:
                    translate(0,0)
                    scale(1);
            }

            100% {
                transform:
                    translate(120px,-80px)
                    scale(1.15);
            }
        }


        /* =====================================================
           PARTICLES
           ===================================================== */

        .particles {

            position: fixed;

            inset: 0;

            overflow: hidden;

            pointer-events: none;

            z-index: 0;
        }


        .particles span {

            position: absolute;

            width: 5px;

            height: 5px;

            border-radius: 50%;

            background:
                rgba(37,99,235,.22);

            box-shadow:
                0 0 12px
                rgba(37,99,235,.30);

            animation:
                particleMove
                linear infinite;
        }


        .particles span:nth-child(1) {

            left: 8%;
            bottom: -20px;

            animation-duration: 14s;
        }


        .particles span:nth-child(2) {

            left: 20%;
            bottom: -20px;

            animation-duration: 18s;

            animation-delay: 3s;
        }


        .particles span:nth-child(3) {

            left: 35%;
            bottom: -20px;

            animation-duration: 15s;

            animation-delay: 1s;
        }


        .particles span:nth-child(4) {

            left: 50%;
            bottom: -20px;

            animation-duration: 20s;

            animation-delay: 5s;
        }


        .particles span:nth-child(5) {

            left: 68%;
            bottom: -20px;

            animation-duration: 16s;

            animation-delay: 2s;
        }


        .particles span:nth-child(6) {

            left: 82%;
            bottom: -20px;

            animation-duration: 19s;

            animation-delay: 6s;
        }


        @keyframes particleMove {

            0% {

                transform:
                    translateY(0)
                    translateX(0)
                    scale(.5);

                opacity: 0;
            }

            15% {
                opacity: .8;
            }

            50% {

                transform:
                    translateY(-50vh)
                    translateX(40px)
                    scale(1);

                opacity: .6;
            }

            100% {

                transform:
                    translateY(-110vh)
                    translateX(-40px)
                    scale(.3);

                opacity: 0;
            }
        }


        /* =====================================================
           MAIN CONTAINER
           ===================================================== */

        .container {

            width: 100%;

            max-width: 1120px;

            margin: auto;

            padding:
                35px 25px 60px;

            position: relative;

            z-index: 2;
        }


        /* =====================================================
           PAGE HEADER
           ===================================================== */

        .page-header {

            display: flex;

            justify-content: space-between;

            align-items: center;

            margin-bottom: 30px;

            padding: 25px 30px;

            border-radius: 22px;

            background:
                rgba(255,255,255,.82);

            border:
                1px solid
                rgba(255,255,255,.75);

            backdrop-filter:
                blur(16px);

            box-shadow:
                0 15px 40px
                rgba(31,52,92,.10);
        }


        .header-left {

            display: flex;

            align-items: center;

            gap: 15px;
        }


        .header-icon {

            width: 58px;

            height: 58px;

            border-radius: 16px;

            display: grid;

            place-items: center;

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


        .page-header h1 {

            color: var(--dark);

            font-size: 30px;

            letter-spacing: -.7px;

            margin-bottom: 4px;
        }


        .page-header p {

            color: var(--muted);

            font-size: 13px;
        }


        .shopping-button {

            display: inline-flex;

            align-items: center;

            gap: 8px;

            padding:
                11px 17px;

            border-radius: 11px;

            background:

                linear-gradient(
                    135deg,
                    var(--primary),
                    var(--purple)
                );

            color: white;

            text-decoration: none;

            font-size: 13px;

            font-weight: 700;

            box-shadow:
                0 8px 20px
                rgba(37,99,235,.20);

            transition:
                transform .2s,
                box-shadow .2s;
        }


        .shopping-button:hover {

            transform:
                translateY(-2px);

            box-shadow:
                0 12px 25px
                rgba(37,99,235,.28);
        }


        /* =====================================================
           ORDER CARD
           ===================================================== */

        .order-card {

            background:
                rgba(255,255,255,.90);

            border:
                1px solid
                rgba(255,255,255,.80);

            border-radius: 22px;

            padding: 24px;

            margin-bottom: 20px;

            box-shadow:
                0 15px 45px
                rgba(31,52,92,.09);

            backdrop-filter:
                blur(14px);

            transition:
                transform .25s ease,
                box-shadow .25s ease;
        }


        .order-card:hover {

            transform:
                translateY(-4px);

            box-shadow:
                0 22px 55px
                rgba(31,52,92,.14);
        }


        /* =====================================================
           ORDER HEADER
           ===================================================== */

        .order-header {

            display: flex;

            justify-content: space-between;

            align-items: center;

            padding-bottom: 18px;

            border-bottom:
                1px solid
                #edf2f7;

            margin-bottom: 20px;
        }


        .order-title {

            display: flex;

            align-items: center;

            gap: 12px;
        }


        .order-icon {

            width: 44px;

            height: 44px;

            border-radius: 13px;

            display: grid;

            place-items: center;

            background:
                #eff6ff;

            color:
                var(--primary);

            font-size: 20px;
        }


        .order-id {

            color: var(--dark);

            font-size: 17px;

            font-weight: 800;
        }


        .order-date {

            color: var(--muted);

            font-size: 12px;

            margin-top: 4px;
        }


        /* =====================================================
           ORDER STATUS TOP
           ===================================================== */

        .top-status {
    display: inline-flex;
    align-items: center;
    gap: 7px;

    padding: 7px 13px;

    border-radius: 20px;

    font-size: 11px;
    font-weight: 800;

    text-transform: uppercase;
    letter-spacing: .4px;

    white-space: nowrap;
}

.top-status::before {
    content: "";

    width: 7px;
    height: 7px;

    border-radius: 50%;

    background: currentColor;
}


/* PLACED */
.status-placed {
    background: #dbeafe;
    color: #1d4ed8;
}


/* CONFIRMED */
.status-confirmed {
    background: #e0e7ff;
    color: #4338ca;
}


/* PROCESSING */
.status-processing {
    background: #fef3c7;
    color: #b45309;
}


/* SHIPPED */
.status-shipped {
    background: #cffafe;
    color: #0e7490;
}


/* DELIVERED */
.status-delivered {
    background: #dcfce7;
    color: #15803d;
}


/* CANCELLED */
.status-cancelled {
    background: #fee2e2;
    color: #dc2626;
}

        /* =====================================================
           DETAILS GRID
           ===================================================== */

        .details {

            display: grid;

            grid-template-columns:
                repeat(3, 1fr);

            gap: 14px;

            margin-bottom: 20px;
        }


        .detail-box {

            padding: 16px;

            border-radius: 14px;

            background:
                #f8fafc;

            border:
                1px solid
                #edf2f7;

            transition:
                background .2s,
                transform .2s;
        }


        .detail-box:hover {

            background:
                #f1f5ff;

            transform:
                translateY(-2px);
        }


        .label {

            font-size: 11px;

            color:
                #94a3b8;

            font-weight: 700;

            text-transform:
                uppercase;

            letter-spacing: .4px;

            margin-bottom: 7px;
        }


        .value {

            color:
                var(--dark);

            font-size: 14px;

            font-weight: 800;

            word-break: break-word;
        }


        /* =====================================================
           STATUS BADGE
           ===================================================== */

        .status {

            display: inline-flex;

            align-items: center;

            gap: 6px;

            padding:
                6px 11px;

            border-radius: 20px;

            background:
                var(--green-bg);

            color:
                #166534;

            font-size: 11px;

            font-weight: 800;

            text-transform:
                uppercase;
        }


        .status::before {

            content: "";

            width: 6px;

            height: 6px;

            border-radius: 50%;

            background:
                #16a34a;

            box-shadow:
                0 0 0 3px
                rgba(22,163,74,.12);
        }


        /* =====================================================
           ORDER FOOTER
           ===================================================== */

        .order-footer {

            display: flex;

            align-items: center;

            justify-content: space-between;

            gap: 15px;

            padding-top: 18px;

            border-top:
                1px solid
                #edf2f7;
        }


        .total-area {

            display: flex;

            align-items: center;

            gap: 10px;
        }


        .total-label {

            color:
                var(--muted);

            font-size: 12px;
        }


        .total-value {

            color:
                var(--dark);

            font-size: 21px;

            font-weight: 900;
        }


        .details-button {

            display: inline-flex;

            align-items: center;

            gap: 8px;

            padding:
                11px 17px;

            border-radius: 11px;

            background:
                linear-gradient(
                    135deg,
                    var(--primary),
                    var(--purple)
                );

            color: white;

            text-decoration: none;

            font-size: 12px;

            font-weight: 800;

            box-shadow:
                0 8px 18px
                rgba(37,99,235,.18);

            transition:
                transform .2s,
                box-shadow .2s;
        }


        .details-button:hover {

            transform:
                translateY(-2px);

            box-shadow:
                0 12px 25px
                rgba(37,99,235,.28);
        }


        /* =====================================================
           EMPTY ORDERS
           ===================================================== */

        .empty {

            padding:
                70px 30px;

            text-align: center;

            border-radius: 24px;

            background:
                rgba(255,255,255,.88);

            border:
                1px solid
                rgba(255,255,255,.80);

            box-shadow:
                0 20px 50px
                rgba(31,52,92,.10);

            backdrop-filter:
                blur(15px);
        }


        .empty-icon {

            width: 90px;

            height: 90px;

            margin:
                0 auto 20px;

            display: grid;

            place-items: center;

            border-radius: 28px;

            background:
                #eff6ff;

            font-size: 42px;

            animation:
                emptyFloat 3s
                ease-in-out
                infinite;
        }


        @keyframes emptyFloat {

            0%,
            100% {
                transform:
                    translateY(0);
            }

            50% {
                transform:
                    translateY(-8px);
            }
        }


        .empty h2 {

            color:
                var(--dark);

            font-size: 24px;

            margin-bottom: 8px;
        }


        .empty p {

            color:
                var(--muted);

            font-size: 13px;

            margin-bottom: 25px;
        }


        .empty-button {

            display: inline-flex;

            align-items: center;

            gap: 8px;

            padding:
                12px 20px;

            border-radius: 11px;

            background:

                linear-gradient(
                    135deg,
                    var(--primary),
                    var(--purple)
                );

            color: white;

            text-decoration: none;

            font-size: 13px;

            font-weight: 800;

            box-shadow:
                0 10px 22px
                rgba(37,99,235,.20);
        }


        /* =====================================================
           BOTTOM BUTTON
           ===================================================== */

        .bottom-action {

            text-align: center;

            margin-top: 28px;
        }


        .bottom-action a {

            display: inline-flex;

            align-items: center;

            gap: 8px;

            padding:
                11px 18px;

            border-radius: 11px;

            background:
                rgba(255,255,255,.85);

            color:
                var(--primary);

            border:
                1px solid
                #dbeafe;

            text-decoration: none;

            font-size: 12px;

            font-weight: 800;

            box-shadow:
                0 8px 20px
                rgba(31,52,92,.07);

            transition:
                transform .2s,
                background .2s;
        }


        .bottom-action a:hover {

            transform:
                translateY(-2px);

            background:
                white;
        }


        /* =====================================================
           RESPONSIVE
           ===================================================== */

        @media (max-width: 850px) {

            .details {

                grid-template-columns:
                    repeat(2, 1fr);
            }


            .page-header {

                align-items:
                    flex-start;

                gap: 20px;
            }
        }


        @media (max-width: 650px) {

            .container {

                padding:
                    20px 14px 45px;
            }


            .page-header {

                flex-direction:
                    column;
            }


            .shopping-button {

                width: 100%;

                justify-content:
                    center;
            }


            .details {

                grid-template-columns:
                    1fr;
            }


            .order-header {

                align-items:
                    flex-start;

                gap: 12px;
            }


            .order-footer {

                flex-direction:
                    column;

                align-items:
                    stretch;
            }


            .details-button {

                justify-content:
                    center;
            }


            .total-area {

                justify-content:
                    center;
            }
        }


        @media (max-width: 450px) {

            .page-header {

                padding: 20px;
            }


            .page-header h1 {

                font-size: 25px;
            }


            .order-card {

                padding: 18px;
            }


            .order-header {

                flex-direction:
                    column;
            }


            .top-status {

                align-self:
                    flex-start;
            }


            .order-title {

                align-items:
                    flex-start;
            }


            .empty {

                padding:
                    55px 20px;
            }
        }

        .payment-paid,
.payment-pending,
.payment-failed {
    display: inline-flex;
    align-items: center;
    gap: 5px;

    padding: 6px 10px;

    border-radius: 20px;

    font-size: 11px;
    font-weight: 800;
}

.payment-paid {
    color: #15803d;
    background: #dcfce7;
}

.payment-pending {
    color: #b45309;
    background: #fef3c7;
}

.payment-failed {
    color: #dc2626;
    background: #fee2e2;
}


        @media (prefers-reduced-motion: reduce) {

            *,
            *::before,
            *::after {

                animation-duration:
                    .01ms !important;

                animation-iteration-count:
                    1 !important;
            }
        }

    </style>

</head>


<body>


<!-- =====================================================
     BACKGROUND PARTICLES
     ===================================================== -->

<div class="particles">

    <span></span>
    <span></span>
    <span></span>
    <span></span>
    <span></span>
    <span></span>

</div>


<!-- =====================================================
     EXISTING HEADER
     ===================================================== -->

<jsp:include
    page="/WEB-INF/jsp/fragments/header.jspf"
/>


<!-- =====================================================
     MAIN CONTENT
     ===================================================== -->

<div class="container">


    <!-- =================================================
         PAGE HEADER
         ================================================= -->

    <div class="page-header">


        <div class="header-left">

            <div class="header-icon">

                📦

            </div>


            <div>

                <h1>
                    My Orders
                </h1>

                <p>
                    Track and manage all your ShopSphere orders
                </p>

            </div>

        </div>


        <a
            class="shopping-button"
            href="${pageContext.request.contextPath}/products">

            🛍️
            Continue Shopping

        </a>

    </div>


    <!-- =================================================
         NO ORDERS
         ================================================= -->

    <c:if test="${empty orders}">

        <div class="empty">


            <div class="empty-icon">

                📦

            </div>


            <h2>
                No Orders Yet
            </h2>


            <p>

                You haven't placed any orders yet.
                Start shopping and your orders will appear here.

            </p>


            <a
                class="empty-button"
                href="${pageContext.request.contextPath}/products">

                🛍️
                Start Shopping

            </a>


        </div>

    </c:if>


    <!-- =================================================
         ORDERS LIST
         ================================================= -->

    <c:forEach
        var="order"
        items="${orders}">


        <div class="order-card">


            <!-- ORDER HEADER -->

            <div class="order-header">


                <div class="order-title">


                    <div class="order-icon">

                        📦

                    </div>


                    <div>

                        <div class="order-id">

                            Order #${order.orderId}

                        </div>


                        <div class="order-date">

                            Placed on
                            ${order.createdAt}

                        </div>

                    </div>

                </div>


               <c:set var="orderStatus"
       value="${order.orderStatus}" />

<c:set var="statusClass"
       value="status-placed" />

<c:choose>

    <c:when test="${orderStatus == 'CONFIRMED'}">
        <c:set var="statusClass"
               value="status-confirmed" />
    </c:when>

    <c:when test="${orderStatus == 'PROCESSING'}">
        <c:set var="statusClass"
               value="status-processing" />
    </c:when>

    <c:when test="${orderStatus == 'SHIPPED'}">
        <c:set var="statusClass"
               value="status-shipped" />
    </c:when>

    <c:when test="${orderStatus == 'DELIVERED'}">
        <c:set var="statusClass"
               value="status-delivered" />
    </c:when>

    <c:when test="${orderStatus == 'CANCELLED'}">
        <c:set var="statusClass"
               value="status-cancelled" />
    </c:when>

</c:choose>


<span class="top-status ${statusClass}">

    ${orderStatus}

</span>


            </div>


            <!-- =================================================
                 ORDER DETAILS
                 ================================================= -->

            <div class="details">


                <!-- TOTAL -->

                <div class="detail-box">

                    <div class="label">
                        Total Amount
                    </div>

                    <div class="value">

                        ₹${order.totalAmount}

                    </div>

                </div>


                <!-- PAYMENT -->

                <div class="detail-box">

                    <div class="label">
                        Payment Method
                    </div>

                    <div class="value">

                        ${order.paymentMethod}

                    </div>

                </div>


                <!-- PAYMENT STATUS -->

                <div class="detail-box">

                    <div class="label">
                        Payment Status
                    </div>

                    <div class="value">

    <c:choose>

        <c:when test="${order.paymentStatus == 'PAID'}">

            <span class="payment-paid">
                ✓ Paid
            </span>

        </c:when>

        <c:when test="${order.paymentStatus == 'PENDING'}">

            <span class="payment-pending">
                ◷ Pending
            </span>

        </c:when>

        <c:when test="${order.paymentStatus == 'FAILED'}">

            <span class="payment-failed">
                ✕ Failed
            </span>

        </c:when>

        <c:otherwise>

            ${order.paymentStatus}

        </c:otherwise>

    </c:choose>

</div>

                </div>


                <!-- ORDER STATUS -->

                <div class="detail-box">

                    <div class="label">
                        Order Status
                    </div>

                    <div class="value">

                        <span class="status">

                            ${order.orderStatus}

                        </span>

                    </div>

                </div>


                <!-- DISCOUNT -->

                <div class="detail-box">

                    <div class="label">
                        Discount
                    </div>

                    <div class="value">

                        ₹${order.discount}

                    </div>

                </div>


                <!-- ADDRESS -->

                <div class="detail-box">

                    <div class="label">
                        Address ID
                    </div>

                    <div class="value">

                        #${order.addressId}

                    </div>

                </div>


            </div>


            <!-- =================================================
                 ORDER FOOTER
                 ================================================= -->

            <div class="order-footer">


                <div class="total-area">

                    <span class="total-label">
                        Order Total
                    </span>

                    <span class="total-value">

                        ₹${order.totalAmount}

                    </span>

                </div>


                <a
                    class="details-button"
                    href="${pageContext.request.contextPath}/order-details?id=${order.orderId}">

                    View Order Details

                    <span>
                        →
                    </span>

                </a>

            </div>


        </div>


    </c:forEach>


    <!-- =================================================
         BOTTOM ACTION
         ================================================= -->

    <div class="bottom-action">

        <a
            href="${pageContext.request.contextPath}/products">

            ← Continue Shopping

        </a>

    </div>


</div>


</body>

</html>