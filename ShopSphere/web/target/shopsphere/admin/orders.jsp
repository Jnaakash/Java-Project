```jsp
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Orders | ShopSphere Admin</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap"
          rel="stylesheet">

    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: "Inter", sans-serif;
            background:
                radial-gradient(circle at top left, rgba(59,130,246,.14), transparent 30%),
                radial-gradient(circle at bottom right, rgba(124,58,237,.12), transparent 30%),
                #f5f7fb;
            color: #111827;
            min-height: 100vh;
        }

        a {
            text-decoration: none;
        }

        .navbar {
            min-height: 72px;
            background: rgba(255,255,255,.94);
            backdrop-filter: blur(16px);
            border-bottom: 1px solid #e5e7eb;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 14px 42px;
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .brand {
            font-size: 23px;
            font-weight: 800;
            color: #2563eb;
            letter-spacing: -.5px;
        }

        .nav-links {
            display: flex;
            gap: 8px;
            flex-wrap: wrap;
        }

        .nav-links a {
            padding: 9px 12px;
            border-radius: 9px;
            color: #4b5563;
            font-size: 12px;
            font-weight: 600;
        }

        .nav-links a:hover {
            background: #eff6ff;
            color: #2563eb;
        }

        .nav-links .active {
            background: #2563eb;
            color: white;
        }

        .container {
            max-width: 1450px;
            margin: 0 auto;
            padding: 38px 24px 60px;
        }

        .page-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 20px;
            margin-bottom: 28px;
        }

        .title-area {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .header-icon {
            width: 52px;
            height: 52px;
            flex-shrink: 0;
            border-radius: 15px;
            background: linear-gradient(135deg, #2563eb, #7c3aed);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 23px;
            box-shadow: 0 12px 30px rgba(37,99,235,.25);
        }

        .page-header h1 {
            font-size: 29px;
            font-weight: 800;
            letter-spacing: -.8px;
        }

        .page-header p {
            color: #6b7280;
            font-size: 13px;
            margin-top: 7px;
        }

        .filter-card,
        .table-card {
            background: white;
            border: 1px solid #e5e7eb;
            border-radius: 18px;
            box-shadow: 0 10px 35px rgba(15,23,42,.06);
        }

        .filter-card {
            padding: 20px;
            margin-bottom: 24px;
        }

        .filter-form {
            display: grid;
            grid-template-columns: minmax(220px, 1fr) 220px auto auto;
            gap: 12px;
        }

        .input,
        .select {
            min-width: 0;
            height: 44px;
            border: 1px solid #d1d5db;
            border-radius: 10px;
            padding: 0 12px;
            font-family: inherit;
            font-size: 12px;
            outline: none;
            background: white;
        }

        .input:focus,
        .select:focus {
            border-color: #2563eb;
            box-shadow: 0 0 0 3px rgba(37,99,235,.1);
        }

        .btn {
            min-height: 40px;
            border: none;
            border-radius: 9px;
            padding: 10px 14px;
            cursor: pointer;
            font-family: inherit;
            font-size: 12px;
            font-weight: 700;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            transition: .2s;
            white-space: nowrap;
        }

        .btn-primary {
            background: #2563eb;
            color: white;
        }

        .btn-primary:hover {
            background: #1d4ed8;
            transform: translateY(-1px);
        }

        .btn-secondary {
            background: #f3f4f6;
            color: #374151;
        }

        .btn-secondary:hover {
            background: #e5e7eb;
        }

        .table-card {
            overflow: hidden;
        }

        .table-heading {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 12px;
            padding: 20px 22px;
            border-bottom: 1px solid #e5e7eb;
        }

        .table-heading h2 {
            font-size: 16px;
            font-weight: 800;
        }

        .table-heading p {
            color: #6b7280;
            font-size: 12px;
            margin-top: 5px;
        }

        .table-wrapper {
            width: 100%;
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            min-width: 1150px;
        }

        thead {
            background: #f8fafc;
        }

        th {
            text-align: left;
            padding: 15px 16px;
            color: #6b7280;
            font-size: 10px;
            font-weight: 800;
            text-transform: uppercase;
            letter-spacing: .5px;
            border-bottom: 1px solid #e5e7eb;
            white-space: nowrap;
        }

        td {
            padding: 15px 16px;
            border-bottom: 1px solid #f1f5f9;
            font-size: 12px;
            color: #374151;
            vertical-align: middle;
        }

        tbody tr:hover {
            background: #f8fbff;
        }

        .order-id {
            font-weight: 800;
            color: #2563eb;
        }

        .customer-name {
            font-weight: 700;
            color: #111827;
        }

        .amount {
            font-weight: 800;
            color: #111827;
            white-space: nowrap;
        }

        .status {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 7px 10px;
            border-radius: 20px;
            font-size: 9px;
            font-weight: 800;
            text-transform: uppercase;
            letter-spacing: .3px;
            white-space: nowrap;
        }

        .status::before {
            content: "";
            width: 6px;
            height: 6px;
            border-radius: 50%;
            background: currentColor;
        }

        .status-placed { background: #dbeafe; color: #1d4ed8; }
        .status-confirmed { background: #e0e7ff; color: #4338ca; }
        .status-processing { background: #fef3c7; color: #b45309; }
        .status-shipped { background: #cffafe; color: #0e7490; }
        .status-delivered { background: #dcfce7; color: #15803d; }
        .status-cancelled { background: #fee2e2; color: #dc2626; }
        .status-default { background: #f3f4f6; color: #4b5563; }

        .action-btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 9px 12px;
            border-radius: 8px;
            font-size: 11px;
            font-weight: 700;
            color: #2563eb;
            background: #eff6ff;
            transition: .2s;
            white-space: nowrap;
        }

        .action-btn:hover {
            background: #2563eb;
            color: white;
        }

        .update-form {
            display: flex;
            align-items: center;
            gap: 7px;
            min-width: 245px;
        }

        .status-select {
            min-width: 135px;
            height: 36px;
            padding: 0 8px;
            border: 1px solid #d1d5db;
            border-radius: 8px;
            background: white;
            color: #374151;
            font-family: inherit;
            font-size: 11px;
            outline: none;
        }

        .status-select:focus {
            border-color: #2563eb;
        }

        .update-btn {
            min-height: 36px;
            padding: 0 11px;
            border: none;
            border-radius: 8px;
            background: #2563eb;
            color: white;
            font-family: inherit;
            font-size: 11px;
            font-weight: 700;
            cursor: pointer;
        }

        .update-btn:hover {
            background: #1d4ed8;
        }

        .message {
            padding: 13px 16px;
            margin-bottom: 18px;
            border-radius: 10px;
            font-size: 13px;
            font-weight: 600;
        }

        .message-success {
            background: #dcfce7;
            color: #166534;
            border: 1px solid #bbf7d0;
        }

        .message-error {
            background: #fee2e2;
            color: #991b1b;
            border: 1px solid #fecaca;
        }

        .empty-state {
            padding: 70px 20px;
            text-align: center;
        }

        .empty-icon {
            font-size: 45px;
            margin-bottom: 15px;
        }

        .empty-state h3 {
            font-size: 19px;
            margin-bottom: 8px;
        }

        .empty-state p {
            color: #6b7280;
            font-size: 13px;
        }

        .pagination {
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            gap: 7px;
            padding: 20px;
            border-top: 1px solid #f1f5f9;
        }

        .page-link {
            min-width: 36px;
            height: 36px;
            padding: 0 9px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 8px;
            background: #f3f4f6;
            color: #374151;
            font-size: 12px;
            font-weight: 700;
        }

        .page-link:hover,
        .page-link.active {
            background: #2563eb;
            color: white;
        }

        @media (max-width: 900px) {
            .navbar {
                padding: 14px 20px;
                align-items: flex-start;
                gap: 15px;
                flex-direction: column;
            }

            .filter-form {
                grid-template-columns: 1fr 1fr;
            }

            .filter-form .btn {
                width: 100%;
            }

            .container {
                padding: 26px 15px 45px;
            }
        }

        @media (max-width: 520px) {
            .filter-form {
                grid-template-columns: 1fr;
            }

            .page-header h1 {
                font-size: 24px;
            }

            .table-heading {
                align-items: flex-start;
                flex-direction: column;
            }
        }
    </style>
</head>

<body>

<nav class="navbar">
    <a href="${pageContext.request.contextPath}/admin/dashboard" class="brand">
        ShopSphere
    </a>

    <div class="nav-links">
        <a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a>
        <a href="${pageContext.request.contextPath}/admin/products">Products</a>
        <a href="${pageContext.request.contextPath}/admin/categories">Categories</a>
        <a href="${pageContext.request.contextPath}/admin/customers">Customers</a>
        <a href="${pageContext.request.contextPath}/admin/orders" class="active">Orders</a>
    </div>
</nav>

<main class="container">

    <div class="page-header">
        <div class="title-area">
            <div class="header-icon">📦</div>
            <div>
                <h1>Manage Orders</h1>
                <p>Track customer orders and update delivery status.</p>
            </div>
        </div>
    </div>

    <c:if test="${param.success == 'status'}">
        <div class="message message-success">
            Order status updated successfully.
        </div>
    </c:if>

    <c:if test="${param.error == 'invalid'}">
        <div class="message message-error">
            Invalid order ID or status. Please try again.
        </div>
    </c:if>

    <c:if test="${param.error == 'update'}">
        <div class="message message-error">
            Could not update the order status. Please check the order and try again.
        </div>
    </c:if>

    <c:if test="${param.error == 'notfound'}">
        <div class="message message-error">
            The requested order was not found.
        </div>
    </c:if>

    <div class="filter-card">
        <form method="get"
              action="${pageContext.request.contextPath}/admin/orders"
              class="filter-form">

            <input type="text"
                   name="keyword"
                   class="input"
                   placeholder="Search orders..."
                   value="${keyword}">

            <select name="status" class="select">
                <option value="">All Order Status</option>
                <option value="PLACED" ${status == 'PLACED' ? 'selected' : ''}>Placed</option>
                <option value="CONFIRMED" ${status == 'CONFIRMED' ? 'selected' : ''}>Confirmed</option>
                <option value="PROCESSING" ${status == 'PROCESSING' ? 'selected' : ''}>Processing</option>
                <option value="SHIPPED" ${status == 'SHIPPED' ? 'selected' : ''}>Shipped</option>
                <option value="DELIVERED" ${status == 'DELIVERED' ? 'selected' : ''}>Delivered</option>
                <option value="CANCELLED" ${status == 'CANCELLED' ? 'selected' : ''}>Cancelled</option>
            </select>

            <button type="submit" class="btn btn-primary">Search Orders</button>

            <a href="${pageContext.request.contextPath}/admin/orders"
               class="btn btn-secondary">Reset</a>
        </form>
    </div>

    <div class="table-card">

        <div class="table-heading">
            <div>
                <h2>Customer Orders</h2>
                <p>Use the dropdown to change an order's current status.</p>
            </div>
        </div>

        <c:choose>
            <c:when test="${empty orders}">
                <div class="empty-state">
                    <div class="empty-icon">📦</div>
                    <h3>No Orders Found</h3>
                    <p>There are no orders matching your search.</p>
                </div>
            </c:when>

            <c:otherwise>
                <div class="table-wrapper">
                    <table>
                        <thead>
                        <tr>
                            <th>Order ID</th>
                            <th>Customer ID</th>
                            <th>Total</th>
                            <th>Payment</th>
                            <th>Current Status</th>
                            <th>Order Date</th>
                            <th>Update Status</th>
                            <th>Details</th>
                        </tr>
                        </thead>

                        <tbody>
                        <c:forEach var="order" items="${orders}">
                            <tr>
                                <td>
                                    <span class="order-id">#${order.orderId}</span>
                                </td>

                                <td>
                                    <span class="customer-name">User #${order.userId}</span>
                                </td>

                                <td>
                                    <span class="amount">
                                        ₹<fmt:formatNumber
                                            value="${order.totalAmount}"
                                            type="number"
                                            minFractionDigits="2"
                                            maxFractionDigits="2"/>
                                    </span>
                                </td>

                                <td>${order.paymentMethod}</td>

                                <td>
                                    <c:set var="statusClass" value="status-default"/>

                                    <c:choose>
                                        <c:when test="${order.orderStatus == 'PLACED'}">
                                            <c:set var="statusClass" value="status-placed"/>
                                        </c:when>
                                        <c:when test="${order.orderStatus == 'CONFIRMED'}">
                                            <c:set var="statusClass" value="status-confirmed"/>
                                        </c:when>
                                        <c:when test="${order.orderStatus == 'PROCESSING'}">
                                            <c:set var="statusClass" value="status-processing"/>
                                        </c:when>
                                        <c:when test="${order.orderStatus == 'SHIPPED'}">
                                            <c:set var="statusClass" value="status-shipped"/>
                                        </c:when>
                                        <c:when test="${order.orderStatus == 'DELIVERED'}">
                                            <c:set var="statusClass" value="status-delivered"/>
                                        </c:when>
                                        <c:when test="${order.orderStatus == 'CANCELLED'}">
                                            <c:set var="statusClass" value="status-cancelled"/>
                                        </c:when>
                                    </c:choose>

                                    <span class="status ${statusClass}">
                                        <c:out value="${order.orderStatus}"/>
                                    </span>
                                </td>

                                <td>
                                    <fmt:formatDate
                                        value="${order.createdAt}"
                                        pattern="dd MMM yyyy, hh:mm a"/>
                                </td>

                                <td>
                                    <form
                                        action="${pageContext.request.contextPath}/admin/update-order-status"
                                        method="post"
                                        class="update-form">

                                        <input type="hidden"
                                               name="orderId"
                                               value="${order.orderId}">

                                        <select name="status"
                                                class="status-select"
                                                aria-label="New status for order ${order.orderId}"
                                                required>

                                            <option value="PLACED"
                                                ${order.orderStatus == 'PLACED' ? 'selected' : ''}>
                                                Placed
                                            </option>

                                            <option value="CONFIRMED"
                                                ${order.orderStatus == 'CONFIRMED' ? 'selected' : ''}>
                                                Confirmed
                                            </option>

                                            <option value="PROCESSING"
                                                ${order.orderStatus == 'PROCESSING' ? 'selected' : ''}>
                                                Processing
                                            </option>

                                            <option value="SHIPPED"
                                                ${order.orderStatus == 'SHIPPED' ? 'selected' : ''}>
                                                Shipped
                                            </option>

                                            <option value="DELIVERED"
                                                ${order.orderStatus == 'DELIVERED' ? 'selected' : ''}>
                                                Delivered
                                            </option>

                                            <option value="CANCELLED"
                                                ${order.orderStatus == 'CANCELLED' ? 'selected' : ''}>
                                                Cancelled
                                            </option>
                                        </select>

                                        <button type="submit" class="update-btn">
                                            Update
                                        </button>
                                    </form>
                                </td>

                                <td>
                                    <a href="${pageContext.request.contextPath}/admin/orders/details?id=${order.orderId}"
                                       class="action-btn">
                                        View Details →
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>

                <c:if test="${totalPages > 1}">
                    <div class="pagination">
                        <c:forEach var="page" begin="1" end="${totalPages}">
                            <c:url var="pageUrl" value="/admin/orders">
                                <c:param name="page" value="${page}"/>
                                <c:param name="keyword" value="${keyword}"/>
                                <c:param name="status" value="${status}"/>
                            </c:url>

                            <a href="${pageContext.request.contextPath}${pageUrl}"
                               class="page-link ${page == currentPage ? 'active' : ''}">
                                ${page}
                            </a>
                        </c:forEach>
                    </div>
                </c:if>
            </c:otherwise>
        </c:choose>
    </div>
</main>

</body>
</html>
```