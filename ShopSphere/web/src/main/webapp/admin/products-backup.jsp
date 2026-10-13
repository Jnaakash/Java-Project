<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>

<head>

    <title>ShopSphere - Manage Products</title>

    <style>

        * {
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
            background: #f5f5f5;
            margin: 0;
            padding: 30px;
            color: #222;
        }

        .container {
            max-width: 1200px;
            margin: auto;
        }

        h1 {
            margin-bottom: 10px;
        }

        .top-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
        }

        .top-bar p {
            color: #666;
        }

        .filter-box {
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 3px 12px rgba(0, 0, 0, .08);
            margin-bottom: 25px;
        }

        .filter-form {
            display: flex;
            gap: 12px;
            flex-wrap: wrap;
            align-items: center;
        }

        .filter-input,
        .filter-select {
            padding: 11px 14px;
            border: 1px solid #d1d5db;
            border-radius: 6px;
            font-size: 14px;
        }

        .filter-input {
            flex: 1;
            min-width: 250px;
        }

        .filter-select {
            min-width: 150px;
            background: white;
        }

        .search-btn {
            border: none;
            padding: 11px 20px;
            border-radius: 6px;
            background: #2563eb;
            color: white;
            cursor: pointer;
            font-weight: 600;
        }

        .clear-btn {
            display: inline-block;
            padding: 11px 20px;
            border-radius: 6px;
            background: #6b7280;
            color: white;
            text-decoration: none;
            font-weight: 600;
        }

        .search-btn:hover,
        .clear-btn:hover {
            opacity: .85;
        }

        .product-table {
            width: 100%;
            background: white;
            border-collapse: collapse;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
        }

        .product-table th,
        .product-table td {
            padding: 14px;
            border-bottom: 1px solid #eee;
            text-align: left;
        }

        .product-table th {
            background: #1e293b;
            color: white;
        }

        .product-table tr:hover {
            background: #f8fafc;
        }

        .price {
            font-weight: bold;
        }

        .stock {
            font-weight: bold;
        }

        .status {
            display: inline-block;
            padding: 6px 10px;
            border-radius: 5px;
            font-size: 13px;
            font-weight: bold;
        }

        .status.active {
            background: #dcfce7;
            color: #166534;
        }

        .status.inactive {
            background: #fee2e2;
            color: #991b1b;
        }

        .button {
            display: inline-block;
            padding: 9px 14px;
            background: #2563eb;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            margin-right: 5px;
        }

        .button:hover {
            opacity: .85;
        }

        .back {
            background: #64748b;
        }

        .add {
            background: #16a34a;
        }

        .add:hover {
            background: #15803d;
        }

        .action-btn {
            border: none;
            display: inline-block;
            padding: 8px 12px;
            border-radius: 5px;
            color: white;
            cursor: pointer;
            text-decoration: none;
            font-size: 13px;
            font-weight: 600;
            margin-right: 5px;
        }

        .edit {
            background: #f59e0b;
        }

        .edit:hover {
            background: #d97706;
        }

        .deactivate {
            background: #dc2626;
        }

        .deactivate:hover {
            background: #b91c1c;
        }

        .activate {
            background: #16a34a;
        }

        .activate:hover {
            background: #15803d;
        }

        .empty {
            background: white;
            padding: 40px;
            text-align: center;
            border-radius: 8px;
        }

        .message {
            padding: 13px 16px;
            border-radius: 8px;
            margin-bottom: 20px;
            font-weight: 600;
        }

        .success {
            background: #d1e7dd;
            color: #0f5132;
            border: 1px solid #badbcc;
        }

        .error {
            background: #f8d7da;
            color: #842029;
            border: 1px solid #f5c2c7;
        }

        /* Pagination */

        .pagination-wrapper {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 20px;
            flex-wrap: wrap;
            gap: 15px;
        }

        .pagination-info {
            color: #666;
            font-size: 14px;
        }

        .pagination {
            display: flex;
            gap: 6px;
            align-items: center;
            flex-wrap: wrap;
        }

        .page-btn {
            display: inline-block;
            padding: 9px 13px;
            border: 1px solid #d1d5db;
            border-radius: 6px;
            background: white;
            color: #333;
            text-decoration: none;
            font-size: 14px;
            font-weight: 600;
        }

        .page-btn:hover {
            background: #f1f5f9;
        }

        .page-btn.active {
            background: #2563eb;
            color: white;
            border-color: #2563eb;
        }

        .page-btn.disabled {
            color: #9ca3af;
            background: #f3f4f6;
            cursor: not-allowed;
            pointer-events: none;
        }

        .page-dots {
            padding: 0 4px;
            color: #666;
        }

        @media (max-width: 800px) {

            body {
                padding: 15px;
            }

            .container {
                overflow-x: auto;
            }

            .top-bar {
                flex-direction: column;
                align-items: flex-start;
                gap: 15px;
            }

            .filter-form {
                flex-direction: column;
                align-items: stretch;
            }

            .filter-input,
            .filter-select,
            .search-btn,
            .clear-btn {
                width: 100%;
            }

            .product-table {
                min-width: 1000px;
            }

            .pagination-wrapper {
                flex-direction: column;
                align-items: flex-start;
            }

        }

    </style>

</head>

<body>

<div class="container">

    <div class="top-bar">

        <div>

            <h1>📦 Manage Products</h1>

            <p>
                View and manage ShopSphere products.
            </p>

        </div>

        <div>

            <a
                class="button back"
                href="${pageContext.request.contextPath}/admin/dashboard">

                ← Dashboard

            </a>

            <a
                class="button add"
                href="${pageContext.request.contextPath}/admin/add-product">

                + Add Product

            </a>

        </div>

    </div>


    <c:if test="${param.success == 'activated'}">

        <div class="message success">
            Product activated successfully.
        </div>

    </c:if>


    <c:if test="${param.success == 'deactivated'}">

        <div class="message success">
            Product deactivated successfully.
        </div>

    </c:if>


    <c:if test="${param.error == 'activate'}">

        <div class="message error">
            Product could not be activated.
        </div>

    </c:if>


    <c:if test="${param.error == 'deactivate'}">

        <div class="message error">
            Product could not be deactivated.
        </div>

    </c:if>


    <c:if test="${param.error == 'invalid'}">

        <div class="message error">
            Invalid product request.
        </div>

    </c:if>


    <c:if test="${param.error == 'server'}">

        <div class="message error">
            A server error occurred. Please try again.
        </div>

    </c:if>


    <div class="filter-box">

        <form
            method="get"
            action="${pageContext.request.contextPath}/admin/products"
            class="filter-form">

            <input
                type="text"
                name="keyword"
                class="filter-input"
                placeholder="Search by product name or brand..."
                value="${keyword}">

            <select
                name="status"
                class="filter-select">

                <option
                    value="ALL"
                    ${empty status || status == 'ALL' ? 'selected' : ''}>
                    All Status
                </option>

                <option
                    value="ACTIVE"
                    ${status == 'ACTIVE' ? 'selected' : ''}>
                    Active
                </option>

                <option
                    value="INACTIVE"
                    ${status == 'INACTIVE' ? 'selected' : ''}>
                    Inactive
                </option>

            </select>

            <button
                type="submit"
                class="search-btn">

                🔍 Search

            </button>

            <a
                href="${pageContext.request.contextPath}/admin/products"
                class="clear-btn">

                Clear

            </a>

        </form>

    </div>


    <c:if test="${empty products}">

        <div class="empty">

            <h2>No Products Found</h2>

            <p>
                No products match your search or filter.
            </p>

        </div>

    </c:if>


    <c:if test="${not empty products}">

        <table class="product-table">

            <thead>

                <tr>

                    <th>ID</th>
                    <th>Name</th>
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

                        <td>
                            ${product.productId}
                        </td>

                        <td>

                            <strong>
                                ${product.name}
                            </strong>

                        </td>

                        <td>
                            ${product.brand}
                        </td>

                        <td class="price">
                            ₹${product.price}
                        </td>

                        <td>
                            ${product.discount}%
                        </td>

                        <td class="stock">
                            ${product.stock}
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

                        </td>

                    </tr>

                </c:forEach>

            </tbody>

        </table>


        <c:if test="${totalPages > 1}">

            <div class="pagination-wrapper">

                <div class="pagination-info">

                    Showing page
                    <strong>${currentPage}</strong>
                    of
                    <strong>${totalPages}</strong>

                    |
                    Total products:
                    <strong>${totalProducts}</strong>

                </div>


                <div class="pagination">

                    <c:choose>

                        <c:when test="${currentPage > 1}">

                            <a
                                class="page-btn"
                                href="${pageContext.request.contextPath}/admin/products?keyword=${keyword}&status=${status}&page=${currentPage - 1}">

                                ← Previous

                            </a>

                        </c:when>

                        <c:otherwise>

                            <span class="page-btn disabled">
                                ← Previous
                            </span>

                        </c:otherwise>

                    </c:choose>


                    <c:forEach
                        begin="1"
                        end="${totalPages}"
                        var="pageNumber">

                        <a
                            class="page-btn ${pageNumber == currentPage ? 'active' : ''}"
                            href="${pageContext.request.contextPath}/admin/products?keyword=${keyword}&status=${status}&page=${pageNumber}">

                            ${pageNumber}

                        </a>

                    </c:forEach>


                    <c:choose>

                        <c:when test="${currentPage < totalPages}">

                            <a
                                class="page-btn"
                                href="${pageContext.request.contextPath}/admin/products?keyword=${keyword}&status=${status}&page=${currentPage + 1}">

                                Next →

                            </a>

                        </c:when>

                        <c:otherwise>

                            <span class="page-btn disabled">
                                Next →
                            </span>

                        </c:otherwise>

                    </c:choose>

                </div>

            </div>

        </c:if>

    </c:if>

</div>

</body>

</html>