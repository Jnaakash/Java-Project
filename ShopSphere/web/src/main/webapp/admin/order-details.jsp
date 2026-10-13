<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>

<head>

    <title>ShopSphere - Order Details</title>

    <style>

        * {
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
            background: #f5f5f5;
            margin: 0;
            padding: 30px;
        }

        .container {
            max-width: 1200px;
            margin: auto;
        }

        /* ==============================
           HEADER
           ============================== */

        .top-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
        }

        h1 {
            margin: 0;
        }

        .subtitle {
            color: #64748b;
            margin-top: 8px;
        }

        /* ==============================
           BUTTONS
           ============================== */

        .button {
            display: inline-block;
            padding: 10px 16px;
            color: white;
            text-decoration: none;
            border-radius: 6px;
            background: #64748b;
        }

        .button:hover {
            background: #475569;
        }

        .back-button {
            background: #2563eb;
        }

        .back-button:hover {
            background: #1d4ed8;
        }

        /* ==============================
           CARDS
           ============================== */

        .card {
            background: white;
            border-radius: 8px;
            padding: 25px;
            margin-bottom: 25px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
        }

        .card h2 {
            margin-top: 0;
            margin-bottom: 20px;
            color: #1e293b;
        }

        /* ==============================
           ORDER INFORMATION
           ============================== */

        .order-info {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
        }

        .info-item {
            padding: 15px;
            background: #f8fafc;
            border-radius: 6px;
        }

        .info-label {
            display: block;
            color: #64748b;
            font-size: 13px;
            margin-bottom: 6px;
        }

        .info-value {
            font-weight: bold;
            color: #1e293b;
        }

        /* ==============================
           STATUS
           ============================== */

        .status {
            display: inline-block;
            padding: 6px 10px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: bold;
        }

        .status-PLACED {
            background: #dbeafe;
            color: #1d4ed8;
        }

        .status-CONFIRMED {
            background: #e0e7ff;
            color: #4338ca;
        }

        .status-SHIPPED {
            background: #fef3c7;
            color: #92400e;
        }

        .status-DELIVERED {
            background: #dcfce7;
            color: #166534;
        }

        .status-CANCELLED {
            background: #fee2e2;
            color: #991b1b;
        }

        /* ==============================
           ADDRESS
           ============================== */

        .address-box {
            background: #f8fafc;
            padding: 20px;
            border-radius: 6px;
            line-height: 1.7;
        }

        .address-box strong {
            color: #1e293b;
        }

        /* ==============================
           ORDER ITEMS
           ============================== */

        .items-table {
            width: 100%;
            border-collapse: collapse;
        }

        .items-table th,
        .items-table td {
            padding: 14px;
            border-bottom: 1px solid #e5e7eb;
            text-align: left;
        }

        .items-table th {
            background: #1e293b;
            color: white;
        }

        .items-table tr:hover {
            background: #f8fafc;
        }

        .product-name {
            font-weight: bold;
        }

        .price {
            font-weight: bold;
        }

        .total-row td {
            font-weight: bold;
            font-size: 16px;
            border-top: 2px solid #1e293b;
        }

        .grand-total {
            color: #16a34a;
            font-size: 18px;
        }

        /* ==============================
           EMPTY ITEMS
           ============================== */

        .empty {
            text-align: center;
            padding: 30px;
            color: #64748b;
        }

        /* ==============================
           RESPONSIVE
           ============================== */

        @media (max-width: 900px) {

            body {
                padding: 15px;
            }

            .top-bar {
                flex-direction: column;
                align-items: flex-start;
                gap: 15px;
            }

            .order-info {
                grid-template-columns: repeat(2, 1fr);
            }

            .table-wrapper {
                overflow-x: auto;
            }

            .items-table {
                min-width: 700px;
            }
        }

        @media (max-width: 600px) {

            .order-info {
                grid-template-columns: 1fr;
            }
        }

    </style>

</head>

<body>

<div class="container">

    <!-- ==========================================
         HEADER
         ========================================== -->

    <div class="top-bar">

        <div>

            <h1>📦 Order Details</h1>

            <p class="subtitle">
                Complete information about this customer order.
            </p>

        </div>

        <div>

            <a
                class="button back-button"
                href="${pageContext.request.contextPath}/admin/orders">

                ← Back to Orders

            </a>

        </div>

    </div>


    <!-- ==========================================
         ORDER INFORMATION
         ========================================== -->

    <div class="card">

        <h2>Order Information</h2>

        <div class="order-info">

            <!-- ORDER ID -->

            <div class="info-item">

                <span class="info-label">
                    Order ID
                </span>

                <span class="info-value">
                    #${order.orderId}
                </span>

            </div>


            <!-- USER ID -->

            <div class="info-item">

                <span class="info-label">
                    Customer ID
                </span>

                <span class="info-value">
                    ${order.userId}
                </span>

            </div>


            <!-- PAYMENT METHOD -->

            <div class="info-item">

                <span class="info-label">
                    Payment Method
                </span>

                <span class="info-value">
                    ${order.paymentMethod}
                </span>

            </div>


            <!-- PAYMENT STATUS -->

            <div class="info-item">

                <span class="info-label">
                    Payment Status
                </span>

                <span class="info-value">
                    ${order.paymentStatus}
                </span>

            </div>


            <!-- ORDER STATUS -->

            <div class="info-item">

                <span class="info-label">
                    Order Status
                </span>

                <span
                    class="status status-${order.orderStatus}">

                    ${order.orderStatus}

                </span>

            </div>


            <!-- DISCOUNT -->

            <div class="info-item">

                <span class="info-label">
                    Discount
                </span>

                <span class="info-value">
                    ₹${order.discount}
                </span>

            </div>


            <!-- TOTAL -->

            <div class="info-item">

                <span class="info-label">
                    Total Amount
                </span>

                <span class="info-value">
                    ₹${order.totalAmount}
                </span>

            </div>


            <!-- CREATED DATE -->

            <div class="info-item">

                <span class="info-label">
                    Order Date
                </span>

                <span class="info-value">
                    ${order.createdAt}
                </span>

            </div>

        </div>

    </div>


    <!-- ==========================================
         CUSTOMER ADDRESS
         ========================================== -->

    <div class="card">

        <h2>📍 Delivery Address</h2>

        <c:choose>

            <c:when test="${not empty address}">

                <div class="address-box">

                    <strong>
                        ${address.addressType}
                    </strong>

                    <br>

                    ${address.addressLine}

                    <br>

                    ${address.city},
                    ${address.state}

                    <br>

                    <strong>
                        PIN Code:
                    </strong>

                    ${address.pincode}

                </div>

            </c:when>

            <c:otherwise>

                <div class="empty">

                    Delivery address not found.

                </div>

            </c:otherwise>

        </c:choose>

    </div>


    <!-- ==========================================
         ORDER ITEMS
         ========================================== -->

    <div class="card">

        <h2>🛒 Order Items</h2>

        <c:choose>

            <c:when test="${not empty items}">

                <div class="table-wrapper">

                    <table class="items-table">

                        <thead>

                            <tr>

                                <th>Product</th>

                                <th>Product ID</th>

                                <th>Quantity</th>

                                <th>Price</th>

                                <th>Total</th>

                            </tr>

                        </thead>


                        <tbody>

                        <c:forEach
                            var="item"
                            items="${items}">

                            <tr>

                                <!-- PRODUCT -->

                                <td class="product-name">

                                    ${item.productName}

                                </td>


                                <!-- PRODUCT ID -->

                                <td>

                                    #${item.productId}

                                </td>


                                <!-- QUANTITY -->

                                <td>

                                    ${item.quantity}

                                </td>


                                <!-- PRICE -->

                                <td class="price">

                                    ₹${item.price}

                                </td>


                                <!-- ITEM TOTAL -->

                                <td class="price">

                                    ₹${item.total}

                                </td>

                            </tr>

                        </c:forEach>


                        <!-- GRAND TOTAL -->

                        <tr class="total-row">

                            <td colspan="4">
                                Grand Total
                            </td>

                            <td class="grand-total">
                                ₹${order.totalAmount}
                            </td>

                        </tr>

                        </tbody>

                    </table>

                </div>

            </c:when>


            <c:otherwise>

                <div class="empty">

                    No order items found.

                </div>

            </c:otherwise>

        </c:choose>

    </div>


    <!-- ==========================================
         FOOTER ACTION
         ========================================== -->

    <div style="text-align: right; margin-top: 20px;">

        <a
            class="button"
            href="${pageContext.request.contextPath}/admin/orders">

            ← Back to Manage Orders

        </a>

    </div>

</div>

</body>

</html>