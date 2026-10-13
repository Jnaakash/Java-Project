<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>ShopSphere - Products</title>


    <!-- =========================================
         POPPINS FONT
         ========================================= -->

    <link rel="preconnect"
          href="https://fonts.googleapis.com">

    <link rel="preconnect"
          href="https://fonts.gstatic.com"
          crossorigin>

    <link
        href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700;800&display=swap"
        rel="stylesheet">


    <style>

        /* =========================================
           VARIABLES
           ========================================= */

        :root {

            --primary: #2563eb;
            --primary-dark: #1d4ed8;

            --blue-light: #eff6ff;

            --dark: #111827;
            --text: #1f2937;
            --muted: #6b7280;

            --white: #ffffff;

            --background: #f5f8ff;

            --border: #e5eaf2;

            --green: #16a34a;
            --green-light: #dcfce7;

            --red: #dc2626;

            --shadow:
                0 10px 30px rgba(31, 52, 92, 0.07);

            --shadow-hover:
                0 18px 40px rgba(31, 52, 92, 0.13);
        }


        /* =========================================
           RESET
           ========================================= */

        * {

            box-sizing: border-box;

            margin: 0;

            padding: 0;

            font-family: 'Poppins', sans-serif;
        }


        html {

            scroll-behavior: smooth;
        }


        body {

            min-height: 100vh;

            color: var(--text);

            background:

                radial-gradient(
                    circle at 5% 5%,
                    rgba(37, 99, 235, 0.10),
                    transparent 25%
                ),

                radial-gradient(
                    circle at 95% 10%,
                    rgba(99, 102, 241, 0.08),
                    transparent 25%
                ),

                linear-gradient(
                    135deg,
                    #f8fbff 0%,
                    #eef4ff 50%,
                    #f8faff 100%
                );
        }


        a {

            text-decoration: none;
        }


        button,
        input {

            font-family: 'Poppins', sans-serif;
        }


        /* =========================================
           HEADER
           ========================================= */

        .shop-header {

            height: 74px;

            width: 100%;

            background: #ffffff;

            display: flex;

            align-items: center;

            justify-content: space-between;

            padding: 0 28px;

            border-bottom: 1px solid #e5e7eb;

            box-shadow:
                0 2px 12px rgba(15, 23, 42, 0.05);

            position: sticky;

            top: 0;

            z-index: 1000;
        }


        /* SHOPSPHERE LOGO */

        .shop-logo {

            color: #2563eb;

            font-size: 27px;

            font-weight: 800;

            letter-spacing: -0.7px;

            text-decoration: none;

            transition: 0.2s ease;
        }


        .shop-logo:hover {

            color: #1d4ed8;

            transform: translateY(-1px);
        }


        /* NAVIGATION */

        .shop-navigation {

            display: flex;

            align-items: center;

            gap: 8px;
        }


        .nav-link {

            color: #1f2937;

            font-size: 15px;

            font-weight: 600;

            padding: 10px 14px;

            border-radius: 8px;

            transition: 0.2s ease;
        }


        .nav-link:hover {

            color: #2563eb;

            background: #eff6ff;
        }


        /* LOGOUT */

        .logout-button {

            color: #ffffff;

            background: #dc2626;

            padding: 10px 18px;

            border-radius: 8px;

            font-size: 14px;

            font-weight: 600;

            margin-left: 8px;

            transition: 0.2s ease;
        }


        .logout-button:hover {

            background: #b91c1c;

            transform: translateY(-1px);
        }


        /* =========================================
           HERO
           ========================================= */

        .hero {

            width: calc(100% - 48px);

            max-width: 1400px;

            margin: 28px auto 0;

            padding: 44px 52px;

            border-radius: 26px;

            position: relative;

            overflow: hidden;

            color: white;

            background:

                radial-gradient(
                    circle at 85% 20%,
                    rgba(96, 165, 250, 0.35),
                    transparent 28%
                ),

                radial-gradient(
                    circle at 20% 90%,
                    rgba(129, 140, 248, 0.25),
                    transparent 30%
                ),

                linear-gradient(
                    135deg,
                    #12306f,
                    #2563eb 55%,
                    #4f46e5
                );

            box-shadow:
                0 20px 50px rgba(37, 99, 235, 0.18);
        }


        .hero::before {

            content: "";

            position: absolute;

            width: 230px;

            height: 230px;

            border-radius: 50%;

            right: -80px;

            top: -90px;

            background:
                rgba(255,255,255,0.08);
        }


        .hero::after {

            content: "";

            position: absolute;

            width: 160px;

            height: 160px;

            border-radius: 50%;

            left: 40%;

            bottom: -100px;

            background:
                rgba(255,255,255,0.07);
        }


        .hero-content {

            position: relative;

            z-index: 2;

            max-width: 760px;
        }


        .hero-badge {

            display: inline-flex;

            align-items: center;

            gap: 8px;

            padding: 7px 13px;

            border-radius: 30px;

            background:
                rgba(255,255,255,0.13);

            border:
                1px solid rgba(255,255,255,0.20);

            font-size: 12px;

            font-weight: 600;

            margin-bottom: 16px;
        }


        .hero h1 {

            font-size:
                clamp(32px, 4vw, 48px);

            line-height: 1.08;

            letter-spacing: -1.5px;

            margin-bottom: 13px;

            font-weight: 800;
        }


        .hero h1 span {

            color: #bfdbfe;
        }


        .hero p {

            color: #dbeafe;

            max-width: 650px;

            font-size: 15px;

            line-height: 1.7;
        }


        /* =========================================
           SEARCH
           ========================================= */

        .search-section {

            width: calc(100% - 48px);

            max-width: 1400px;

            margin: 25px auto 30px;
        }


        .search-box {

            background:
                rgba(255,255,255,0.94);

            border:
                1px solid var(--border);

            border-radius: 18px;

            padding: 15px;

            box-shadow: var(--shadow);
        }


        .search-form {

            width: 100%;

            display: flex;

            align-items: center;

            gap: 10px;
        }


        .search-input-wrapper {

            flex: 1;

            position: relative;
        }


        .search-icon {

            position: absolute;

            left: 16px;

            top: 50%;

            transform:
                translateY(-50%);

            font-size: 17px;

            color: #94a3b8;
        }


        .search-input {

            width: 100%;

            height: 50px;

            padding:
                0 18px 0 47px;

            border:
                1px solid #dce3ee;

            border-radius: 12px;

            outline: none;

            background: #f9fbff;

            color: var(--dark);

            font-size: 14px;

            transition: 0.2s;
        }


        .search-input:focus {

            background: #ffffff;

            border-color:
                var(--primary);

            box-shadow:
                0 0 0 4px
                rgba(37,99,235,0.09);
        }


        .search-button {

            height: 50px;

            padding: 0 24px;

            border: none;

            border-radius: 12px;

            background:
                linear-gradient(
                    135deg,
                    #2563eb,
                    #4f46e5
                );

            color: #ffffff;

            font-size: 14px;

            font-weight: 700;

            cursor: pointer;

            transition: 0.2s;
        }


        .search-button:hover {

            transform: translateY(-2px);

            background:
                linear-gradient(
                    135deg,
                    #1d4ed8,
                    #4338ca
                );
        }


        .clear-button {

            height: 50px;

            padding: 0 20px;

            display: flex;

            align-items: center;

            justify-content: center;

            border-radius: 12px;

            background: #f1f5f9;

            border:
                1px solid #e2e8f0;

            color: #475569;

            font-size: 13px;

            font-weight: 600;

            transition: 0.2s;
        }


        .clear-button:hover {

            background: #e2e8f0;

            color: var(--dark);
        }


        /* =========================================
           RESULT HEADER
           ========================================= */

        .result-info {

            width: calc(100% - 48px);

            max-width: 1400px;

            margin: 0 auto 22px;

            display: flex;

            align-items: center;

            justify-content: space-between;
        }


        .result-info h2 {

            color: var(--dark);

            font-size: 22px;

            font-weight: 700;
        }


        .result-info p {

            color: var(--muted);

            font-size: 13px;

            margin-top: 5px;
        }


        .result-badge {

            padding: 8px 13px;

            background: #ffffff;

            border:
                1px solid var(--border);

            border-radius: 30px;

            color: var(--primary);

            font-size: 12px;

            font-weight: 700;
        }


        /* =========================================
           BENEFITS
           ========================================= */

        .benefits {

            width: calc(100% - 48px);

            max-width: 1400px;

            margin: 0 auto 28px;

            display: grid;

            grid-template-columns:
                repeat(3, 1fr);

            gap: 15px;
        }


        .benefit {

            display: flex;

            align-items: center;

            gap: 13px;

            padding: 15px 18px;

            border-radius: 15px;

            background:
                rgba(255,255,255,0.86);

            border:
                1px solid var(--border);

            box-shadow:
                0 7px 22px rgba(31,52,92,0.05);
        }


        .benefit-icon {

            width: 42px;

            height: 42px;

            flex-shrink: 0;

            display: grid;

            place-items: center;

            border-radius: 12px;

            background:
                var(--blue-light);

            font-size: 19px;
        }


        .benefit strong {

            display: block;

            font-size: 13px;

            color: var(--dark);

            margin-bottom: 3px;
        }


        .benefit span {

            font-size: 11px;

            color: var(--muted);
        }


        /* =========================================
           PRODUCT GRID
           ========================================= */

        .products {

            width: calc(100% - 48px);

            max-width: 1400px;

            margin: 0 auto 60px;

            display: grid;

            grid-template-columns:
                repeat(4, minmax(0, 1fr));

            gap: 22px;
        }


        /* =========================================
           PRODUCT CARD
           ========================================= */

        .product-card {

            position: relative;

            overflow: hidden;

            background:
                rgba(255,255,255,0.96);

            border:
                1px solid var(--border);

            border-radius: 20px;

            box-shadow: var(--shadow);

            transition:
                transform 0.25s ease,
                box-shadow 0.25s ease;
        }


        .product-card:hover {

            transform:
                translateY(-7px);

            box-shadow:
                var(--shadow-hover);
        }


        /* =========================================
           PRODUCT IMAGE
           ========================================= */

        .product-image {

            height: 215px;

            position: relative;

            display: flex;

            align-items: center;

            justify-content: center;

            overflow: hidden;

            background:

                radial-gradient(
                    circle at 50% 45%,
                    #ffffff 0%,
                    #f1f5ff 65%,
                    #e8eefc 100%
                );
        }


        .product-image img {

            width: 100%;

            height: 100%;

            object-fit: contain;

            padding: 25px;

            transition:
                transform 0.3s ease;
        }


        .product-card:hover
        .product-image img {

            transform:
                scale(1.07);
        }


        .image-placeholder {

            font-size: 60px;

            opacity: 0.75;
        }


        /* =========================================
           DISCOUNT
           ========================================= */

        .discount {

            position: absolute;

            left: 13px;

            top: 13px;

            padding: 6px 10px;

            border-radius: 30px;

            background:
                var(--green-light);

            color: #15803d;

            font-size: 10px;

            font-weight: 800;

            z-index: 2;
        }


        /* =========================================
           WISHLIST
           ========================================= */

        .wishlist {

            position: absolute;

            right: 13px;

            top: 13px;

            width: 38px;

            height: 38px;

            border-radius: 50%;

            border:
                1px solid #e3e9f2;

            background:
                rgba(255,255,255,0.96);

            display: grid;

            place-items: center;

            color: #64748b;

            font-size: 18px;

            cursor: pointer;

            z-index: 3;

            transition: 0.2s;

            box-shadow:
                0 6px 15px
                rgba(31,52,92,.08);
        }


        .wishlist:hover {

            color: #ef4444;

            background: #fff1f2;

            border-color: #fecdd3;

            transform: scale(1.08);
        }


        .wishlist.active {

            color: #ef4444;

            background: #fff1f2;

            border-color: #fecdd3;
        }


        /* =========================================
           PRODUCT BODY
           ========================================= */

        .product-body {

            padding: 19px;
        }


        .brand {

            color: #64748b;

            font-size: 10px;

            text-transform: uppercase;

            letter-spacing: 0.8px;

            font-weight: 800;

            margin-bottom: 7px;
        }


        .product-card h2 {

            font-size: 17px;

            line-height: 1.3;

            color: var(--dark);

            margin-bottom: 7px;

            min-height: 44px;

            font-weight: 700;
        }


        .description {

            color: #718096;

            font-size: 12px;

            line-height: 1.55;

            min-height: 38px;

            margin-bottom: 14px;
        }


        /* =========================================
           PRICE
           ========================================= */

        .price-row {

            display: flex;

            align-items: center;

            gap: 9px;

            margin-bottom: 11px;
        }


        .price {

            font-size: 21px;

            font-weight: 800;

            color: var(--dark);
        }


        .old-price {

            color: #94a3b8;

            font-size: 11px;

            text-decoration: line-through;
        }


        /* =========================================
           STOCK
           ========================================= */

        .stock {

            display: flex;

            align-items: center;

            gap: 6px;

            font-size: 11px;

            font-weight: 700;

            color: #15803d;

            margin-bottom: 15px;
        }


        .stock-dot {

            width: 7px;

            height: 7px;

            border-radius: 50%;

            background: var(--green);
        }


        .out-stock {

            display: flex;

            align-items: center;

            gap: 6px;

            color: var(--red);

            font-size: 12px;

            font-weight: 700;

            margin-bottom: 15px;
        }


        .out-stock .stock-dot {

            background: var(--red);
        }


        /* =========================================
           BUTTONS
           ========================================= */

        .product-actions {

            display: grid;

            grid-template-columns:
                1fr 1fr;

            gap: 8px;
        }


        .btn {

            min-height: 42px;

            display: flex;

            align-items: center;

            justify-content: center;

            gap: 6px;

            border-radius: 10px;

            font-size: 12px;

            font-weight: 700;

            transition: 0.2s;
        }


        .add-cart {

            color: #ffffff;

            background:
                linear-gradient(
                    135deg,
                    #2563eb,
                    #4f46e5
                );

            box-shadow:
                0 7px 15px
                rgba(37,99,235,.17);
        }


        .add-cart:hover {

            transform:
                translateY(-2px);

            box-shadow:
                0 10px 20px
                rgba(37,99,235,.25);
        }


        .details {

            color: var(--dark);

            background: #ffffff;

            border:
                1px solid #dce3ee;
        }


        .details:hover {

            color: var(--primary);

            border-color:
                #93c5fd;

            background:
                #eff6ff;
        }


        /* =========================================
           EMPTY STATE
           ========================================= */

        .empty-state {

            width: calc(100% - 48px);

            max-width: 850px;

            margin: 35px auto 70px;

            text-align: center;

            padding: 55px 30px;

            background:
                rgba(255,255,255,.90);

            border:
                1px solid var(--border);

            border-radius: 22px;

            box-shadow: var(--shadow);
        }


        .empty-icon {

            width: 75px;

            height: 75px;

            margin:
                0 auto 18px;

            border-radius: 50%;

            display: grid;

            place-items: center;

            background: #eff6ff;

            font-size: 32px;
        }


        .empty-state h2 {

            font-size: 23px;

            margin-bottom: 8px;

            color: var(--dark);
        }


        .empty-state p {

            color: var(--muted);

            font-size: 13px;

            margin-bottom: 20px;
        }


        .empty-button {

            display: inline-flex;

            padding: 11px 18px;

            border-radius: 10px;

            color: #ffffff;

            background:
                var(--primary);

            font-size: 13px;

            font-weight: 700;
        }


        /* =========================================
           FOOTER
           ========================================= */

        .footer {

            background: #0b1730;

            color: #94a3b8;

            padding: 30px 25px;

            text-align: center;

            font-size: 12px;
        }


        .footer strong {

            color: #ffffff;
        }


        /* =========================================
           RESPONSIVE
           ========================================= */

        @media (max-width: 1150px) {

            .products {

                grid-template-columns:
                    repeat(3, minmax(0, 1fr));
            }
        }


        @media (max-width: 850px) {

            .shop-header {

                padding: 0 18px;
            }


            .shop-navigation {

                gap: 2px;
            }


            .nav-link {

                padding: 9px 8px;

                font-size: 13px;
            }


            .logout-button {

                padding:
                    9px 12px;
            }


            .hero {

                padding:
                    34px 28px;
            }


            .products {

                grid-template-columns:
                    repeat(2, minmax(0, 1fr));
            }


            .benefits {

                grid-template-columns: 1fr;
            }


            .search-form {

                flex-wrap: wrap;
            }


            .search-input-wrapper {

                flex-basis: 100%;
            }


            .search-button,
            .clear-button {

                flex: 1;
            }
        }


        @media (max-width: 580px) {

            .shop-header {

                height: auto;

                min-height: 68px;

                flex-wrap: wrap;

                gap: 10px;

                padding: 12px 16px;
            }


            .shop-logo {

                font-size: 23px;
            }


            .shop-navigation {

                width: 100%;

                justify-content: space-between;

                overflow-x: auto;

                padding-bottom: 2px;
            }


            .nav-link {

                white-space: nowrap;

                font-size: 12px;

                padding: 8px 7px;
            }


            .logout-button {

                white-space: nowrap;

                font-size: 12px;

                margin-left: 0;
            }


            .hero,
            .search-section,
            .result-info,
            .benefits,
            .products {

                width:
                    calc(100% - 28px);
            }


            .hero {

                margin-top: 15px;

                padding:
                    30px 22px;

                border-radius: 20px;
            }


            .hero h1 {

                font-size: 30px;
            }


            .products {

                grid-template-columns: 1fr;

                gap: 17px;
            }


            .product-image {

                height: 240px;
            }


            .result-info {

                align-items: flex-start;

                flex-direction: column;

                gap: 10px;
            }


            .search-button,
            .clear-button {

                flex-basis: 100%;
            }


            .search-form {

                gap: 8px;
            }
        }

    </style>

</head>


<body>


<!-- =========================================================
     HEADER
     ========================================================= -->

<header class="shop-header">


    <!-- =========================================
         SHOPSPHERE LOGO

         CLICKING LOGO = HOME PAGE
         ========================================= -->

    <a
        href="${pageContext.request.contextPath}/index.jsp"
        class="shop-logo"
        title="ShopSphere Home">

        ShopSphere

    </a>


    <!-- =========================================
         NAVIGATION
         ========================================= -->

    <nav class="shop-navigation">


        <!-- PRODUCTS -->

        <a
            href="${pageContext.request.contextPath}/products"
            class="nav-link">

            Products

        </a>


        <!-- CART -->

        <a
            href="${pageContext.request.contextPath}/cart"
            class="nav-link">

            Cart

        </a>


        <!-- MY ORDERS -->

        <a
            href="${pageContext.request.contextPath}/orders"
            class="nav-link">

            My Orders

        </a>


        <!-- LOGOUT -->

        <a
            href="${pageContext.request.contextPath}/logout"
            class="logout-button">

            Logout

        </a>

    </nav>

</header>



<!-- =========================================================
     HERO
     ========================================================= -->

<section class="hero">

    <div class="hero-content">


        <div class="hero-badge">

            🛍️ ShopSphere Store

        </div>


        <h1>

            Discover products

            <span>
                you'll love.
            </span>

        </h1>


        <p>

            Explore our collection of quality products,
            amazing deals and everyday essentials —
            all in one place.

        </p>

    </div>

</section>



<!-- =========================================================
     SEARCH
     ========================================================= -->

<section class="search-section">

    <div class="search-box">


        <form
            class="search-form"
            action="${pageContext.request.contextPath}/products"
            method="get">


            <div class="search-input-wrapper">


                <span class="search-icon">
                    🔍
                </span>


                <input
                    class="search-input"
                    type="text"
                    name="keyword"
                    placeholder="Search products, brands and more..."
                    value="${searchKeyword}"
                >

            </div>


            <button
                class="search-button"
                type="submit">

                🔍 Search

            </button>


            <a
                class="clear-button"
                href="${pageContext.request.contextPath}/products">

                Clear

            </a>


        </form>

    </div>

</section>



<!-- =========================================================
     RESULT INFORMATION
     ========================================================= -->

<div class="result-info">


    <div>


        <c:choose>


            <c:when test="${not empty searchKeyword}">

                <h2>
                    Search Results
                </h2>

                <p>

                    Showing results for
                    <strong>
                        "${searchKeyword}"
                    </strong>

                </p>

            </c:when>


            <c:otherwise>

                <h2>
                    Explore Products
                </h2>

                <p>
                    Fresh picks, great prices and everyday essentials.
                </p>

            </c:otherwise>


        </c:choose>


    </div>


    <c:if test="${not empty products}">

        <div class="result-badge">

            🛍️ ${products.size()} Products

        </div>

    </c:if>


</div>



<!-- =========================================================
     BENEFITS
     ========================================================= -->

<div class="benefits">


    <!-- FAST DELIVERY -->

    <div class="benefit">

        <div class="benefit-icon">
            🚚
        </div>

        <div>

            <strong>
                Fast Delivery
            </strong>

            <span>
                Quick and reliable delivery
            </span>

        </div>

    </div>


    <!-- SECURE SHOPPING -->

    <div class="benefit">

        <div class="benefit-icon">
            🔒
        </div>

        <div>

            <strong>
                Secure Shopping
            </strong>

            <span>
                Safe and secure checkout
            </span>

        </div>

    </div>


    <!-- EASY RETURNS -->

    <div class="benefit">

        <div class="benefit-icon">
            ↩️
        </div>

        <div>

            <strong>
                Easy Returns
            </strong>

            <span>
                Simple customer-friendly returns
            </span>

        </div>

    </div>


</div>



<!-- =========================================================
     EMPTY PRODUCT RESULT
     ========================================================= -->

<c:if test="${empty products}">


    <div class="empty-state">


        <div class="empty-icon">
            🔎
        </div>


        <h2>
            No products found
        </h2>


        <p>

            We couldn't find any products matching your search.

            Try another product name or brand.

        </p>


        <a
            class="empty-button"
            href="${pageContext.request.contextPath}/products">

            View All Products

        </a>


    </div>


</c:if>



<!-- =========================================================
     PRODUCTS
     ========================================================= -->

<c:if test="${not empty products}">


    <div class="products">


        <c:forEach
            var="product"
            items="${products}">


            <!-- =========================================
                 PRODUCT CARD
                 ========================================= -->

            <div class="product-card">


                <!-- =====================================
                     PRODUCT IMAGE
                     ===================================== -->

                <div class="product-image">


                    <!-- DISCOUNT -->

                    <c:if test="${product.discount > 0}">

                        <div class="discount">

                            ${product.discount}% OFF

                        </div>

                    </c:if>


                    <!-- WISHLIST -->

                    <button
                        type="button"
                        class="wishlist"
                        title="Add to Wishlist"
                        onclick="toggleWishlist(this)">

                        ♡

                    </button>


                    <!-- PRODUCT IMAGE -->

                    <c:choose>


                        <c:when
                            test="${not empty product.imageUrl}">


                            <img
                                src="${product.imageUrl}"
                                alt="${product.name}"
                                onerror="
                                    this.style.display='none';
                                    this.nextElementSibling.style.display='block';
                                "
                            >


                            <div
                                class="image-placeholder"
                                style="display:none;">

                                🛍️

                            </div>


                        </c:when>


                        <c:otherwise>


                            <div
                                class="image-placeholder">

                                🛍️

                            </div>


                        </c:otherwise>


                    </c:choose>


                </div>



                <!-- =====================================
                     PRODUCT INFORMATION
                     ===================================== -->

                <div class="product-body">


                    <!-- BRAND -->

                    <div class="brand">

                        ${product.brand}

                    </div>


                    <!-- PRODUCT NAME -->

                    <h2>

                        ${product.name}

                    </h2>


                    <!-- DESCRIPTION -->

                    <p class="description">

                        ${product.description}

                    </p>



                    <!-- PRICE -->

                    <div class="price-row">


                        <span class="price">

                            ₹${product.price}

                        </span>


                        <c:if
                            test="${product.discount > 0}">

                            <span class="old-price">

                                ${product.discount}% OFF

                            </span>

                        </c:if>


                    </div>



                    <!-- =================================
                         STOCK
                         ================================= -->

                    <c:if
                        test="${product.stock > 0}">


                        <div class="stock">

                            <span class="stock-dot"></span>

                            In stock ·
                            ${product.stock}
                            available

                        </div>


                    </c:if>


                    <c:if
                        test="${product.stock == 0}">


                        <div class="out-stock">

                            <span class="stock-dot"></span>

                            Out of Stock

                        </div>


                    </c:if>



                    <!-- =================================
                         PRODUCT ACTIONS
                         ================================= -->

                    <c:if
                        test="${product.stock > 0}">


                        <div class="product-actions">


                            <!-- ADD TO CART -->

                            <a
                                class="btn add-cart"
                                href="${pageContext.request.contextPath}/cart?action=add&id=${product.productId}">

                                🛒 Add to Cart

                            </a>


                            <!-- DETAILS -->

                            <a
                                class="btn details"
                                href="${pageContext.request.contextPath}/products?id=${product.productId}">

                                View Details

                            </a>


                        </div>


                    </c:if>



                    <!-- OUT OF STOCK -->

                    <c:if
                        test="${product.stock == 0}">


                        <div class="product-actions">


                            <a
                                class="btn details"
                                href="${pageContext.request.contextPath}/products?id=${product.productId}">

                                View Details

                            </a>


                        </div>


                    </c:if>


                </div>


            </div>


        </c:forEach>


    </div>


</c:if>



<!-- =========================================================
     FOOTER
     ========================================================= -->

<footer class="footer">


    <strong>
        ShopSphere
    </strong>

    &nbsp;·&nbsp;

    Your everyday shopping destination.


    <br><br>


    © 2026 ShopSphere.
    All rights reserved.


</footer>



<!-- =========================================================
     WISHLIST JAVASCRIPT
     UI ONLY
     ========================================================= -->

<script>

    function toggleWishlist(button) {

        button.classList.toggle("active");


        if (button.classList.contains("active")) {

            button.innerHTML = "♥";

            button.title =
                "Remove from Wishlist";

        } else {

            button.innerHTML = "♡";

            button.title =
                "Add to Wishlist";
        }

    }

</script>


</body>

</html>