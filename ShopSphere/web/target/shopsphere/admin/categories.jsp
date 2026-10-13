<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>ShopSphere Admin - Categories</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/admin.css">

    <style>

        .category-id {
            color: #64748b;
            font-weight: 700;
        }

        .category-name {
            display: flex;
            align-items: center;
            gap: 11px;
            font-weight: 800;
        }

        .category-icon {
            width: 40px;
            height: 40px;
            border-radius: 12px;

            display: flex;
            align-items: center;
            justify-content: center;

            background: linear-gradient(135deg,#dbeafe,#ede9fe);

            color: #2563eb;

            font-size: 11px;
            font-weight: 900;

            flex-shrink: 0;
        }

        .category-description {
            max-width: 380px;
            color: #64748b;
            line-height: 1.5;
        }

        .category-actions {
            display: flex;
            align-items: center;
            gap: 7px;
            flex-wrap: wrap;
        }

        .category-actions form {
            margin: 0;
        }

        .category-count {
            padding: 7px 11px;
            border-radius: 20px;

            background: #eff6ff;
            color: #2563eb;

            font-size: 10px;
            font-weight: 800;

            white-space: nowrap;
        }

        .category-status {
            display: inline-flex;
            align-items: center;
            gap: 7px;

            padding: 7px 12px;

            border-radius: 20px;

            font-size: 10px;
            font-weight: 800;

            text-transform: uppercase;
        }

        .category-status::before {
            content: "";
            width: 7px;
            height: 7px;
            border-radius: 50%;
            background: currentColor;
        }

        .category-status-active {
            background: #dcfce7;
            color: #15803d;
        }

        .category-status-inactive {
            background: #fee2e2;
            color: #dc2626;
        }

        .category-search {
            padding: 15px 20px;

            display: flex;
            align-items: center;
            justify-content: space-between;

            gap: 15px;

            border-bottom: 1px solid #eef2f7;

            background: #fafbfc;
        }

        .category-search-text {
            color: #64748b;
            font-size: 12px;
        }

        .category-table-card {
            overflow: hidden;
        }

        .empty-category {
            padding: 70px 25px;
            text-align: center;
        }

        .empty-category-icon {
            width: 75px;
            height: 75px;

            margin: 0 auto 18px;

            display: flex;
            align-items: center;
            justify-content: center;

            border-radius: 22px;

            background: linear-gradient(135deg,#dbeafe,#ede9fe);

            color: #2563eb;

            font-size: 14px;
            font-weight: 900;
        }

        .empty-category h2 {
            margin: 0 0 8px;
        }

        .empty-category p {
            color: #64748b;
            margin-bottom: 22px;
        }

        @media (max-width: 750px) {

            .category-search {
                align-items: flex-start;
                flex-direction: column;
            }

            .admin-table-wrapper {
                overflow-x: auto;
            }

        }

    </style>

</head>


<body>


<nav class="admin-navbar">


    <div class="admin-brand">

        <div class="admin-brand-icon">
            SS
        </div>

        <span>
            ShopSphere Admin
        </span>

    </div>


    <div class="admin-nav">

        <a href="${pageContext.request.contextPath}/admin/dashboard">
            Dashboard
        </a>

        <a href="${pageContext.request.contextPath}/admin/products">
            Products
        </a>

        <a class="nav-primary"
           href="${pageContext.request.contextPath}/admin/categories">
            Categories
        </a>

        <a href="${pageContext.request.contextPath}/admin/customers">
            Customers
        </a>

        <a href="${pageContext.request.contextPath}/admin/orders">
            Orders
        </a>

    </div>


</nav>


<main class="admin-container">


    <div class="admin-page-header">


        <div class="admin-title-area">


            <div class="admin-page-icon">
                CAT
            </div>


            <div>

                <h1 class="admin-page-title">
                    Manage Categories
                </h1>

                <p class="admin-page-subtitle">
                    Create, update and manage your product categories.
                </p>

            </div>


        </div>


        <a href="${pageContext.request.contextPath}/admin/categories/add"
           class="admin-btn btn-success">

            + Add Category

        </a>


    </div>


    <c:if test="${param.success != null}">

        <div class="admin-alert alert-success">

            Category operation completed successfully.

        </div>

    </c:if>


    <c:if test="${param.error != null}">

        <div class="admin-alert alert-error">

            Category operation failed.
            Please try again.

        </div>

    </c:if>


    <c:set var="totalCategories" value="0"/>
    <c:set var="activeCategories" value="0"/>
    <c:set var="inactiveCategories" value="0"/>


    <c:forEach var="category"
               items="${categories}">

        <c:set var="totalCategories"
               value="${totalCategories + 1}"/>

        <c:choose>

            <c:when test="${category.status}">

                <c:set var="activeCategories"
                       value="${activeCategories + 1}"/>

            </c:when>

            <c:otherwise>

                <c:set var="inactiveCategories"
                       value="${inactiveCategories + 1}"/>

            </c:otherwise>

        </c:choose>

    </c:forEach>


    <div class="admin-stats">


        <div class="admin-stat">

            <div class="admin-stat-icon stat-blue">
                CAT
            </div>

            <div>

                <div class="admin-stat-label">
                    Total Categories
                </div>

                <div class="admin-stat-value">
                    ${totalCategories}
                </div>

            </div>

        </div>


        <div class="admin-stat">

            <div class="admin-stat-icon stat-green">
                OK
            </div>

            <div>

                <div class="admin-stat-label">
                    Active Categories
                </div>

                <div class="admin-stat-value">
                    ${activeCategories}
                </div>

            </div>

        </div>


        <div class="admin-stat">

            <div class="admin-stat-icon stat-red">
                !
            </div>

            <div>

                <div class="admin-stat-label">
                    Inactive Categories
                </div>

                <div class="admin-stat-value">
                    ${inactiveCategories}
                </div>

            </div>

        </div>


        <div class="admin-stat">

            <div class="admin-stat-icon stat-orange">
                LIVE
            </div>

            <div>

                <div class="admin-stat-label">
                    Current Status
                </div>

                <div class="admin-stat-value">

                    <c:choose>

                        <c:when test="${totalCategories > 0}">
                            Live
                        </c:when>

                        <c:otherwise>
                            Empty
                        </c:otherwise>

                    </c:choose>

                </div>

            </div>

        </div>


    </div>


    <section class="admin-card category-table-card">


        <div class="admin-card-header">

            <div>

                <div class="admin-card-title">
                    Product Categories
                </div>

                <div class="admin-card-subtitle">
                    Manage category information and availability.
                </div>

            </div>


            <span class="category-count">

                ${totalCategories} Categories

            </span>


        </div>


        <div class="category-search">


            <div class="category-search-text">

                Organize products into clear and manageable categories.

            </div>


           


        </div>


        <c:choose>


            <c:when test="${not empty categories}">


                <div class="admin-table-wrapper">


                    <table class="admin-table">


                        <thead>

                        <tr>

                            <th>ID</th>

                            <th>Category</th>

                            <th>Description</th>

                            <th>Status</th>

                            <th>Actions</th>

                        </tr>

                        </thead>


                        <tbody>


                        <c:forEach var="category"
                                   items="${categories}">


                            <tr>


                                <td>

                                    <span class="category-id">

                                        #${category.categoryId}

                                    </span>

                                </td>


                                <td>

                                    <div class="category-name">


                                        <div class="category-icon">
                                            CAT
                                        </div>


                                        <span>
                                            ${category.name}
                                        </span>


                                    </div>

                                </td>


                                <td>


                                    <div class="category-description">


                                        <c:choose>

                                            <c:when test="${not empty category.description}">

                                                ${category.description}

                                            </c:when>


                                            <c:otherwise>

                                                <span style="color:#94a3b8;">

                                                    No description available

                                                </span>

                                            </c:otherwise>

                                        </c:choose>


                                    </div>


                                </td>


                                <td>


                                    <c:choose>


                                        <c:when test="${category.status}">

                                            <span class="category-status category-status-active">

                                                Active

                                            </span>

                                        </c:when>


                                        <c:otherwise>

                                            <span class="category-status category-status-inactive">

                                                Inactive

                                            </span>

                                        </c:otherwise>


                                    </c:choose>


                                </td>


                                <td>


                                    <div class="category-actions">


                                        <a href="${pageContext.request.contextPath}/admin/edit-category?id=${category.categoryId}"
                                           class="admin-action action-edit">

                                            Edit

                                        </a>


                                        <c:choose>


                                            <c:when test="${category.status}">


                                                <form method="post"
                                                      action="${pageContext.request.contextPath}/admin/categories/deactivate">


                                                    <input type="hidden"
                                                           name="id"
                                                           value="${category.categoryId}">


                                                    <button type="submit"
                                                            class="admin-action action-delete"
                                                            onclick="return confirm('Are you sure you want to deactivate this category?');">

                                                        Deactivate

                                                    </button>


                                                </form>


                                            </c:when>


                                            <c:otherwise>


                                                <form method="post"
                                                      action="${pageContext.request.contextPath}/admin/categories/activate">


                                                    <input type="hidden"
                                                           name="id"
                                                           value="${category.categoryId}">


                                                    <button type="submit"
                                                            class="admin-action action-activate">

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


            </c:when>


            <c:otherwise>


                <div class="empty-category">


                    <div class="empty-category-icon">
                        CAT
                    </div>


                    <h2>
                        No Categories Found
                    </h2>


                    <p>
                        You haven't created any product categories yet.
                    </p>


                    <a href="${pageContext.request.contextPath}/admin/categories/add"
                       class="admin-btn btn-success">

                        + Create Category

                    </a>


                </div>


            </c:otherwise>


        </c:choose>


    </section>


</main>


<footer class="admin-footer">

    ShopSphere Admin Panel · Category Management

</footer>


</body>

</html>