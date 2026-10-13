<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>

<head>

    <title>ShopSphere - Edit Category</title>

    <style>

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            padding: 30px;
            font-family: Arial, sans-serif;
            background: #f5f7fb;
            color: #222;
        }

        .container {
            max-width: 700px;
            margin: 30px auto;
        }

        .card {
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 4px 18px rgba(0, 0, 0, .08);
        }

        h1 {
            margin-top: 0;
            margin-bottom: 8px;
        }

        .subtitle {
            color: #666;
            margin-bottom: 25px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
        }

        input,
        textarea,
        select {
            width: 100%;
            padding: 12px;
            border: 1px solid #d1d5db;
            border-radius: 7px;
            font-size: 15px;
        }

        textarea {
            min-height: 120px;
            resize: vertical;
        }

        input:focus,
        textarea:focus,
        select:focus {
            outline: none;
            border-color: #2563eb;
        }

        .error {
            background: #fee2e2;
            color: #991b1b;
            padding: 12px;
            border-radius: 7px;
            margin-bottom: 20px;
        }

        .buttons {
            display: flex;
            gap: 10px;
            margin-top: 25px;
        }

        .btn {
            border: none;
            padding: 12px 20px;
            border-radius: 7px;
            color: white;
            font-weight: 600;
            cursor: pointer;
            text-decoration: none;
        }

        .save {
            background: #2563eb;
        }

        .cancel {
            background: #64748b;
        }

        .btn:hover {
            opacity: .88;
        }

    </style>

</head>

<body>

<div class="container">

    <div class="card">

        <h1>✏️ Edit Category</h1>

        <p class="subtitle">
            Update the category information.
        </p>


        <% if ("name".equals(request.getParameter("error"))) { %>

            <div class="error">
                Category name is required.
            </div>

        <% } %>


        <% if ("database".equals(request.getParameter("error"))) { %>

            <div class="error">
                Unable to update category.
                Please try again.
            </div>

        <% } %>


        <form
            method="post"
            action="${pageContext.request.contextPath}/admin/categories/edit">


            <input
                type="hidden"
                name="categoryId"
                value="${category.categoryId}">


            <div class="form-group">

                <label for="name">
                    Category Name
                </label>

                <input
                    type="text"
                    id="name"
                    name="name"
                    value="${category.name}"
                    maxlength="100"
                    required>

            </div>


            <div class="form-group">

                <label for="description">
                    Description
                </label>

                <textarea
                    id="description"
                    name="description"
                    maxlength="500">${category.description}</textarea>

            </div>


            <div class="form-group">

                <label for="status">
                    Status
                </label>

                <select
                    id="status"
                    name="status">

                    <option
                        value="true"
                        ${category.status ? 'selected' : ''}>
                        Active
                    </option>

                    <option
                        value="false"
                        ${not category.status ? 'selected' : ''}>
                        Inactive
                    </option>

                </select>

            </div>


            <div class="buttons">

                <button
                    type="submit"
                    class="btn save">

                    Update Category

                </button>


                <a
                    href="${pageContext.request.contextPath}/admin/categories"
                    class="btn cancel">

                    Cancel

                </a>

            </div>

        </form>

    </div>

</div>

</body>

</html>