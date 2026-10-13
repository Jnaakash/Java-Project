<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>ShopSphere | Manage Products</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">

    <style>

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        :root {
            --primary: #2563eb;
            --primary-dark: #1d4ed8;
            --bg: #f4f7fb;
            --card: #ffffff;
            --text: #111827;
            --muted: #6b7280;
            --border: #e5e7eb;
            --success: #16a34a;
            --danger: #dc2626;
            --warning: #d97706;
        }

        body {
            font-family: "Inter", Arial, sans-serif;
            background:
                radial-gradient(circle at 10% 10%, rgba(37, 99, 235, .08), transparent 30%),
                radial-gradient(circle at 90% 20%, rgba(99, 102, 241, .08), transparent 30%),
                var(--bg);
            color: var(--text);
            min-height: 100vh;
        }

        /* ================= NAVBAR ================= */

        .navbar {
            height: 72px;
            background: rgba(255,255,255,.92);
            backdrop-filter: blur(16px);
            border-bottom: 1px solid var(--border);
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 36px;
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .brand {
            display: flex;
            align-items: center;
            gap: 11px;
            text-decoration: none;
            color: var(--text);
        }

        .brand-icon {
            width: 40px;
            height: 40px;
            border-radius: 12px;
            background: linear-gradient(135deg, #2563eb, #7c3aed);
            color: white;
            display: grid;
            place-items: center;
            font-size: 20px;
            box-shadow: 0 8px 20px rgba(37,99,235,.25);
        }

        .brand-name {
            font-size: 19px;
            font-weight: 800;
            letter-spacing: -.5px;
        }

        .brand-name span {
            color: var(--primary);
        }

        .nav-right {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .nav-btn {
            text-decoration: none;
            padding: 10px 15px;
            border-radius: 10px;
            font-size: 13px;
            font-weight: 700;
            color: #475569;
            transition: .2s;
        }

        .nav-btn:hover {
            background: #eff6ff;
            color: var(--primary);
        }

        .nav-btn.primary {
            background: var(--primary);
            color: white;
            box-shadow: 0 7px 18px rgba(37,99,235,.22);
        }

        .nav-btn.primary:hover {
            background: var(--primary-dark);
            color: white;
        }

        /* ================= PAGE ================= */

        .page {
            max-width: 1400px;
            margin: auto;
            padding: 34px 30px 60px;
        }

        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            gap: 20px;
            margin-bottom: 28px;
        }

        .page-title {
            font-size: 30px;
            font-weight: 800;
            letter-spacing: -.8px;
        }

        .page-subtitle {
            margin-top: 7px;
            color: var(--muted);
            font-size: 14px;
        }

        .add-product {
            text-decoration: none;
            background: linear-gradient(135deg, #2563eb, #4f46e5);
            color: white;
            padding: 13px 18px;
            border-radius: 12px;
            font-size: 13px;
            font-weight: 800;
            box-shadow: 0 10px 25px rgba(37,99,235,.22);
            transition: .2s;
            white-space: nowrap;
        }

        .add-product:hover {
            transform: translateY(-2px);
            box-shadow: 0 14px 30px rgba(37,99,235,.28);
        }

        /* ================= MESSAGE ================= */

        .message {
            padding: 14px 17px;
            border-radius: 12px;
            margin-bottom: 20px;
            font-size: 13px;
            font-weight: 700;
        }

        .success {
            background: #ecfdf3;
            color: #15803d;
            border: 1px solid #bbf7d0;
        }

        .error {
            background: #fef2f2;
            color: #b91c1c;
            border: 1px solid #fecaca;
        }

        /* ================= SEARCH ================= */

        .filter-card {
            background: rgba(255,255,255,.94);
            border: 1px solid rgba(229,231,235,.9);
            border-radius: 18px;
            padding: 20px;
            box-shadow: 0 12px 35px rgba(15,23,42,.06);
            margin-bottom: 22px;
        }

        .filter-top {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 14px;
        }

        .filter-title {
            font-size: 14px;
            font-weight: 800;
        }

        .filter-hint {
            color: var(--muted);
            font-size: 12px;
        }

        .filter-form {
            display: grid;
            grid-template-columns: minmax(240px, 1fr) 170px auto auto;
            gap: 11px;
        }

        .input,
        .select {
            width: 100%;
            height: 44px;
            border: 1px solid var(--border);
            background: #f8fafc;
            border-radius: 11px;
            padding: 0 14px;
            font-family: inherit;
            font-size: 13px;
            outline: none;
            transition: .2s;
        }

        .input:focus,
        .select:focus {
            background: white;
            border-color: #93c5fd;
            box-shadow: 0 0 0 4px rgba(37,99,235,.08);
        }

        .search-btn,
        .clear-btn {
            height: 44px;
            padding: 0 18px;
            border-radius: 11px;
            font-family: inherit;
            font-size: 13px;
            font-weight: 800;
            cursor: pointer;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
        }

        .search-btn {
            border: 0;
            background: var(--primary);
            color: white;
        }

        .search-btn:hover {
            background: var(--primary-dark);
        }

        .clear-btn {
            border: 1px solid var(--border);
            color: #475569;
            background: white;
        }

        .clear-btn:hover {
            background: #f8fafc;
        }

        /* ================= TABLE ================= */

        .table-card {
            background: rgba(255,255,255,.96);
            border: 1px solid var(--border);
            border-radius: 18px;
            overflow: hidden;
            box-shadow: 0 12px 35px rgba(15,23,42,.06);
        }

        .table-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 19px 21px;
            border-bottom: 1px solid var(--border);
        }

        .table-title {
            font-size: 15px;
            font-weight: 800;
        }

        .product-count {
            font-size: 12px;
            color: var(--muted);
        }

        .table-scroll {
            overflow-x: auto;
        }

        .product-table {
            width: 100%;
            min-width: 1050px;
            border-collapse: collapse;
        }

        .product-table th {
            background: #f8fafc;
            color: #64748b;
            font-size: 11px;
            text-transform: uppercase;
            letter-spacing: .6px;
            font-weight: 800;
            padding: 14px 18px;
            text-align: left;
            border-bottom: 1px solid var(--border);
        }

        .product-table td {
            padding: 16px 18px;
            border-bottom: 1px solid #eef2f7;
            font-size: 13px;
            vertical-align: middle;
        }

        .product-table tbody tr {
            transition: .18s;
        }

        .product-table tbody tr:hover {
            background: #f8fbff;
        }

        .product-table tbody tr:last-child td {
            border-bottom: 0;
        }

        .id {
            color: #94a3b8;
            font-weight: 700;
        }

        .product-name {
            display: flex;
            align-items: center;
            gap: 12px;
            min-width: 220px;
        }

        .product-image {
            width: 46px;
            height: 46px;
            border-radius: 12px;
            background: linear-gradient(135deg, #eff6ff, #eef2ff);
            border: 1px solid #dbeafe;
            display: grid;
            place-items: center;
            flex-shrink: 0;
            font-size: 21px;
        }

        .product-info strong {
            display: block;
            font-size: 13px;
            color: #111827;
            margin-bottom: 4px;
        }

        .product-info span {
            color: #94a3b8;
            font-size: 11px;
        }

        .brand {
            color: #475569;
            font-weight: 600;
        }

        .price {
            font-weight: 800;
            color: #111827;
            white-space: nowrap;
        }

        .discount {
            color: #16a34a;
            font-weight: 800;
        }

        .stock {
            font-weight: 800;
        }

        .stock.good {
            color: #15803d;
        }

        .stock.low {
            color: #d97706;
        }

        .stock.out {
            color: #dc2626;
        }

        /* ================= STATUS ================= */

        .status {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 6px 10px;
            border-radius: 999px;
            font-size: 10px;
            font-weight: 800;
            letter-spacing: .4px;
        }

        .status::before {
            content: "";
            width: 6px;
            height: 6px;
            border-radius: 50%;
            background: currentColor;
        }

        .status.active {
            background: #dcfce7;
            color: #15803d;
        }

        .status.inactive {
            background: #fee2e2;
            color: #dc2626;
        }

        /* ================= ACTIONS ================= */

        .actions {
            display: flex;
            align-items: center;
            gap: 7px;
        }

        .action-btn {
            border: 0;
            min-height: 34px;
            padding: 0 11px;
            border-radius: 9px;
            font-family: inherit;
            font-size: 11px;
            font-weight: 800;
            cursor: pointer;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            white-space: nowrap;
        }

        .edit {
            background: #fff7ed;
            color: #c2410c;
            border: 1px solid #fed7aa;
        }

        .edit:hover {
            background: #ffedd5;
        }

        .deactivate {
            background: #fef2f2;
            color: #dc2626;
            border: 1px solid #fecaca;
        }

        .deactivate:hover {
            background: #fee2e2;
        }

        .activate {
            background: #f0fdf4;
            color: #15803d;
            border: 1px solid #bbf7d0;
        }

        .activate:hover {
            background: #dcfce7;
        }

        /* ================= EMPTY ================= */

        .empty {
            padding: 70px 25px;
            text-align: center;
        }

        .empty-icon {
            width: 70px;
            height: 70px;
            margin: 0 auto 16px;
            border-radius: 20px;
            background: #eff6ff;
            display: grid;
            place-items: center;
            font-size: 30px;
        }

        .empty h2 {
            font-size: 20px;
            margin-bottom: 7px;
        }

        .empty p {
            color: var(--muted);
            font-size: 13px;
        }

        /* ================= PAGINATION ================= */

        .pagination-wrapper {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 20px;
            padding: 18px 21px;
            border-top: 1px solid var(--border);
        }

        .pagination-info {
            color: var(--muted);
            font-size: 12px;
        }

        .pagination-info strong {
            color: #334155;
        }

        .pagination {
            display: flex;
            align-items: center;
            gap: 5px;
            flex-wrap: wrap;
        }

        .page-btn {
            min-width: 35px;
            height: 35px;
            padding: 0 10px;
            border: 1px solid var(--border);
            border-radius: 9px;
            background: white;
            color: #475569;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 12px;
            font-weight: 700;
        }

        .page-btn:hover {
            background: #f8fafc;
        }

        .page-btn.active {
            background: var(--primary);
            color: white;
            border-color: var(--primary);
        }

        .page-btn.disabled {
            color: #cbd5e1;
            background: #f8fafc;
            pointer-events: none;
        }

        .page-dots {
            padding: 0 4px;
            color: #94a3b8;
        }

        /* ================= FOOTER ================= */

        .footer {
            text-align: center;
            color: #94a3b8;
            font-size: 11px;
            margin-top: 30px;
        }

        /* ================= RESPONSIVE ================= */

        @media (max-width: 900px) {

            .navbar {
                padding: 0 18px;
            }

            .page {
                padding: 25px 16px 45px;
            }

            .page-header {
                flex-direction: column;
            }

            .filter-form {
                grid-template-columns: 1fr 1fr;
            }

            .search-btn,
            .clear-btn {
                width: 100%;
            }

        }

        @media (max-width: 600px) {

            .navbar {
                height: auto;
                min-height: 68px;
                padding: 12px 15px;
            }

            .nav-right .nav-btn:not(.primary) {
                display: none;
            }

            .page-title {
                font-size: 25px;
            }

            .filter-form {
                grid-template-columns: 1fr;
            }

            .filter-top {
                align-items: flex-start;
                gap: 10px;
                flex-direction: column;
            }

            .pagination-wrapper {
                align-items: flex-start;
                flex-direction: column;
            }

        }

    </style>

</head>

<body>

<!-- ================= NAVBAR ================= -->

<nav class="navbar">

    <a
        class="brand"
        href="${pageContext.request.contextPath}/admin/dashboard">

        <div class="brand-icon">S</div>

        <div class="brand-name">
            Shop<span>Sphere</span>
        </div>

    </a>

    <div class="nav-right">

        <a
            class="nav-btn"
            href="${pageContext.request.contextPath}/admin/dashboard">
            Dashboard
        </a>

        <a
            class="nav-btn"
            href="${pageContext.request.contextPath}/admin/categories">
            Categories
        </a>

        <a
            class="nav-btn primary"
            href="${pageContext.request.contextPath}/admin/add-product">
            + Add Product
        </a>

    </div>

</nav>


<!-- ================= PAGE ================= -->

<main class="page">

    <div class="page-header">

        <div>
            <h1 class="page-title">Manage Products</h1>

            <p class="page-subtitle">
                Manage your product catalog, pricing, stock and availability.
            </p>
        </div>

        <a
            class="add-product"
            href="${pageContext.request.contextPath}/admin/add-product">
            + Add New Product
        </a>

    </div>


    <!-- ================= FILTER ================= -->

    <div class="filter-card">

        <div class="filter-top">

            <div class="filter-title">
                Product Search & Filters
            </div>

            <div class="filter-hint">
                Search by product name or brand
            </div>

        </div>

        <form
            class="filter-form"
            method="get"
            action="${pageContext.request.contextPath}/admin/products">

            <input
                class="input"
                type="text"
                name="keyword"
                value="${keyword}"
                placeholder="Search products...">

            <select
                class="select"
                name="status">

                <option value="ALL"
                    ${empty status || status == 'ALL' ? 'selected' : ''}>
                    All Products
                </option>

                <option value="ACTIVE"
                    ${status == 'ACTIVE' ? 'selected' : ''}>
                    Active
                </option>

                <option value="INACTIVE"
                    ${status == 'INACTIVE' ? 'selected' : ''}>
                    Inactive
                </option>

            </select>

            <button
                type="submit"
                class="search-btn">
                Search
            </button>

            <a
                class="clear-btn"
                href="${pageContext.request.contextPath}/admin/products">
                Clear
            </a>

        </form>

    </div>


    <!-- ================= PRODUCTS ================= -->

    <div class="table-card">

        <div class="table-header">

            <div class="table-title">
                Product Catalog
            </div>

            <div class="product-count">

                <c:if test="${not empty totalProducts}">
                    ${totalProducts} products
                </c:if>

            </div>

        </div>


        <c:if test="${empty products}">

            <div class="empty">

                <div class="empty-icon">
                    📦
                </div>

                <h2>No Products Found</h2>

                <p>
                    No products match your current search or filter.
                </p>

            </div>

        </c:if>


        <c:if test="${not empty products}">

            <div class="table-scroll">

                <table class="product-table">

                    <thead>

                    <tr>

                        <th>ID</th>
                        <th>Product</th>
                        <th>Brand</th>
                        <th>Price</th>
                        <th>Discount</th>
                        <th>Stock</th>
                        <th>Status</th>
                        <th>Actions</th>

                    </tr>

                    </thead>

                    <tbody>

                    <c:forEach
                        var="product"
                        items="${products}">

                        <tr>

                            <td class="id">
                                #${product.productId}
                            </td>


                            <td>

                                <div class="product-name">

                                    <div class="product-image">
                                        📦
                                    </div>

                                    <div class="product-info">

                                        <strong>
                                            ${product.name}
                                        </strong>

                                        <span>
                                            Product ID: ${product.productId}
                                        </span>

                                    </div>

                                </div>

                            </td>


                            <td class="brand">
                                ${product.brand}
                            </td>


                            <td class="price">
                                ₹${product.price}
                            </td>


                            <td class="discount">
                                ${product.discount}%
                            </td>


                            <td>

                                <c:choose>

                                    <c:when test="${product.stock <= 0}">

                                        <span class="stock out">
                                            Out of stock
                                        </span>

                                    </c:when>

                                    <c:when test="${product.stock <= 5}">

                                        <span class="stock low">
                                            ${product.stock} • Low
                                        </span>

                                    </c:when>

                                    <c:otherwise>

                                        <span class="stock good">
                                            ${product.stock} • In stock
                                        </span>

                                    </c:otherwise>

                                </c:choose>

                            </td>


                            <td>

                                <c:choose>

                                    <c:when test="${product.status}">

                                        <span class="status active">
                                            ACTIVE
                                        </span>

                                    </c:when>

                                    <c:otherwise>

                                        <span class="status inactive">
                                            INACTIVE
                                        </span>

                                    </c:otherwise>

                                </c:choose>

                            </td>


                            <td>

                                <div class="actions">

                                    <a
                                        class="action-btn edit"
                                        href="${pageContext.request.contextPath}/admin/edit-product?id=${product.productId}">
                                        Edit
                                    </a>


                                    <c:choose>

                                        <c:when test="${product.status}">

                                            <form
                                                method="post"
                                                action="${pageContext.request.contextPath}/admin/products/deactivate"
                                                style="display:inline;">

                                                <input
                                                    type="hidden"
                                                    name="id"
                                                    value="${product.productId}">

                                                <button
                                                    type="submit"
                                                    class="action-btn deactivate"
                                                    onclick="return confirm('Are you sure you want to deactivate this product?');">
                                                    Deactivate
                                                </button>

                                            </form>

                                        </c:when>


                                        <c:otherwise>

                                            <form
                                                method="post"
                                                action="${pageContext.request.contextPath}/admin/products/activate"
                                                style="display:inline;">

                                                <input
                                                    type="hidden"
                                                    name="id"
                                                    value="${product.productId}">

                                                <button
                                                    type="submit"
                                                    class="action-btn activate">
                                                    Activate
                                                </button>

                                            </form>

                                        </c:otherwise>

                                    </c:choose>

                                </div>

                            </td>

                        </tr>

                    </c:forEach>

                    </tbody>

                </table>

            </div>


            <!-- ================= PAGINATION ================= -->

            <c:if test="${totalPages > 1}">

                <div class="pagination-wrapper">

                    <div class="pagination-info">

                        Showing page
                        <strong>${currentPage}</strong>
                        of
                        <strong>${totalPages}</strong>

                        &nbsp;•&nbsp;

                        Total:
                        <strong>${totalProducts}</strong>

                    </div>


                    <div class="pagination">

                        <c:choose>

                            <c:when test="${currentPage > 1}">

                                <a
                                    class="page-btn"
                                    href="${pageContext.request.contextPath}/admin/products?keyword=${keyword}&status=${status}&page=${currentPage - 1}">
                                    ‹
                                </a>

                            </c:when>

                            <c:otherwise>

                                <span class="page-btn disabled">
                                    ‹
                                </span>

                            </c:otherwise>

                        </c:choose>


                        <c:forEach
                            var="pageNum"
                            begin="1"
                            end="${totalPages}">

                            <c:choose>

                                <c:when test="${pageNum == currentPage}">

                                    <span class="page-btn active">
                                        ${pageNum}
                                    </span>

                                </c:when>

                                <c:otherwise>

                                    <a
                                        class="page-btn"
                                        href="${pageContext.request.contextPath}/admin/products?keyword=${keyword}&status=${status}&page=${pageNum}">
                                        ${pageNum}
                                    </a>

                                </c:otherwise>

                            </c:choose>

                        </c:forEach>


                        <c:choose>

                            <c:when test="${currentPage < totalPages}">

                                <a
                                    class="page-btn"
                                    href="${pageContext.request.contextPath}/admin/products?keyword=${keyword}&status=${status}&page=${currentPage + 1}">
                                    ›
                                </a>

                            </c:when>

                            <c:otherwise>

                                <span class="page-btn disabled">
                                    ›
                                </span>

                            </c:otherwise>

                        </c:choose>

                    </div>

                </div>

            </c:if>

        </c:if>

    </div>


    <div class="footer">
        ShopSphere Admin Panel • Product Management
    </div>

</main>

</body>
</html> 