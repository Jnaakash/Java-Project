<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>

<head>

    <title>ShopSphere - Manage Categories</title>

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
            max-width: 1100px;
            margin: auto;
        }

        /* =========================
           TOP BAR
           ========================= */

        .top-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
            gap: 15px;
        }

        h1 {
            margin: 0;
            font-size: 36px;
        }

        .subtitle {
            color: #666;
            margin-top: 8px;
            font-size: 18px;
        }

        /* =========================
           TOP BUTTONS
           ========================= */

        .buttons {
            display: flex;
            gap: 12px;
            flex-wrap: wrap;
        }

        .button {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 12px 20px;
            border-radius: 7px;
            text-decoration: none !important;
            color: white !important;
            font-weight: 600;
            font-size: 15px;
            transition: 0.2s ease;
        }

        .dashboard {
            background: #64748b;
        }

        .dashboard:hover {
            background: #475569;
        }

        .add {
            background: #16a34a;
        }

        .add:hover {
            background: #15803d;
        }

        .button:hover {
            transform: translateY(-1px);
        }

        /* =========================
           MESSAGES
           ========================= */

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

        /* =========================
           TABLE
           ========================= */

        .table-container {
            background: white;
            border-radius: 10px;
            overflow-x: auto;
            box-shadow: 0 3px 12px rgba(0, 0, 0, .08);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            min-width: 750px;
        }

        th,
        td {
            padding: 15px;
            border-bottom: 1px solid #eee;
            text-align: left;
        }

        th {
            background: #1e293b;
            color: white;
            font-size: 16px;
        }

        td {
            font-size: 16px;
        }

        tr:hover {
            background: #f8fafc;
        }

        /* =========================
           STATUS
           ========================= */

        .status {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 6px 12px;
            border-radius: 6px;
            font-size: 13px;
            font-weight: bold;
        }

        .active {
            background: #dcfce7;
            color: #166534;
        }

        .inactive {
            background: #fee2e2;
            color: #991b1b;
        }

        /* =========================
           ACTION BUTTONS
           ========================= */

        .action-buttons {
            display: flex;
            align-items: center;
            gap: 8px;
            flex-wrap: wrap;
        }

        .action-btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            min-width: 75px;
            padding: 8px 14px;
            border: none;
            border-radius: 6px;
            font-family: Arial, sans-serif;
            font-size: 13px;
            font-weight: 600;
            text-decoration: none !important;
            cursor: pointer;
            transition: all 0.2s ease;
        }

        /* EDIT */

        .edit-btn {
            background: #2563eb;
            color: white !important;
        }

        .edit-btn:hover {
            background: #1d4ed8;
            transform: translateY(-1px);
        }

        /* DEACTIVATE */

        .deactivate-btn {
            background: #dc2626;
            color: white !important;
        }

        .deactivate-btn:hover {
            background: #b91c1c;
            transform: translateY(-1px);
        }

        /* ACTIVATE */

        .activate-btn {
            background: #16a34a;
            color: white !important;
        }

        .activate-btn:hover {
            background: #15803d;
            transform: translateY(-1px);
        }

        /* =========================
           EMPTY STATE
           ========================= */

        .empty {
            background: white;
            padding: 45px;
            text-align: center;
            border-radius: 10px;
            box-shadow: 0 3px 12px rgba(0, 0, 0, .08);
        }

        .empty h2 {
            margin-bottom: 10px;
        }

        .empty p {
            color: #666;
        }

        /* =========================
           MOBILE
           ========================= */

        @media (max-width: 700px) {

            body {
                padding: 15px;
            }

            .top-bar {
                flex-direction: column;
                align-items: flex-start;
            }

            h1 {
                font-size: 28px;
            }

            .subtitle {
                font-size: 16px;
            }

            .buttons {
                width: 100%;
            }

            .button {
                flex: 1;
            }

            .action-buttons {
                flex-direction: column;
                align-items: flex-start;
            }

        }

    </style>

</head>


<body>

<div class="container">

    <!-- =========================
         TOP BAR
         ========================= -->

    <div class="top-bar">

        <div>

            <h1>📂 Manage Categories</h1>

            <p class="subtitle">
                Add, edit and manage product categories.
            </p>

        </div>


        <div class="buttons">

            <a
                class="button dashboard"
                href="${pageContext.request.contextPath}/admin/dashboard">

                ← Dashboard

            </a>


            <a
                class="button add"
                href="${pageContext.request.contextPath}/admin/categories/add">

                + Add Category

            </a>

        </div>

    </div>


    <!-- =========================
         SUCCESS MESSAGES
         ========================= -->

    <c:if test="${param.success == 'added'}">

        <div class="message success">
            Category added successfully.
        </div>

    </c:if>


    <c:if test="${param.success == 'updated'}">

        <div class="message success">
            Category updated successfully.
        </div>

    </c:if>


    <c:if test="${param.success == 'activated'}">

        <div class="message success">
            Category activated successfully.
        </div>

    </c:if>


    <c:if test="${param.success == 'deactivated'}">

        <div class="message success">
            Category deactivated successfully.
        </div>

    </c:if>


    <!-- =========================
         ERROR MESSAGE
         ========================= -->

    <c:if test="${param.error != null}">

        <div class="message error">
            Something went wrong. Please try again.
        </div>

    </c:if>


    <!-- =========================
         EMPTY CATEGORY LIST
         ========================= -->

    <c:if test="${empty categories}">

        <div class="empty">

            <h2>No Categories Found</h2>

            <p>
                No categories are currently available.
            </p>

        </div>

    </c:if>


    <!-- =========================
         CATEGORY TABLE
         ========================= -->

    <c:if test="${not empty categories}">

        <div class="table-container">

            <table>

                <thead>

                    <tr>

                        <th>ID</th>

                        <th>Name</th>

                        <th>Description</th>

                        <th>Status</th>

                        <th>Actions</th>

                    </tr>

                </thead>


                <tbody>

                    <c:forEach
                        var="category"
                        items="${categories}">

                        <tr>

                            <!-- CATEGORY ID -->

                            <td>
                                ${category.categoryId}
                            </td>


                            <!-- CATEGORY NAME -->

                            <td>

                                <strong>
                                    ${category.name}
                                </strong>

                            </td>


                            <!-- DESCRIPTION -->

                            <td>
                                ${category.description}
                            </td>


                            <!-- STATUS -->

                            <td>

                                <c:choose>

                                    <c:when test="${category.status}">

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


                            <!-- ACTIONS -->

                            <td>

    <div class="action-buttons">

        <a
            href="${pageContext.request.contextPath}/admin/categories/edit?id=${category.categoryId}"
            class="action-btn edit-btn">
            Edit
        </a>

        <c:choose>

            <c:when test="${category.status}">

                <form
                    method="post"
                    action="${pageContext.request.contextPath}/admin/categories/deactivate"
                    style="display:inline; margin:0;">

                    <input
                        type="hidden"
                        name="id"
                        value="${category.categoryId}">

                    <button
                        type="submit"
                        class="action-btn deactivate-btn"
                        onclick="return confirm('Are you sure you want to deactivate this category?');">
                        Deactivate
                    </button>

                </form>

            </c:when>

            <c:otherwise>

                <form
                    method="post"
                    action="${pageContext.request.contextPath}/admin/categories/activate"
                    style="display:inline; margin:0;">

                    <input
                        type="hidden"
                        name="id"
                        value="${category.categoryId}">

                    <button
                        type="submit"
                        class="action-btn activate-btn"
                        onclick="return confirm('Are you sure you want to activate this category?');">
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

    </c:if>

</div>

</body>

</html>