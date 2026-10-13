<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - ShopSphere</title>

    <style>
        :root {
            --primary: #2563eb;
            --primary-dark: #1d4ed8;
            --navy: #0b1730;
            --navy-2: #101f3f;
            --text: #172033;
            --muted: #718096;
            --bg: #f4f7fc;
            --white: #ffffff;
            --border: #e7ecf4;
            --green: #16a34a;
            --orange: #f59e0b;
            --red: #ef4444;
            --purple: #7c3aed;
            --shadow: 0 12px 35px rgba(23, 38, 73, .08);
        }

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: Inter, "Segoe UI", Arial, sans-serif;
            background:
                radial-gradient(circle at 15% 10%, rgba(37,99,235,.10), transparent 28%),
                radial-gradient(circle at 90% 20%, rgba(124,58,237,.08), transparent 25%),
                linear-gradient(135deg, #f7f9fd 0%, #eef4ff 100%);
            color: var(--text);
            min-height: 100vh;
        }

        a {
            text-decoration: none;
        }

        /* ================= SIDEBAR ================= */

        .sidebar {
            position: fixed;
            left: 0;
            top: 0;
            bottom: 0;
            width: 255px;
            padding: 24px 16px;
            background:
                radial-gradient(circle at 20% 10%, rgba(59,130,246,.18), transparent 30%),
                linear-gradient(180deg, #0b1730 0%, #071126 100%);
            color: white;
            z-index: 20;
            box-shadow: 8px 0 30px rgba(5, 15, 35, .12);
        }

        .brand {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 0 12px 28px;
            border-bottom: 1px solid rgba(255,255,255,.09);
        }

        .brand-icon {
            width: 42px;
            height: 42px;
            border-radius: 13px;
            display: grid;
            place-items: center;
            font-size: 22px;
            background: linear-gradient(135deg, #3b82f6, #6366f1);
            box-shadow: 0 8px 20px rgba(37,99,235,.30);
        }

        .brand strong {
            font-size: 20px;
            letter-spacing: -.4px;
        }

        .brand span {
            color: #60a5fa;
        }

        .brand small {
            display: block;
            margin-top: 3px;
            color: #91a1bc;
            font-size: 11px;
        }

        .nav-title {
            margin: 26px 12px 10px;
            color: #7183a2;
            font-size: 11px;
            text-transform: uppercase;
            letter-spacing: 1.2px;
            font-weight: 700;
        }

        .nav {
            display: flex;
            flex-direction: column;
            gap: 6px;
        }

        .nav a {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 12px 13px;
            color: #b9c6db;
            border-radius: 11px;
            font-size: 14px;
            font-weight: 600;
            transition: .2s ease;
        }

        .nav a:hover,
        .nav a.active {
            color: white;
            background: linear-gradient(90deg, rgba(37,99,235,.95), rgba(59,130,246,.70));
            box-shadow: 0 8px 20px rgba(37,99,235,.20);
            transform: translateX(2px);
        }

        .nav-icon {
            width: 26px;
            text-align: center;
            font-size: 17px;
        }

        .sidebar-bottom {
            position: absolute;
            left: 16px;
            right: 16px;
            bottom: 20px;
        }

        .store-link {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 12px 13px;
            border: 1px solid rgba(255,255,255,.10);
            border-radius: 11px;
            color: #d7e0ef;
            font-size: 13px;
            margin-bottom: 8px;
        }

        .logout-link {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 12px 13px;
            border-radius: 11px;
            color: #ff8f8f;
            font-weight: 700;
            font-size: 13px;
        }

        .logout-link:hover {
            background: rgba(239,68,68,.10);
        }

        /* ================= MAIN ================= */

        .main {
            margin-left: 255px;
            min-height: 100vh;
        }

        .topbar {
            height: 76px;
            padding: 0 34px;
            background: rgba(255,255,255,.82);
            backdrop-filter: blur(15px);
            border-bottom: 1px solid rgba(221,228,240,.8);
            display: flex;
            align-items: center;
            justify-content: space-between;
            position: sticky;
            top: 0;
            z-index: 10;
        }

        .topbar-left h2 {
            font-size: 18px;
        }

        .topbar-left p {
            color: var(--muted);
            font-size: 12px;
            margin-top: 3px;
        }

        .profile {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .profile-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            display: grid;
            place-items: center;
            background: linear-gradient(135deg, #2563eb, #7c3aed);
            color: white;
            font-weight: 800;
        }

        .profile-info strong {
            display: block;
            font-size: 13px;
        }

        .profile-info span {
            color: var(--muted);
            font-size: 11px;
        }

        .content {
            padding: 32px;
        }

        .welcome {
            display: flex;
            justify-content: space-between;
            align-items: end;
            gap: 20px;
            margin-bottom: 25px;
        }

        .welcome h1 {
            font-size: 30px;
            letter-spacing: -.8px;
        }

        .welcome p {
            margin-top: 7px;
            color: var(--muted);
            font-size: 14px;
        }

        .view-store {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            background: var(--white);
            border: 1px solid var(--border);
            color: var(--primary);
            padding: 11px 16px;
            border-radius: 10px;
            font-weight: 700;
            box-shadow: 0 5px 15px rgba(23,38,73,.05);
        }

        .view-store:hover {
            background: #eff6ff;
        }

        /* ================= STAT CARDS ================= */

        .cards {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 18px;
            margin-bottom: 22px;
        }

        .card {
            position: relative;
            overflow: hidden;
            background: rgba(255,255,255,.95);
            border: 1px solid rgba(225,231,241,.9);
            border-radius: 18px;
            padding: 20px;
            box-shadow: var(--shadow);
            transition: .22s ease;
        }

        .card:hover {
            transform: translateY(-4px);
            box-shadow: 0 18px 40px rgba(23,38,73,.12);
        }

        .card::after {
            content: "";
            position: absolute;
            width: 100px;
            height: 100px;
            border-radius: 50%;
            right: -38px;
            top: -42px;
            background: rgba(37,99,235,.06);
        }

        .card-head {
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .card h3 {
            color: var(--muted);
            font-size: 12px;
            text-transform: uppercase;
            letter-spacing: .6px;
        }

        .card-icon {
            width: 42px;
            height: 42px;
            border-radius: 12px;
            display: grid;
            place-items: center;
            font-size: 19px;
        }

        .blue .card-icon {
            background: #e8f0ff;
            color: var(--primary);
        }

        .green .card-icon {
            background: #e8faef;
            color: var(--green);
        }

        .orange .card-icon {
            background: #fff5dd;
            color: #d97706;
        }

        .purple .card-icon {
            background: #f0eaff;
            color: var(--purple);
        }

        .card .number {
            margin-top: 16px;
            font-size: 28px;
            font-weight: 800;
            letter-spacing: -.5px;
        }

        .card-footer {
            margin-top: 8px;
            color: #718096;
            font-size: 11px;
        }

        /* ================= LOWER GRID ================= */

        .dashboard-grid {
            display: grid;
            grid-template-columns: 1.65fr 1fr;
            gap: 20px;
            margin-bottom: 22px;
        }

        .panel {
            background: rgba(255,255,255,.95);
            border: 1px solid rgba(225,231,241,.9);
            border-radius: 18px;
            padding: 22px;
            box-shadow: var(--shadow);
        }

        .panel-title {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .panel-title h2 {
            font-size: 17px;
        }

        .panel-title span {
            color: var(--muted);
            font-size: 12px;
        }

        /* Decorative sales chart */
        .chart {
            height: 205px;
            display: flex;
            align-items: end;
            gap: 14px;
            padding: 15px 8px 0;
            border-bottom: 1px solid var(--border);
            background:
                repeating-linear-gradient(
                    to top,
                    transparent 0,
                    transparent 39px,
                    #eef2f8 40px
                );
        }

        .bar-wrap {
            flex: 1;
            height: 100%;
            display: flex;
            flex-direction: column;
            justify-content: end;
            align-items: center;
            gap: 7px;
        }

        .bar {
            width: min(38px, 70%);
            border-radius: 8px 8px 3px 3px;
            background: linear-gradient(180deg, #3b82f6, #2563eb);
            box-shadow: 0 8px 18px rgba(37,99,235,.18);
            min-height: 18px;
        }

        .bar-label {
            color: var(--muted);
            font-size: 10px;
        }

        .quick-stats {
            display: grid;
            gap: 12px;
        }

        .quick-item {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 13px 14px;
            border: 1px solid var(--border);
            border-radius: 12px;
            background: #fafcff;
        }

        .quick-item-left {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .quick-dot {
            width: 10px;
            height: 10px;
            border-radius: 50%;
        }

        .quick-item strong {
            display: block;
            font-size: 13px;
        }

        .quick-item small {
            color: var(--muted);
            font-size: 10px;
        }

        /* ================= ORDERS ================= */

        .orders-panel {
            margin-bottom: 22px;
        }

        .table-wrap {
            overflow-x: auto;
        }

        .orders-table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            min-width: 760px;
        }

        .orders-table th {
            padding: 12px 14px;
            text-align: left;
            color: #7a879d;
            background: #f7f9fc;
            font-size: 11px;
            text-transform: uppercase;
            letter-spacing: .5px;
            border-bottom: 1px solid var(--border);
        }

        .orders-table th:first-child {
            border-radius: 10px 0 0 10px;
        }

        .orders-table th:last-child {
            border-radius: 0 10px 10px 0;
        }

        .orders-table td {
            padding: 15px 14px;
            border-bottom: 1px solid #edf1f6;
            font-size: 13px;
        }

        .orders-table tbody tr:hover {
            background: #fafcff;
        }

        .order-id {
            color: var(--primary);
            font-weight: 800;
        }

        .amount {
            font-weight: 800;
        }

        .status {
            display: inline-flex;
            padding: 6px 10px;
            border-radius: 20px;
            font-size: 10px;
            font-weight: 800;
            letter-spacing: .3px;
        }

        .status-placed {
            background: #fff4cc;
            color: #a16207;
        }

        .status-confirmed {
            background: #e0efff;
            color: #1d4ed8;
        }

        .status-shipped {
            background: #eee7ff;
            color: #6d28d9;
        }

        .status-delivered {
            background: #dcfce7;
            color: #15803d;
        }

        .status-cancelled {
            background: #fee2e2;
            color: #b91c1c;
        }

        .view-link {
            color: var(--primary);
            font-weight: 700;
            font-size: 12px;
        }

        .view-link:hover {
            text-decoration: underline;
        }

        .no-orders {
            padding: 35px !important;
            text-align: center;
            color: var(--muted);
        }

        /* ================= QUICK ACTIONS ================= */

        .action-grid {
            display: grid;
            grid-template-columns: repeat(6, 1fr);
            gap: 12px;
        }

        .action {
            display: flex;
            flex-direction: column;
            gap: 9px;
            padding: 16px;
            border-radius: 14px;
            color: white;
            min-height: 94px;
            justify-content: space-between;
            box-shadow: 0 8px 20px rgba(23,38,73,.08);
            transition: .2s ease;
        }

        .action:hover {
            transform: translateY(-3px);
            box-shadow: 0 14px 28px rgba(23,38,73,.14);
        }

        .action-icon {
            font-size: 21px;
        }

        .action strong {
            font-size: 12px;
        }

        .action.blue {
            background: linear-gradient(135deg, #2563eb, #3b82f6);
        }

        .action.green {
            background: linear-gradient(135deg, #16a34a, #22c55e);
        }

        .action.purple {
            background: linear-gradient(135deg, #7c3aed, #9333ea);
        }

        .action.orange {
            background: linear-gradient(135deg, #ea580c, #f97316);
        }

        .action.indigo {
            background: linear-gradient(135deg, #4f46e5, #6366f1);
        }

        .action.dark {
            background: linear-gradient(135deg, #334155, #475569);
        }

        /* ================= MOBILE ================= */

        .mobile-menu {
            display: none;
        }

        @media (max-width: 1250px) {
            .cards {
                grid-template-columns: repeat(2, 1fr);
            }

            .action-grid {
                grid-template-columns: repeat(3, 1fr);
            }
        }

        @media (max-width: 900px) {
            .sidebar {
                width: 80px;
                padding: 18px 10px;
            }

            .brand {
                justify-content: center;
                padding-left: 0;
                padding-right: 0;
            }

            .brand-text,
            .nav-title,
            .nav a span:not(.nav-icon),
            .sidebar-bottom span {
                display: none;
            }

            .nav a,
            .store-link,
            .logout-link {
                justify-content: center;
            }

            .main {
                margin-left: 80px;
            }

            .dashboard-grid {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 650px) {
            .topbar {
                padding: 0 18px;
            }

            .profile-info {
                display: none;
            }

            .content {
                padding: 20px 15px;
            }

            .welcome {
                align-items: flex-start;
                flex-direction: column;
            }

            .welcome h1 {
                font-size: 24px;
            }

            .cards {
                grid-template-columns: 1fr;
            }

            .action-grid {
                grid-template-columns: repeat(2, 1fr);
            }

            .panel {
                padding: 16px;
            }
        }
    </style>
</head>

<body>

<!-- ================= SIDEBAR ================= -->

<aside class="sidebar">

    <div class="brand">
        <div class="brand-icon">🛍️</div>
        <div class="brand-text">
            <strong>Shop<span>Sphere</span></strong>
            <small>Admin Panel</small>
        </div>
    </div>

    <div class="nav-title">Main Menu</div>

    <nav class="nav">

        <a href="${pageContext.request.contextPath}/admin/dashboard"
           class="active">
            <span class="nav-icon">⌂</span>
            <span>Dashboard</span>
        </a>

        <a href="${pageContext.request.contextPath}/admin/products">
            <span class="nav-icon">▣</span>
            <span>Products</span>
        </a>

        <a href="${pageContext.request.contextPath}/admin/categories">
            <span class="nav-icon">🏷</span>
            <span>Categories</span>
        </a>

        <a href="${pageContext.request.contextPath}/admin/customers">
            <span class="nav-icon">♙</span>
            <span>Customers</span>
        </a>

        <a href="${pageContext.request.contextPath}/admin/orders">
            <span class="nav-icon">🛒</span>
            <span>Orders</span>
        </a>

        <div class="nav-title">Store</div>

        <a href="${pageContext.request.contextPath}/products">
            <span class="nav-icon">🌐</span>
            <span>View Store</span>
        </a>

    </nav>

    <div class="sidebar-bottom">

        <a class="store-link"
           href="${pageContext.request.contextPath}/admin/add-product">
            <span>＋</span>
            <span>Add Product</span>
        </a>

        <a class="logout-link"
           href="${pageContext.request.contextPath}/logout">
            <span>↪</span>
            <span>Logout</span>
        </a>

    </div>

</aside>


<!-- ================= MAIN ================= -->

<main class="main">

    <!-- TOPBAR -->

    <header class="topbar">

        <div class="topbar-left">
            <h2>Dashboard Overview</h2>
            <p>Monitor your ShopSphere store performance</p>
        </div>

        <div class="profile">

            <div class="profile-avatar">A</div>

            <div class="profile-info">
                <strong>ShopSphere Admin</strong>
                <span>Administrator</span>
            </div>

        </div>

    </header>


    <section class="content">

        <!-- ================= WELCOME ================= -->

        <div class="welcome">

            <div>
                <h1>Good day, Admin 👋</h1>
                <p>Here's what's happening with your store today.</p>
            </div>

            <a class="view-store"
               href="${pageContext.request.contextPath}/products">
                🌐 View Store →
            </a>

        </div>


        <!-- ================= STATISTICS ================= -->

        <div class="cards">

            <div class="card blue">

                <div class="card-head">
                    <h3>Active Products</h3>
                    <div class="card-icon">📦</div>
                </div>

                <div class="number">${activeProductCount}</div>
                <div class="card-footer">Products currently available</div>

            </div>


            <div class="card green">

                <div class="card-head">
                    <h3>Total Orders</h3>
                    <div class="card-icon">🛒</div>
                </div>

                <div class="number">${totalOrderCount}</div>
                <div class="card-footer">Orders received by store</div>

            </div>


            <div class="card orange">

                <div class="card-head">
                    <h3>Total Sales</h3>
                    <div class="card-icon">₹</div>
                </div>

                <div class="number">
                    ₹<fmt:formatNumber
                        value="${totalSales}"
                        type="number"
                        minFractionDigits="2"
                        maxFractionDigits="2"/>
                </div>

                <div class="card-footer">Total recorded sales</div>

            </div>


            <div class="card purple">

                <div class="card-head">
                    <h3>Pending Orders</h3>
                    <div class="card-icon">⏱</div>
                </div>

                <div class="number">${pendingOrderCount}</div>
                <div class="card-footer">Orders awaiting completion</div>

            </div>


            <div class="card green">

                <div class="card-head">
                    <h3>Delivered Orders</h3>
                    <div class="card-icon">✓</div>
                </div>

                <div class="number">${deliveredOrderCount}</div>
                <div class="card-footer">Successfully delivered</div>

            </div>


            <div class="card blue">

                <div class="card-head">
                    <h3>Active Customers</h3>
                    <div class="card-icon">♙</div>
                </div>

                <div class="number">${activeCustomerCount}</div>
                <div class="card-footer">Active customer accounts</div>

            </div>


            <div class="card orange">

                <div class="card-head">
                    <h3>Inactive Customers</h3>
                    <div class="card-icon">○</div>
                </div>

                <div class="number">${inactiveCustomerCount}</div>
                <div class="card-footer">Currently inactive accounts</div>

            </div>

        </div>


        <!-- ================= ANALYTICS ================= -->

        <div class="dashboard-grid">

            <div class="panel">

                <div class="panel-title">
                    <div>
                        <h2>Sales Overview</h2>
                        <span>Store activity overview</span>
                    </div>

                    <span>ShopSphere</span>
                </div>

                <div class="chart">

                    <div class="bar-wrap">
                        <div class="bar" style="height:35%;"></div>
                        <span class="bar-label">Mon</span>
                    </div>

                    <div class="bar-wrap">
                        <div class="bar" style="height:50%;"></div>
                        <span class="bar-label">Tue</span>
                    </div>

                    <div class="bar-wrap">
                        <div class="bar" style="height:42%;"></div>
                        <span class="bar-label">Wed</span>
                    </div>

                    <div class="bar-wrap">
                        <div class="bar" style="height:70%;"></div>
                        <span class="bar-label">Thu</span>
                    </div>

                    <div class="bar-wrap">
                        <div class="bar" style="height:58%;"></div>
                        <span class="bar-label">Fri</span>
                    </div>

                    <div class="bar-wrap">
                        <div class="bar" style="height:82%;"></div>
                        <span class="bar-label">Sat</span>
                    </div>

                    <div class="bar-wrap">
                        <div class="bar" style="height:66%;"></div>
                        <span class="bar-label">Sun</span>
                    </div>

                </div>

            </div>


            <div class="panel">

                <div class="panel-title">
                    <div>
                        <h2>Store Summary</h2>
                        <span>Current store status</span>
                    </div>
                </div>

                <div class="quick-stats">

                    <div class="quick-item">
                        <div class="quick-item-left">
                            <span class="quick-dot" style="background:#2563eb;"></span>
                            <div>
                                <strong>Products</strong>
                                <small>Active catalogue</small>
                            </div>
                        </div>
                        <strong>${activeProductCount}</strong>
                    </div>

                    <div class="quick-item">
                        <div class="quick-item-left">
                            <span class="quick-dot" style="background:#16a34a;"></span>
                            <div>
                                <strong>Customers</strong>
                                <small>Active accounts</small>
                            </div>
                        </div>
                        <strong>${activeCustomerCount}</strong>
                    </div>

                    <div class="quick-item">
                        <div class="quick-item-left">
                            <span class="quick-dot" style="background:#f59e0b;"></span>
                            <div>
                                <strong>Pending</strong>
                                <small>Orders to process</small>
                            </div>
                        </div>
                        <strong>${pendingOrderCount}</strong>
                    </div>

                    <div class="quick-item">
                        <div class="quick-item-left">
                            <span class="quick-dot" style="background:#7c3aed;"></span>
                            <div>
                                <strong>Delivered</strong>
                                <small>Completed orders</small>
                            </div>
                        </div>
                        <strong>${deliveredOrderCount}</strong>
                    </div>

                </div>

            </div>

        </div>


        <!-- ================= RECENT ORDERS ================= -->

        <div class="panel orders-panel">

            <div class="panel-title">

                <div>
                    <h2>Recent Orders</h2>
                    <span>Latest orders placed on your store</span>
                </div>

                <a class="view-link"
                   href="${pageContext.request.contextPath}/admin/orders">
                    View All →
                </a>

            </div>


            <div class="table-wrap">

                <table class="orders-table">

                    <thead>
                    <tr>
                        <th>Order ID</th>
                        <th>Customer ID</th>
                        <th>Amount</th>
                        <th>Status</th>
                        <th>Date</th>
                        <th>Action</th>
                    </tr>
                    </thead>

                    <tbody>

                    <c:forEach var="order"
                               items="${recentOrders}">

                        <tr>

                            <td class="order-id">
                                #${order.orderId}
                            </td>

                            <td>
                                Customer #${order.userId}
                            </td>

                            <td class="amount">
                                ₹<fmt:formatNumber
                                    value="${order.totalAmount}"
                                    type="number"
                                    minFractionDigits="2"
                                    maxFractionDigits="2"/>
                            </td>

                            <td>
                                <span class="status status-${order.orderStatus.toLowerCase()}">
                                    ${order.orderStatus}
                                </span>
                            </td>

                            <td>
                                ${order.createdAt}
                            </td>

                            <td>
                                <a class="view-link"
                                   href="${pageContext.request.contextPath}/admin/order-details?id=${order.orderId}">
                                    View →
                                </a>
                            </td>

                        </tr>

                    </c:forEach>


                    <c:if test="${empty recentOrders}">

                        <tr>
                            <td colspan="6" class="no-orders">
                                📦 No recent orders found.
                            </td>
                        </tr>

                    </c:if>

                    </tbody>

                </table>

            </div>

        </div>


        <!-- ================= QUICK ACTIONS ================= -->

        <div class="panel">

            <div class="panel-title">

                <div>
                    <h2>Quick Actions</h2>
                    <span>Manage your ShopSphere store</span>
                </div>

            </div>


            <div class="action-grid">

                <a class="action blue"
                   href="${pageContext.request.contextPath}/admin/products">
                    <span class="action-icon">📦</span>
                    <strong>Manage Products →</strong>
                </a>

                <a class="action green"
                   href="${pageContext.request.contextPath}/admin/add-product">
                    <span class="action-icon">＋</span>
                    <strong>Add Product →</strong>
                </a>

                <a class="action purple"
                   href="${pageContext.request.contextPath}/admin/categories">
                    <span class="action-icon">🏷</span>
                    <strong>Categories →</strong>
                </a>

                <a class="action orange"
                   href="${pageContext.request.contextPath}/admin/orders">
                    <span class="action-icon">🛒</span>
                    <strong>Manage Orders →</strong>
                </a>

                <a class="action indigo"
                   href="${pageContext.request.contextPath}/admin/customers">
                    <span class="action-icon">♙</span>
                    <strong>Customers →</strong>
                </a>

                <a class="action dark"
                   href="${pageContext.request.contextPath}/products">
                    <span class="action-icon">🌐</span>
                    <strong>View Store →</strong>
                </a>

            </div>

        </div>

    </section>

</main>

</body>
</html>
