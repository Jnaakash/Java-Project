<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>

<head>

    <title>ShopSphere - Edit Product</title>

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
            max-width: 700px;
            margin: auto;
        }

        .card {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
        }

        h1 {
            margin-top: 0;
            margin-bottom: 25px;
        }

        .form-group {
            margin-bottom: 18px;
        }

        label {
            display: block;
            margin-bottom: 7px;
            font-weight: bold;
        }

        input,
        textarea,
        select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 15px;
        }

        input:focus,
        textarea:focus,
        select:focus {
            outline: none;
            border-color: #2563eb;
        }

        textarea {
            min-height: 100px;
            resize: vertical;
        }

        .button {
            display: inline-block;
            padding: 11px 18px;
            border: none;
            border-radius: 6px;
            color: white;
            background: #2563eb;
            cursor: pointer;
            font-size: 15px;
            text-decoration: none;
        }

        .button:hover {
            background: #1d4ed8;
        }

        .back {
            background: #64748b;
            margin-left: 8px;
        }

        .back:hover {
            background: #475569;
        }

        .error {
            background: #fee2e2;
            color: #991b1b;
            padding: 12px;
            border-radius: 6px;
            margin-bottom: 20px;
        }

        .info {
            background: #eff6ff;
            color: #1e40af;
            padding: 12px;
            border-radius: 6px;
            margin-bottom: 20px;
        }

    </style>

</head>

<body>

<div class="container">

    <div class="card">

        <h1>✏️ Edit Product</h1>


        <!-- ERROR MESSAGE -->

        <c:if test="${param.error == '1'}">

            <div class="error">

                Unable to update product.
                Please check the entered information.

            </div>

        </c:if>


        <!-- PRODUCT INFORMATION -->

        <div class="info">

            Product ID:
            <strong>${product.productId}</strong>

        </div>


        <!-- EDIT FORM -->

        <form
            action="${pageContext.request.contextPath}/admin/edit-product"
            method="post">


            <!-- PRODUCT ID -->

            <input
                type="hidden"
                name="productId"
                value="${product.productId}">


            <!-- CATEGORY -->

            <div class="form-group">

                <label for="categoryId">
                    Category
                </label>

                <select
                    id="categoryId"
                    name="categoryId"
                    required>

                    <option value="">
                        -- Select Category --
                    </option>

                    <c:forEach
                        var="category"
                        items="${categories}">

                        <option
                            value="${category.categoryId}"
                            <c:if test="${category.categoryId == product.categoryId}">
                                selected
                            </c:if>>

                            ${category.name}

                        </option>

                    </c:forEach>

                </select>

            </div>


            <!-- NAME -->

            <div class="form-group">

                <label for="name">
                    Product Name
                </label>

                <input
                    type="text"
                    id="name"
                    name="name"
                    value="${product.name}"
                    maxlength="255"
                    required>

            </div>


            <!-- BRAND -->

            <div class="form-group">

                <label for="brand">
                    Brand
                </label>

                <input
                    type="text"
                    id="brand"
                    name="brand"
                    value="${product.brand}"
                    maxlength="100"
                    required>

            </div>


            <!-- DESCRIPTION -->

            <div class="form-group">

                <label for="description">
                    Description
                </label>

                <textarea
                    id="description"
                    name="description"
                    required>${product.description}</textarea>

            </div>


            <!-- PRICE -->

            <div class="form-group">

                <label for="price">
                    Price (₹)
                </label>

                <input
                    type="number"
                    id="price"
                    name="price"
                    step="0.01"
                    min="0"
                    value="${product.price}"
                    required>

            </div>


            <!-- DISCOUNT -->

            <div class="form-group">

                <label for="discount">
                    Discount (%)
                </label>

                <input
                    type="number"
                    id="discount"
                    name="discount"
                    step="0.01"
                    min="0"
                    max="100"
                    value="${product.discount}"
                    required>

            </div>


            <!-- STOCK -->

            <div class="form-group">

                <label for="stock">
                    Stock
                </label>

                <input
                    type="number"
                    id="stock"
                    name="stock"
                    min="0"
                    value="${product.stock}"
                    required>

            </div>


            <!-- IMAGE URL -->

            <div class="form-group">

                <label for="imageUrl">
                    Image URL
                </label>

                <input
                    type="text"
                    id="imageUrl"
                    name="imageUrl"
                    value="${product.imageUrl}">

            </div>


            <!-- STATUS -->

            <div class="form-group">

                <label for="status">
                    Status
                </label>

                <select
                    id="status"
                    name="status">

                    <option
                        value="true"
                        <c:if test="${product.status}">
                            selected
                        </c:if>>
                        Active
                    </option>

                    <option
                        value="false"
                        <c:if test="${not product.status}">
                            selected
                        </c:if>>
                        Inactive
                    </option>

                </select>

            </div>


            <!-- BUTTONS -->

            <button
                type="submit"
                class="button">

                Update Product

            </button>


            <a
                class="button back"
                href="${pageContext.request.contextPath}/admin/products">

                Cancel

            </a>

        </form>

    </div>

</div>

</body>

</html>