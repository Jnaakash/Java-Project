<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>ShopSphere - Add Product</title>

    <link rel="preconnect"
          href="https://fonts.googleapis.com">

    <link rel="preconnect"
          href="https://fonts.gstatic.com"
          crossorigin>

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap"
          rel="stylesheet">

    <style>

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        :root {
            --primary: #2563eb;
            --primary-dark: #1d4ed8;
            --text: #0f172a;
            --muted: #64748b;
            --border: #e2e8f0;
            --surface: #ffffff;
            --background: #f8fafc;
            --success: #16a34a;
            --danger: #dc2626;
        }

        body {
            font-family: "Inter", sans-serif;
            background:
                radial-gradient(
                    circle at 10% 10%,
                    rgba(37, 99, 235, 0.10),
                    transparent 30%
                ),
                radial-gradient(
                    circle at 90% 20%,
                    rgba(124, 58, 237, 0.09),
                    transparent 28%
                ),
                #f8fafc;

            color: var(--text);
            min-height: 100vh;
        }


        /* =========================
           NAVBAR
        ========================= */

        .navbar {

            height: 72px;

            background: rgba(255,255,255,0.92);

            backdrop-filter: blur(18px);

            border-bottom: 1px solid rgba(226,232,240,0.8);

            display: flex;

            align-items: center;

            justify-content: space-between;

            padding: 0 6%;

            position: sticky;

            top: 0;

            z-index: 100;
        }

        .brand {

            display: flex;

            align-items: center;

            gap: 10px;

            text-decoration: none;

            color: var(--text);

            font-size: 21px;

            font-weight: 800;
        }

        .brand-icon {

            width: 38px;

            height: 38px;

            border-radius: 11px;

            background:
                linear-gradient(
                    135deg,
                    #2563eb,
                    #7c3aed
                );

            color: white;

            display: flex;

            align-items: center;

            justify-content: center;

            font-size: 19px;

            box-shadow:
                0 8px 20px
                rgba(37,99,235,.25);
        }

        .nav-links {

            display: flex;

            align-items: center;

            gap: 8px;
        }

        .nav-links a {

            text-decoration: none;

            color: #475569;

            font-size: 13px;

            font-weight: 600;

            padding: 10px 14px;

            border-radius: 10px;

            transition: .2s;
        }

        .nav-links a:hover {

            color: var(--primary);

            background: #eff6ff;
        }

        .nav-links .active {

            color: var(--primary);

            background: #eff6ff;
        }


        /* =========================
           PAGE
        ========================= */

        .page {

            width: min(1180px, 92%);

            margin: 0 auto;

            padding: 42px 0 70px;
        }


        /* =========================
           PAGE HEADER
        ========================= */

        .page-header {

            display: flex;

            justify-content: space-between;

            align-items: flex-end;

            gap: 20px;

            margin-bottom: 28px;
        }

        .eyebrow {

            color: var(--primary);

            font-size: 11px;

            font-weight: 800;

            text-transform: uppercase;

            letter-spacing: 1.5px;

            margin-bottom: 8px;
        }

        .page-header h1 {

            font-size: clamp(28px, 4vw, 38px);

            line-height: 1.1;

            margin-bottom: 9px;

            letter-spacing: -1px;
        }

        .page-header p {

            color: var(--muted);

            font-size: 14px;

            max-width: 650px;

            line-height: 1.6;
        }

        .back-btn {

            text-decoration: none;

            color: #334155;

            background: white;

            border: 1px solid var(--border);

            padding: 11px 17px;

            border-radius: 11px;

            font-size: 13px;

            font-weight: 700;

            transition: .2s;

            white-space: nowrap;
        }

        .back-btn:hover {

            border-color: #bfdbfe;

            color: var(--primary);

            transform: translateY(-1px);
        }


        /* =========================
           LAYOUT
        ========================= */

        .layout {

            display: grid;

            grid-template-columns:
                minmax(0, 1fr)
                310px;

            gap: 24px;

            align-items: start;
        }


        /* =========================
           CARD
        ========================= */

        .card {

            background: rgba(255,255,255,.95);

            border: 1px solid rgba(226,232,240,.95);

            border-radius: 20px;

            box-shadow:
                0 18px 45px
                rgba(15,23,42,.07);

            overflow: hidden;
        }

        .card-header {

            padding: 25px 28px 20px;

            border-bottom: 1px solid #eef2f7;
        }

        .card-header h2 {

            font-size: 18px;

            margin-bottom: 6px;
        }

        .card-header p {

            color: var(--muted);

            font-size: 12px;
        }

        .card-body {

            padding: 28px;
        }


        /* =========================
           ALERTS
        ========================= */

        .alert {

            display: flex;

            gap: 11px;

            align-items: flex-start;

            padding: 14px 16px;

            border-radius: 12px;

            margin-bottom: 20px;

            font-size: 13px;

            line-height: 1.5;
        }

        .alert-error {

            background: #fef2f2;

            border: 1px solid #fecaca;

            color: #991b1b;
        }

        .alert-info {

            background: #eff6ff;

            border: 1px solid #bfdbfe;

            color: #1e40af;
        }

        .alert-icon {

            font-size: 16px;

            flex-shrink: 0;
        }


        /* =========================
           FORM
        ========================= */

        .form-grid {

            display: grid;

            grid-template-columns: 1fr 1fr;

            gap: 20px;
        }

        .full {

            grid-column: 1 / -1;
        }

        .form-group {

            margin-bottom: 2px;
        }

        label {

            display: block;

            font-size: 12px;

            font-weight: 800;

            color: #334155;

            margin-bottom: 8px;
        }

        .required {

            color: #ef4444;

            margin-left: 2px;
        }

        input,
        textarea,
        select {

            width: 100%;

            border: 1px solid #dbe2ea;

            background: #fff;

            border-radius: 11px;

            padding: 12px 13px;

            font-family: inherit;

            font-size: 13px;

            color: #0f172a;

            transition:
                border-color .2s,
                box-shadow .2s;
        }

        input::placeholder,
        textarea::placeholder {

            color: #94a3b8;
        }

        input:focus,
        textarea:focus,
        select:focus {

            outline: none;

            border-color: #60a5fa;

            box-shadow:
                0 0 0 4px
                rgba(37,99,235,.10);
        }

        textarea {

            min-height: 125px;

            resize: vertical;

            line-height: 1.6;
        }

        .field-help {

            display: block;

            color: #94a3b8;

            font-size: 11px;

            margin-top: 6px;

            line-height: 1.5;
        }


        /* =========================
           CATEGORY ADD BOX
        ========================= */

        .new-category {

            margin-top: 4px;

            padding: 18px;

            border-radius: 14px;

            background:
                linear-gradient(
                    135deg,
                    #eff6ff,
                    #f5f3ff
                );

            border: 1px solid #dbeafe;
        }

        .new-category-title {

            display: flex;

            align-items: center;

            gap: 8px;

            color: #1e40af;

            font-size: 13px;

            font-weight: 800;

            margin-bottom: 14px;
        }


        /* =========================
           PRICE / STOCK
        ========================= */

        .input-prefix {

            position: relative;
        }

        .input-prefix span {

            position: absolute;

            left: 13px;

            top: 50%;

            transform: translateY(-50%);

            font-weight: 700;

            color: #64748b;

            pointer-events: none;
        }

        .input-prefix input {

            padding-left: 32px;
        }


        /* =========================
           ACTIONS
        ========================= */

        .actions {

            display: flex;

            align-items: center;

            gap: 11px;

            margin-top: 28px;

            padding-top: 23px;

            border-top: 1px solid #eef2f7;
        }

        .btn {

            border: none;

            border-radius: 11px;

            padding: 12px 20px;

            font-family: inherit;

            font-size: 13px;

            font-weight: 800;

            cursor: pointer;

            text-decoration: none;

            transition: .2s;

            display: inline-flex;

            align-items: center;

            justify-content: center;

            gap: 8px;
        }

        .btn-primary {

            background:
                linear-gradient(
                    135deg,
                    #2563eb,
                    #4f46e5
                );

            color: white;

            box-shadow:
                0 8px 20px
                rgba(37,99,235,.22);
        }

        .btn-primary:hover {

            transform: translateY(-1px);

            box-shadow:
                0 12px 25px
                rgba(37,99,235,.28);
        }

        .btn-secondary {

            background: #f1f5f9;

            color: #475569;
        }

        .btn-secondary:hover {

            background: #e2e8f0;
        }


        /* =========================
           SIDE PANEL
        ========================= */

        .side-card {

            padding: 24px;
        }

        .side-title {

            display: flex;

            align-items: center;

            gap: 10px;

            margin-bottom: 18px;
        }

        .side-icon {

            width: 38px;

            height: 38px;

            border-radius: 11px;

            background: #eff6ff;

            color: var(--primary);

            display: flex;

            align-items: center;

            justify-content: center;

            font-size: 17px;
        }

        .side-title h3 {

            font-size: 15px;
        }

        .side-title p {

            font-size: 11px;

            color: var(--muted);

            margin-top: 3px;
        }

        .tips {

            display: flex;

            flex-direction: column;

            gap: 13px;
        }

        .tip {

            display: flex;

            gap: 11px;

            padding: 12px;

            background: #f8fafc;

            border-radius: 11px;

            border: 1px solid #eef2f7;
        }

        .tip-dot {

            width: 25px;

            height: 25px;

            border-radius: 8px;

            background: #dbeafe;

            color: #2563eb;

            display: flex;

            align-items: center;

            justify-content: center;

            font-size: 11px;

            font-weight: 800;

            flex-shrink: 0;
        }

        .tip strong {

            display: block;

            font-size: 11px;

            margin-bottom: 3px;
        }

        .tip span {

            display: block;

            color: #64748b;

            font-size: 10px;

            line-height: 1.5;
        }


        /* =========================
           PREVIEW BOX
        ========================= */

        .preview {

            margin-top: 20px;

            padding: 18px;

            border-radius: 15px;

            background:
                linear-gradient(
                    135deg,
                    #0f172a,
                    #1e293b
                );

            color: white;
        }

        .preview-label {

            font-size: 10px;

            text-transform: uppercase;

            letter-spacing: 1px;

            color: #94a3b8;

            font-weight: 800;

            margin-bottom: 8px;
        }

        .preview h3 {

            font-size: 16px;

            margin-bottom: 7px;
        }

        .preview p {

            color: #cbd5e1;

            font-size: 11px;

            line-height: 1.5;
        }


        /* =========================
           FOOTER
        ========================= */

        footer {

            text-align: center;

            color: #94a3b8;

            font-size: 11px;

            margin-top: 30px;
        }


        /* =========================
           RESPONSIVE
        ========================= */

        @media (max-width: 900px) {

            .layout {

                grid-template-columns: 1fr;
            }

            .side-card {

                display: none;
            }

            .navbar {

                padding: 0 4%;
            }
        }

        @media (max-width: 650px) {

            .nav-links a {

                display: none;
            }

            .page {

                width: 94%;

                padding-top: 28px;
            }

            .page-header {

                align-items: flex-start;

                flex-direction: column;
            }

            .form-grid {

                grid-template-columns: 1fr;
            }

            .full {

                grid-column: auto;
            }

            .card-body,
            .card-header {

                padding: 20px;
            }

            .actions {

                flex-direction: column;

                align-items: stretch;
            }

            .btn {

                width: 100%;
            }
        }

    </style>

</head>


<body>


<!-- =========================
     NAVBAR
========================= -->

<nav class="navbar">

    <a
        class="brand"
        href="${pageContext.request.contextPath}/admin/dashboard">

        <span class="brand-icon">
            S
        </span>

        ShopSphere
    </a>


    <div class="nav-links">

        <a
            href="${pageContext.request.contextPath}/admin/dashboard">

            Dashboard

        </a>

        <a
            class="active"
            href="${pageContext.request.contextPath}/admin/products">

            Products

        </a>

        <a
            href="${pageContext.request.contextPath}/admin/categories">

            Categories

        </a>

    </div>

</nav>



<!-- =========================
     PAGE
========================= -->

<main class="page">


    <!-- PAGE HEADER -->

    <div class="page-header">

        <div>

            <div class="eyebrow">
                Product Management
            </div>

            <h1>
                Add New Product
            </h1>

            <p>
                Create a new product and make it available
                in the ShopSphere customer store.
            </p>

        </div>


        <a
            class="back-btn"
            href="${pageContext.request.contextPath}/admin/products">

            ← Back to Products

        </a>

    </div>



    <div class="layout">


        <!-- =========================
             MAIN FORM
        ========================= -->

        <section class="card">


            <div class="card-header">

                <h2>
                    Product Information
                </h2>

                <p>
                    Enter the basic information and pricing
                    details for this product.
                </p>

            </div>


            <div class="card-body">


                <!-- ERROR -->

                <c:if test="${param.error == '1'}">

                    <div class="alert alert-error">

                        <span class="alert-icon">
                            ⚠
                        </span>

                        <span>
                            Unable to add product.
                            Please check the entered information
                            and try again.
                        </span>

                    </div>

                </c:if>


                <c:if test="${param.error == 'category'}">

                    <div class="alert alert-error">

                        <span class="alert-icon">
                            ⚠
                        </span>

                        <span>
                            Unable to create the new category.
                            Please enter a valid category name.
                        </span>

                    </div>

                </c:if>


                <!-- FORM -->

                <form
                    action="${pageContext.request.contextPath}/admin/add-product"
                    method="post"
                    id="productForm">


                    <div class="form-grid">


                        <!-- CATEGORY -->

                        <div class="form-group full">

                            <label for="categoryId">

                                Category

                                <span class="required">
                                    *
                                </span>

                            </label>


                            <select
                                id="categoryId"
                                name="categoryId"
                                required
                                onchange="handleCategoryChange(this)">

                                <option value="">
                                    -- Select Category --
                                </option>


                                <c:forEach
                                    var="category"
                                    items="${categories}">

                                    <option
                                        value="${category.categoryId}">

                                        ${category.name}

                                    </option>

                                </c:forEach>


                                <option value="OTHER">

                                    + Add New Category

                                </option>

                            </select>

                        </div>



                        <!-- NEW CATEGORY -->

                        <div
                            class="form-group full new-category"
                            id="newCategoryBox"
                            style="display:none;">

                            <div class="new-category-title">

                                <span>＋</span>

                                Create New Category

                            </div>


                            <div class="form-grid">


                                <div class="form-group">

                                    <label for="newCategoryName">

                                        Category Name

                                        <span class="required">
                                            *
                                        </span>

                                    </label>

                                    <input
                                        type="text"
                                        id="newCategoryName"
                                        name="newCategoryName"
                                        maxlength="100"
                                        placeholder="e.g. Gaming Accessories">

                                </div>


                                <div class="form-group">

                                    <label for="newCategoryDescription">

                                        Description

                                    </label>

                                    <input
                                        type="text"
                                        id="newCategoryDescription"
                                        name="newCategoryDescription"
                                        maxlength="255"
                                        placeholder="Short category description">

                                </div>

                            </div>

                        </div>



                        <!-- PRODUCT NAME -->

                        <div class="form-group full">

                            <label for="name">

                                Product Name

                                <span class="required">
                                    *
                                </span>

                            </label>

                            <input
                                type="text"
                                id="name"
                                name="name"
                                maxlength="255"
                                placeholder="Enter product name"
                                required>

                        </div>



                        <!-- BRAND -->

                        <div class="form-group">

                            <label for="brand">

                                Brand

                                <span class="required">
                                    *
                                </span>

                            </label>

                            <input
                                type="text"
                                id="brand"
                                name="brand"
                                maxlength="100"
                                placeholder="Enter brand name"
                                required>

                        </div>



                        <!-- IMAGE -->

                        <div class="form-group">

                            <label for="imageUrl">

                                Image URL

                            </label>

                            <input
                                type="url"
                                id="imageUrl"
                                name="imageUrl"
                                placeholder="https://example.com/product.jpg">

                            <small class="field-help">

                                Use a publicly accessible image URL.

                            </small>

                        </div>



                        <!-- DESCRIPTION -->

                        <div class="form-group full">

                            <label for="description">

                                Description

                                <span class="required">
                                    *
                                </span>

                            </label>

                            <textarea
                                id="description"
                                name="description"
                                placeholder="Write a clear and useful product description..."
                                required></textarea>

                        </div>



                        <!-- PRICE -->

                        <div class="form-group">

                            <label for="price">

                                Price

                                <span class="required">
                                    *
                                </span>

                            </label>

                            <div class="input-prefix">

                                <span>₹</span>

                                <input
                                    type="number"
                                    id="price"
                                    name="price"
                                    step="0.01"
                                    min="0"
                                    placeholder="0.00"
                                    required>

                            </div>

                        </div>



                        <!-- DISCOUNT -->

                        <div class="form-group">

                            <label for="discount">

                                Discount

                                <span class="required">
                                    *
                                </span>

                            </label>

                            <div class="input-prefix">

                                <span>%</span>

                                <input
                                    type="number"
                                    id="discount"
                                    name="discount"
                                    step="0.01"
                                    min="0"
                                    max="100"
                                    value="0"
                                    required>

                            </div>

                        </div>



                        <!-- STOCK -->

                        <div class="form-group">

                            <label for="stock">

                                Stock Quantity

                                <span class="required">
                                    *
                                </span>

                            </label>

                            <input
                                type="number"
                                id="stock"
                                name="stock"
                                min="0"
                                placeholder="Enter quantity"
                                required>

                        </div>


                    </div>



                    <!-- ACTIONS -->

                    <div class="actions">

                        <button
                            type="submit"
                            class="btn btn-primary">

                            <span>＋</span>

                            Add Product

                        </button>


                        <a
                            class="btn btn-secondary"
                            href="${pageContext.request.contextPath}/admin/products">

                            Cancel

                        </a>

                    </div>


                </form>

            </div>

        </section>



        <!-- =========================
             SIDE INFORMATION
        ========================= -->

        <aside>


            <div class="card side-card">


                <div class="side-title">

                    <div class="side-icon">
                        ✓
                    </div>

                    <div>

                        <h3>
                            Product Checklist
                        </h3>

                        <p>
                            Before publishing
                        </p>

                    </div>

                </div>


                <div class="tips">


                    <div class="tip">

                        <div class="tip-dot">
                            1
                        </div>

                        <div>

                            <strong>
                                Choose category
                            </strong>

                            <span>
                                Select an existing category
                                or create a new one.
                            </span>

                        </div>

                    </div>


                    <div class="tip">

                        <div class="tip-dot">
                            2
                        </div>

                        <div>

                            <strong>
                                Add product details
                            </strong>

                            <span>
                                Use a clear name, brand and
                                meaningful description.
                            </span>

                        </div>

                    </div>


                    <div class="tip">

                        <div class="tip-dot">
                            3
                        </div>

                        <div>

                            <strong>
                                Set pricing
                            </strong>

                            <span>
                                Enter the correct selling price
                                and discount percentage.
                            </span>

                        </div>

                    </div>


                    <div class="tip">

                        <div class="tip-dot">
                            4
                        </div>

                        <div>

                            <strong>
                                Set inventory
                            </strong>

                            <span>
                                Enter the number of units
                                currently available.
                            </span>

                        </div>

                    </div>


                    <div class="tip">

                        <div class="tip-dot">
                            5
                        </div>

                        <div>

                            <strong>
                                Add product image
                            </strong>

                            <span>
                                A good product image makes
                                the store look professional.
                            </span>

                        </div>

                    </div>


                </div>


                <div class="preview">

                    <div class="preview-label">
                        ShopSphere Store
                    </div>

                    <h3>
                        Ready to sell?
                    </h3>

                    <p>
                        Once added, active products can appear
                        on the customer products page.
                    </p>

                </div>


            </div>


        </aside>


    </div>


    <footer>

        ShopSphere Admin Panel • Product Management

    </footer>


</main>



<script>


/* =========================
   CATEGORY HANDLER
========================= */

function handleCategoryChange(select) {

    const box =
        document.getElementById("newCategoryBox");

    const name =
        document.getElementById("newCategoryName");

    const description =
        document.getElementById("newCategoryDescription");


    if (select.value === "OTHER") {

        box.style.display = "block";

        name.required = true;

        name.focus();

    } else {

        box.style.display = "none";

        name.required = false;

        name.value = "";

        description.value = "";

    }

}



/* =========================
   FORM VALIDATION
========================= */

document
    .getElementById("productForm")
    .addEventListener("submit", function(event) {


        const price =
            parseFloat(
                document.getElementById("price").value
            );


        const discount =
            parseFloat(
                document.getElementById("discount").value
            );


        const stock =
            parseInt(
                document.getElementById("stock").value
            );


        if (isNaN(price) || price < 0) {

            alert("Please enter a valid product price.");

            event.preventDefault();

            return;

        }


        if (
            isNaN(discount) ||
            discount < 0 ||
            discount > 100
        ) {

            alert(
                "Discount must be between 0 and 100%."
            );

            event.preventDefault();

            return;

        }


        if (isNaN(stock) || stock < 0) {

            alert(
                "Stock quantity cannot be negative."
            );

            event.preventDefault();

        }

    });


</script>


</body>

</html>