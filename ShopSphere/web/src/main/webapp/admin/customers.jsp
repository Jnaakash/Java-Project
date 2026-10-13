<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>

    <meta charset="UTF-8">

    <title>Manage Customers - ShopSphere</title>

    <style>

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: Arial, sans-serif;
            background: #f5f6fa;
            color: #222;
        }

        .header {
            background: #111827;
            color: white;
            padding: 20px 40px;

            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .header h1 {
            font-size: 26px;
        }

        .header-buttons {
            display: flex;
            gap: 10px;
        }

        .header a {
            color: white;
            text-decoration: none;
            padding: 10px 18px;
            border-radius: 6px;
        }

        .dashboard-btn {
            background: #2563eb;
        }

        .logout-btn {
            background: #dc2626;
        }

        .header a:hover {
            opacity: 0.85;
        }

        .container {
            padding: 40px;
        }

        .page-header {
            margin-bottom: 25px;
        }

        .page-header h2 {
            margin-bottom: 8px;
        }

        .page-header p {
            color: #666;
        }

        .message {
            padding: 13px 16px;
            border-radius: 8px;
            margin-bottom: 20px;
            font-weight: 600;
        }

        .message.success {
            background: #d1e7dd;
            color: #0f5132;
            border: 1px solid #badbcc;
        }

        .message.error {
            background: #f8d7da;
            color: #842029;
            border: 1px solid #f5c2c7;
        }

        .customer-card {
            background: white;
            padding: 25px;
            border-radius: 10px;

            box-shadow:
                0 3px 12px rgba(0, 0, 0, 0.08);

            overflow-x: auto;
        }

        .customer-count {
            margin-bottom: 15px;
            color: #555;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            min-width: 850px;
        }

        th {
            background: #f3f4f6;
            padding: 14px;
            text-align: left;
            font-size: 14px;
        }

        td {
            padding: 14px;
            border-bottom: 1px solid #e5e7eb;
        }

        tr:hover {
            background: #f9fafb;
        }

        .status {
            display: inline-block;
            padding: 6px 10px;
            border-radius: 5px;
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

        .action-btn {
            border: none;
            padding: 8px 14px;
            border-radius: 6px;
            cursor: pointer;

            font-size: 13px;
            font-weight: 600;
        }

        .action-btn:hover {
            opacity: 0.85;
        }

        .action-btn.deactivate {
            background: #dc3545;
            color: white;
        }

        .action-btn.activate {
            background: #198754;
            color: white;
        }

        .empty {
            text-align: center;
            padding: 30px;
            color: #666;
        }

        @media (max-width: 700px) {

            .container {
                padding: 20px;
            }

            .header {
                padding: 18px 20px;
            }

            .header h1 {
                font-size: 20px;
            }

            .header-buttons {
                flex-direction: column;
            }

        }

    </style>

</head>

<body>


<div class="header">

    <h1>ShopSphere Admin</h1>

    <div class="header-buttons">

        <a class="dashboard-btn"
           href="${pageContext.request.contextPath}/admin/dashboard">
            Dashboard
        </a>

        <a class="logout-btn"
           href="${pageContext.request.contextPath}/logout">
            Logout
        </a>

    </div>

</div>


<div class="container">


    <div class="page-header">

        <h2>Manage Customers</h2>

        <p>
            View and manage registered ShopSphere customers.
        </p>

    </div>


    <c:if test="${param.success == 'updated'}">

        <div class="message success">
            Customer status updated successfully.
        </div>

    </c:if>


    <c:if test="${param.error == 'invalid'}">

        <div class="message error">
            Invalid customer status request.
        </div>

    </c:if>


    <c:if test="${param.error == 'update'}">

        <div class="message error">
            Customer status could not be updated.
        </div>

    </c:if>


    <c:if test="${param.error == 'server'}">

        <div class="message error">
            A server error occurred. Please try again.
        </div>

    </c:if>


    <div class="customer-card">

        <div class="customer-count">

            Total Customers:

            <strong>
                ${customers.size()}
            </strong>

        </div>


        <table>

            <thead>

                <tr>

                    <th>User ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Mobile</th>
                    <th>Role</th>
                    <th>Status</th>
                    <th>Action</th>

                </tr>

            </thead>


            <tbody>

                <c:forEach var="customer"
                           items="${customers}">

                    <tr>

                        <td>
                            #${customer.userId}
                        </td>

                        <td>
                            ${customer.name}
                        </td>

                        <td>
                            ${customer.email}
                        </td>

                        <td>
                            ${customer.mobile}
                        </td>

                        <td>
                            ${customer.role}
                        </td>

                        <td>

                            <c:choose>

                                <c:when test="${customer.status}">
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

                            <c:choose>

                                <c:when test="${customer.status}">

                                    <form method="post"
                                          action="${pageContext.request.contextPath}/admin/customer-status"
                                          style="display:inline;">

                                        <input type="hidden"
                                               name="userId"
                                               value="${customer.userId}">

                                        <input type="hidden"
                                               name="status"
                                               value="deactivate">

                                        <button type="submit"
                                                class="action-btn deactivate"
                                                onclick="return confirm('Are you sure you want to deactivate this customer?');">

                                            Deactivate

                                        </button>

                                    </form>

                                </c:when>

                                <c:otherwise>

                                    <form method="post"
                                          action="${pageContext.request.contextPath}/admin/customer-status"
                                          style="display:inline;">

                                        <input type="hidden"
                                               name="userId"
                                               value="${customer.userId}">

                                        <input type="hidden"
                                               name="status"
                                               value="activate">

                                        <button type="submit"
                                                class="action-btn activate">

                                            Activate

                                        </button>

                                    </form>

                                </c:otherwise>

                            </c:choose>

                        </td>

                    </tr>

                </c:forEach>


                <c:if test="${empty customers}">

                    <tr>

                        <td colspan="7"
                            class="empty">

                            No customers found.

                        </td>

                    </tr>

                </c:if>

            </tbody>

        </table>

    </div>

</div>

</body>
</html>