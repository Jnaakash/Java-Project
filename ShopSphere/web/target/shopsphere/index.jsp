<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>ShopSphere | Online Shopping</title>

    <!-- Professional e-commerce font -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>

    <link
        href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap"
        rel="stylesheet"
    >

    <style>

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        html {
            scroll-behavior: smooth;
        }

        body {
            font-family: "Inter", Arial, Helvetica, sans-serif;
            color: #171717;
            background: #fff;
            overflow-x: hidden;
        }

        a {
            text-decoration: none;
            color: inherit;
        }

        button {
            font-family: inherit;
        }


        /* =====================================================
           TOP BAR
        ===================================================== */

        .top-bar {
            height: 34px;
            background: #111827;
            color: #d1d5db;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 11px;
            font-weight: 500;
        }

        .top-bar strong {
            color: #fff;
        }


        /* =====================================================
           NAVBAR
        ===================================================== */

        .navbar {
            height: 76px;
            padding: 0 6%;
            display: flex;
            align-items: center;
            justify-content: space-between;
            background: #fff;
            border-bottom: 1px solid #eeeeee;
            position: relative;
            z-index: 50;
        }

        .logo {
            font-size: 27px;
            font-weight: 800;
            letter-spacing: -1.4px;
            color: #111827;
        }

        .logo span {
            color: #2563eb;
        }

        .nav-links {
            display: flex;
            align-items: center;
            gap: 31px;
        }

        .nav-links a {
            font-size: 13px;
            font-weight: 600;
            color: #374151;
            transition: .2s ease;
        }

        .nav-links a:hover,
        .nav-links .active {
            color: #2563eb;
        }

        .nav-actions {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .nav-icon {
            width: 35px;
            height: 35px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 17px;
            transition: .2s ease;
        }

        .nav-icon:hover {
            background: #f3f4f6;
            color: #2563eb;
        }

        .login-btn {
            padding: 10px 19px;
            border-radius: 5px;
            background: #2563eb;
            color: white !important;
            font-size: 13px !important;
            font-weight: 700 !important;
        }

        .login-btn:hover {
            background: #1d4ed8;
        }


        /* =====================================================
           HERO
        ===================================================== */

        .hero {
            position: relative;
            background: #f5f7fa;
            overflow: hidden;
        }

        .slide {
            display: none;
            min-height: 590px;
        }

        .slide.active {
            display: block;
        }

        .hero-container {
            width: 88%;
            max-width: 1380px;
            min-height: 590px;
            margin: auto;
            display: grid;
            grid-template-columns: 46% 54%;
            align-items: center;
        }


        /* =====================================================
           HERO TEXT
        ===================================================== */

        .hero-content {
            padding-right: 30px;
            animation: contentIn .55s ease;
        }

        .eyebrow {
            color: #2563eb;
            font-size: 11px;
            font-weight: 800;
            letter-spacing: 1.6px;
            text-transform: uppercase;
            margin-bottom: 17px;
        }

        .hero-title {
            max-width: 600px;
            font-size: clamp(43px, 5vw, 66px);
            line-height: 1.05;
            letter-spacing: -3px;
            font-weight: 800;
            color: #111827;
            margin-bottom: 21px;
        }

        .hero-title span {
            color: #2563eb;
        }

        .hero-description {
            max-width: 500px;
            color: #667085;
            font-size: 15px;
            line-height: 1.75;
            margin-bottom: 29px;
        }

        .buttons {
            display: flex;
            align-items: center;
            gap: 11px;
        }

        .btn {
            min-width: 135px;
            height: 47px;
            padding: 0 21px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            border-radius: 5px;
            font-size: 12px;
            font-weight: 700;
            transition: .25s ease;
        }

        .btn-primary {
            background: #2563eb;
            color: #fff;
        }

        .btn-primary:hover {
            background: #1d4ed8;
            transform: translateY(-2px);
        }

        .btn-secondary {
            background: #fff;
            border: 1px solid #d9dee7;
            color: #1f2937;
        }

        .btn-secondary:hover {
            border-color: #2563eb;
            color: #2563eb;
        }


        /* =====================================================
           HERO VISUAL
        ===================================================== */

        .hero-visual {
            height: 590px;
            position: relative;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .visual-bg {
            position: absolute;
            width: 510px;
            height: 510px;
            border-radius: 50%;
            background: #e4edff;
        }

        .visual-card {
            position: relative;
            width: 80%;
            max-width: 570px;
            height: 430px;
            display: flex;
            align-items: center;
            justify-content: center;
            animation: visualIn .65s ease;
        }

        .product-svg {
            width: 100%;
            height: 100%;
            position: relative;
            z-index: 2;
        }


        /* =====================================================
           FLOATING SMALL CARDS
        ===================================================== */

        .mini-card {
            position: absolute;
            z-index: 5;
            background: rgba(255,255,255,.94);
            border: 1px solid #e8ebf0;
            box-shadow: 0 15px 35px rgba(15,23,42,.10);
            padding: 13px 16px;
            border-radius: 7px;
            font-size: 11px;
            animation: floating 4s ease-in-out infinite;
        }

        .mini-card strong {
            display: block;
            color: #111827;
            font-size: 12px;
            margin-bottom: 3px;
        }

        .mini-card small {
            color: #8a919d;
        }

        .mini-one {
            left: 4%;
            bottom: 24%;
        }

        .mini-two {
            right: 3%;
            top: 22%;
            animation-delay: 1.2s;
        }


        /* =====================================================
           SLIDER
        ===================================================== */

        .arrow {
            position: absolute;
            top: 50%;
            transform: translateY(-50%);
            width: 40px;
            height: 40px;
            border-radius: 50%;
            border: 1px solid #dfe4eb;
            background: rgba(255,255,255,.92);
            color: #374151;
            cursor: pointer;
            font-size: 22px;
            z-index: 10;
            transition: .2s ease;
        }

        .arrow:hover {
            background: #2563eb;
            border-color: #2563eb;
            color: white;
        }

        .left-arrow {
            left: 22px;
        }

        .right-arrow {
            right: 22px;
        }

        .dots {
            position: absolute;
            left: 6%;
            bottom: 29px;
            display: flex;
            gap: 7px;
            z-index: 10;
        }

        .dot {
            width: 7px;
            height: 7px;
            border: none;
            border-radius: 50%;
            background: #cbd2dc;
            cursor: pointer;
            transition: .25s ease;
        }

        .dot.active {
            width: 25px;
            border-radius: 5px;
            background: #2563eb;
        }


        /* =====================================================
           SERVICE STRIP
        ===================================================== */

        .services {
            min-height: 105px;
            display: grid;
            grid-template-columns: repeat(4,1fr);
            border-bottom: 1px solid #ededed;
            background: white;
        }

        .service {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 13px;
            border-right: 1px solid #eeeeee;
        }

        .service:last-child {
            border-right: none;
        }

        .service-icon {
            width: 40px;
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
            background: #eff6ff;
            color: #2563eb;
            font-size: 18px;
        }

        .service strong {
            display: block;
            font-size: 12px;
            color: #222;
            margin-bottom: 4px;
        }

        .service small {
            color: #8b929d;
            font-size: 10px;
        }


        /* =====================================================
           SECTION COMMON
        ===================================================== */

        .section {
            padding: 82px 6%;
        }

        .section-header {
            text-align: center;
            margin-bottom: 43px;
        }

        .section-header small {
            color: #2563eb;
            font-size: 10px;
            font-weight: 800;
            text-transform: uppercase;
            letter-spacing: 1.5px;
        }

        .section-header h2 {
            margin-top: 9px;
            color: #171717;
            font-size: 34px;
            letter-spacing: -1.4px;
            font-weight: 700;
        }

        .section-header p {
            margin-top: 9px;
            color: #858b95;
            font-size: 13px;
        }


        /* =====================================================
           CATEGORY CARDS
        ===================================================== */

        .category-grid {
            max-width: 1200px;
            margin: auto;
            display: grid;
            grid-template-columns: repeat(4,1fr);
            gap: 17px;
        }

        .category {
            min-height: 185px;
            padding: 25px;
            position: relative;
            overflow: hidden;
            background: #f7f8fa;
            border: 1px solid #eceef2;
            transition: .25s ease;
        }

        .category:hover {
            transform: translateY(-4px);
            border-color: #dbeafe;
            box-shadow: 0 14px 32px rgba(15,23,42,.07);
        }

        .category-number {
            position: absolute;
            top: 15px;
            right: 19px;
            color: #e0e7f1;
            font-size: 34px;
            font-weight: 800;
        }

        .category-visual {
            width: 62px;
            height: 62px;
            margin-bottom: 20px;
        }

        .category h3 {
            color: #222;
            font-size: 15px;
            margin-bottom: 6px;
        }

        .category p {
            color: #8a919d;
            font-size: 11px;
        }


        /* =====================================================
           WHY US
        ===================================================== */

        .why-section {
            background: #f7f8fa;
        }

        .why-grid {
            max-width: 1100px;
            margin: auto;
            display: grid;
            grid-template-columns: repeat(4,1fr);
            gap: 35px;
        }

        .why {
            text-align: center;
        }

        .why-icon {
            width: 58px;
            height: 58px;
            margin: auto auto 16px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
            background: #fff;
            color: #2563eb;
            font-size: 21px;
            box-shadow: 0 7px 20px rgba(15,23,42,.05);
        }

        .why h3 {
            font-size: 13px;
            color: #222;
            margin-bottom: 7px;
        }

        .why p {
            font-size: 11px;
            line-height: 1.6;
            color: #858b95;
        }


        /* =====================================================
           FOOTER
        ===================================================== */

        footer {
            padding: 36px 6%;
            background: #111827;
            color: #9ca3af;
            text-align: center;
            font-size: 11px;
        }

        footer strong {
            color: #fff;
        }


        /* =====================================================
           ANIMATIONS
        ===================================================== */

        @keyframes contentIn {

            from {
                opacity: 0;
                transform: translateY(16px);
            }

            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes visualIn {

            from {
                opacity: 0;
                transform: scale(.97);
            }

            to {
                opacity: 1;
                transform: scale(1);
            }
        }

        @keyframes floating {

            0%,100% {
                transform: translateY(0);
            }

            50% {
                transform: translateY(-8px);
            }
        }


        /* =====================================================
           RESPONSIVE
        ===================================================== */

        @media(max-width:1050px) {

            .nav-links {
                gap: 17px;
            }

            .hero-container {
                grid-template-columns: 1fr;
            }

            .hero-content {
                padding-top: 70px;
                padding-right: 0;
                text-align: center;
            }

            .hero-description {
                margin-left: auto;
                margin-right: auto;
            }

            .buttons {
                justify-content: center;
            }

            .hero-visual {
                height: 450px;
            }

            .visual-card {
                height: 370px;
            }

            .services {
                grid-template-columns: repeat(2,1fr);
            }

            .service {
                padding: 17px;
                border-bottom: 1px solid #eee;
            }

            .service:nth-child(2) {
                border-right: none;
            }

            .category-grid {
                grid-template-columns: repeat(2,1fr);
            }

            .why-grid {
                grid-template-columns: repeat(2,1fr);
                row-gap: 40px;
            }
        }


        @media(max-width:650px) {

            .top-bar {
                font-size: 9px;
            }

            .navbar {
                height: 67px;
                padding: 0 5%;
            }

            .logo {
                font-size: 24px;
            }

            .nav-links {
                display: none;
            }

            .hero-container {
                width: 90%;
            }

            .hero-content {
                padding-top: 55px;
            }

            .hero-title {
                font-size: 43px;
                letter-spacing: -2px;
            }

            .hero-description {
                font-size: 13px;
            }

            .buttons {
                flex-direction: column;
            }

            .btn {
                width: 205px;
            }

            .hero-visual {
                height: 340px;
            }

            .visual-card {
                width: 95%;
                height: 290px;
            }

            .visual-bg {
                width: 290px;
                height: 290px;
            }

            .mini-card {
                display: none;
            }

            .services {
                grid-template-columns: 1fr;
            }

            .service {
                border-right: none;
            }

            .category-grid {
                grid-template-columns: 1fr;
            }

            .why-grid {
                grid-template-columns: 1fr;
            }

            .section {
                padding: 65px 6%;
            }

            .section-header h2 {
                font-size: 29px;
            }

            .arrow {
                width: 34px;
                height: 34px;
            }

            .left-arrow {
                left: 9px;
            }

            .right-arrow {
                right: 9px;
            }

            .dots {
                left: 50%;
                transform: translateX(-50%);
            }
        }

    </style>

</head>


<body>


<!-- =====================================================
     TOP BAR
===================================================== -->

<div class="top-bar">

    Free shipping on orders above ₹999
    &nbsp; • &nbsp;
    <strong>ShopSphere Special Offers</strong>

</div>


<!-- =====================================================
     NAVBAR
===================================================== -->

<header class="navbar">

    <a href="index.jsp" class="logo">
        Shop<span>Sphere</span>
    </a>


    <nav class="nav-links">

        <a href="index.jsp" class="active">
            Home
        </a>

        <a href="products">
            Products
        </a>

        <a href="products">
            Categories
        </a>

        <a href="#why">
            About
        </a>

    </nav>


    <div class="nav-actions">

        <a href="products"
           class="nav-icon"
           title="Search">
            ⌕
        </a>

        <a href="cart"
           class="nav-icon"
           title="Cart">
            🛒
        </a>

        <a href="login"
           class="login-btn">
            Login
        </a>

    </div>

</header>


<!-- =====================================================
     HERO SLIDER
===================================================== -->

<section class="hero">


    <!-- =================================================
         SLIDE 1
    ================================================== -->

    <div class="slide active">

        <div class="hero-container">


            <div class="hero-content">

                <div class="eyebrow">
                    New Season Collection
                </div>

                <h1 class="hero-title">

                    Discover

                    <br>

                    <span>
                        Something Better.
                    </span>

                </h1>

                <p class="hero-description">

                    Explore quality products, everyday essentials
                    and great deals — all in one simple shopping
                    experience.

                </p>

                <div class="buttons">

                    <a href="products"
                       class="btn btn-primary">
                        Shop Now
                    </a>

                    <a href="products"
                       class="btn btn-secondary">
                        View Products
                    </a>

                </div>

            </div>


            <div class="hero-visual">

                <div class="visual-bg"></div>

                <!-- EMBEDDED PRODUCT ILLUSTRATION -->

                <div class="visual-card">

                    <svg
                        class="product-svg"
                        viewBox="0 0 600 450"
                        xmlns="http://www.w3.org/2000/svg"
                    >

                        <!-- background -->
                        <rect
                            x="45"
                            y="55"
                            width="510"
                            height="340"
                            rx="8"
                            fill="#ffffff"
                        />

                        <!-- laptop -->
                        <rect
                            x="145"
                            y="105"
                            width="300"
                            height="190"
                            rx="10"
                            fill="#172033"
                        />

                        <rect
                            x="158"
                            y="118"
                            width="274"
                            height="164"
                            rx="5"
                            fill="#dbeafe"
                        />

                        <rect
                            x="178"
                            y="140"
                            width="130"
                            height="12"
                            rx="6"
                            fill="#2563eb"
                        />

                        <rect
                            x="178"
                            y="165"
                            width="205"
                            height="9"
                            rx="4"
                            fill="#94a3b8"
                        />

                        <rect
                            x="178"
                            y="187"
                            width="170"
                            height="9"
                            rx="4"
                            fill="#cbd5e1"
                        />

                        <circle
                            cx="372"
                            cy="220"
                            r="28"
                            fill="#2563eb"
                        />

                        <path
                            d="M360 220 L369 229 L386 210"
                            fill="none"
                            stroke="white"
                            stroke-width="6"
                            stroke-linecap="round"
                            stroke-linejoin="round"
                        />

                        <!-- laptop base -->

                        <path
                            d="M115 305
                               L485 305
                               L520 337
                               Q523 345 510 347
                               L90 347
                               Q77 345 80 337
                               Z"
                            fill="#374151"
                        />

                        <rect
                            x="260"
                            y="316"
                            width="80"
                            height="8"
                            rx="4"
                            fill="#6b7280"
                        />

                        <!-- shopping bag -->

                        <path
                            d="M410 225
                               L500 225
                               L488 345
                               L422 345
                               Z"
                            fill="#2563eb"
                        />

                        <path
                            d="M430 225
                               Q455 175 480 225"
                            fill="none"
                            stroke="#172033"
                            stroke-width="9"
                            stroke-linecap="round"
                        />

                        <text
                            x="456"
                            y="285"
                            text-anchor="middle"
                            font-size="17"
                            font-weight="700"
                            fill="white"
                        >
                            SHOP
                        </text>

                    </svg>

                </div>


                <div class="mini-card mini-one">

                    <strong>
                        Free Delivery
                    </strong>

                    <small>
                        On orders above ₹999
                    </small>

                </div>


                <div class="mini-card mini-two">

                    <strong>
                        New Arrivals
                    </strong>

                    <small>
                        Explore now
                    </small>

                </div>

            </div>

        </div>

    </div>



    <!-- =================================================
         SLIDE 2
    ================================================== -->

    <div class="slide">

        <div class="hero-container">


            <div class="hero-content">

                <div class="eyebrow">
                    Weekend Special
                </div>

                <h1 class="hero-title">

                    Great Deals.

                    <br>

                    <span>
                        Better Prices.
                    </span>

                </h1>

                <p class="hero-description">

                    Save more on selected products and discover
                    offers made for your everyday shopping needs.

                </p>

                <div class="buttons">

                    <a href="products"
                       class="btn btn-primary">
                        View Deals
                    </a>

                    <a href="products"
                       class="btn btn-secondary">
                        Shop Products
                    </a>

                </div>

            </div>


            <div class="hero-visual">

                <div class="visual-bg"
                     style="background:#e8f0ff;">
                </div>


                <div class="visual-card">

                    <svg
                        class="product-svg"
                        viewBox="0 0 600 450"
                        xmlns="http://www.w3.org/2000/svg"
                    >

                        <!-- shopping bag -->

                        <rect
                            x="110"
                            y="75"
                            width="380"
                            height="320"
                            rx="8"
                            fill="#ffffff"
                        />

                        <path
                            d="M190 170
                               L410 170
                               L390 350
                               L210 350
                               Z"
                            fill="#2563eb"
                        />

                        <path
                            d="M245 170
                               Q300 70 355 170"
                            fill="none"
                            stroke="#111827"
                            stroke-width="13"
                            stroke-linecap="round"
                        />

                        <!-- sale circle -->

                        <circle
                            cx="300"
                            cy="245"
                            r="63"
                            fill="#ffffff"
                        />

                        <text
                            x="300"
                            y="238"
                            text-anchor="middle"
                            font-size="22"
                            font-weight="800"
                            fill="#111827"
                        >
                            SALE
                        </text>

                        <text
                            x="300"
                            y="267"
                            text-anchor="middle"
                            font-size="27"
                            font-weight="800"
                            fill="#2563eb"
                        >
                            40%
                        </text>

                        <!-- small product cards -->

                        <rect
                            x="75"
                            y="110"
                            width="75"
                            height="75"
                            rx="7"
                            fill="#eff6ff"
                        />

                        <rect
                            x="450"
                            y="275"
                            width="75"
                            height="75"
                            rx="7"
                            fill="#eff6ff"
                        />

                        <circle
                            cx="112"
                            cy="148"
                            r="22"
                            fill="#2563eb"
                        />

                        <rect
                            x="470"
                            y="295"
                            width="35"
                            height="35"
                            rx="6"
                            fill="#2563eb"
                        />

                    </svg>

                </div>


                <div class="mini-card mini-one">

                    <strong>
                        Special Offer
                    </strong>

                    <small>
                        Limited time only
                    </small>

                </div>


                <div class="mini-card mini-two">

                    <strong>
                        Save More
                    </strong>

                    <small>
                        Shop selected products
                    </small>

                </div>

            </div>

        </div>

    </div>



    <!-- =================================================
         SLIDE 3
    ================================================== -->

    <div class="slide">

        <div class="hero-container">


            <div class="hero-content">

                <div class="eyebrow">
                    ShopSphere Essentials
                </div>

                <h1 class="hero-title">

                    Everything

                    <br>

                    <span>
                        You Need.
                    </span>

                </h1>

                <p class="hero-description">

                    Find products that fit your lifestyle with
                    an easy-to-use shopping experience built
                    around you.

                </p>

                <div class="buttons">

                    <a href="products"
                       class="btn btn-primary">
                        Explore Now
                    </a>

                    <a href="#why"
                       class="btn btn-secondary">
                        Why Shop With Us
                    </a>

                </div>

            </div>


            <div class="hero-visual">

                <div class="visual-bg"
                     style="background:#eaf2ff;">
                </div>


                <div class="visual-card">

                    <svg
                        class="product-svg"
                        viewBox="0 0 600 450"
                        xmlns="http://www.w3.org/2000/svg"
                    >

                        <rect
                            x="60"
                            y="60"
                            width="480"
                            height="330"
                            rx="8"
                            fill="#ffffff"
                        />

                        <!-- phone -->

                        <rect
                            x="220"
                            y="85"
                            width="160"
                            height="285"
                            rx="24"
                            fill="#111827"
                        />

                        <rect
                            x="231"
                            y="102"
                            width="138"
                            height="250"
                            rx="15"
                            fill="#dbeafe"
                        />

                        <rect
                            x="253"
                            y="125"
                            width="95"
                            height="9"
                            rx="4"
                            fill="#2563eb"
                        />

                        <rect
                            x="253"
                            y="148"
                            width="70"
                            height="7"
                            rx="4"
                            fill="#94a3b8"
                        />

                        <!-- product cards -->

                        <rect
                            x="250"
                            y="180"
                            width="100"
                            height="55"
                            rx="7"
                            fill="white"
                        />

                        <circle
                            cx="272"
                            cy="207"
                            r="16"
                            fill="#2563eb"
                        />

                        <rect
                            x="297"
                            y="198"
                            width="36"
                            height="6"
                            rx="3"
                            fill="#64748b"
                        />

                        <rect
                            x="250"
                            y="247"
                            width="100"
                            height="55"
                            rx="7"
                            fill="white"
                        />

                        <rect
                            x="264"
                            y="261"
                            width="32"
                            height="28"
                            rx="5"
                            fill="#2563eb"
                        />

                        <rect
                            x="303"
                            y="267"
                            width="34"
                            height="6"
                            rx="3"
                            fill="#64748b"
                        />

                        <!-- surrounding products -->

                        <rect
                            x="105"
                            y="145"
                            width="85"
                            height="85"
                            rx="8"
                            fill="#eff6ff"
                        />

                        <circle
                            cx="147"
                            cy="187"
                            r="27"
                            fill="#2563eb"
                        />

                        <rect
                            x="415"
                            y="235"
                            width="85"
                            height="85"
                            rx="8"
                            fill="#eff6ff"
                        />

                        <rect
                            x="438"
                            y="258"
                            width="40"
                            height="40"
                            rx="7"
                            fill="#2563eb"
                        />

                    </svg>

                </div>


                <div class="mini-card mini-one">

                    <strong>
                        Easy Shopping
                    </strong>

                    <small>
                        Simple & secure
                    </small>

                </div>


                <div class="mini-card mini-two">

                    <strong>
                        Quality Products
                    </strong>

                    <small>
                        Shop with confidence
                    </small>

                </div>

            </div>

        </div>

    </div>



    <!-- ARROWS -->

    <button
        class="arrow left-arrow"
        onclick="previousSlide()"
        aria-label="Previous slide"
    >
        ‹
    </button>

    <button
        class="arrow right-arrow"
        onclick="nextSlide()"
        aria-label="Next slide"
    >
        ›
    </button>


    <!-- DOTS -->

    <div class="dots">

        <button
            class="dot active"
            onclick="goToSlide(0)"
        ></button>

        <button
            class="dot"
            onclick="goToSlide(1)"
        ></button>

        <button
            class="dot"
            onclick="goToSlide(2)"
        ></button>

    </div>

</section>



<!-- =====================================================
     SERVICES
===================================================== -->

<section class="services">


    <div class="service">

        <div class="service-icon">
            🚚
        </div>

        <div>
            <strong>
                Free Delivery
            </strong>

            <small>
                On orders above ₹999
            </small>
        </div>

    </div>


    <div class="service">

        <div class="service-icon">
            🔒
        </div>

        <div>
            <strong>
                Secure Payment
            </strong>

            <small>
                100% secure checkout
            </small>
        </div>

    </div>


    <div class="service">

        <div class="service-icon">
            ↩
        </div>

        <div>
            <strong>
                Easy Returns
            </strong>

            <small>
                Simple return process
            </small>
        </div>

    </div>


    <div class="service">

        <div class="service-icon">
            ♡
        </div>

        <div>
            <strong>
                Customer Support
            </strong>

            <small>
                We're here to help
            </small>
        </div>

    </div>

</section>



<!-- =====================================================
     CATEGORIES
===================================================== -->

<section class="section">


    <div class="section-header">

        <small>
            Shop by Category
        </small>

        <h2>
            Find What You're Looking For
        </h2>

        <p>
            Explore our collection and discover products
            for every need.
        </p>

    </div>


    <div class="category-grid">


        <a href="products"
           class="category">

            <span class="category-number">
                01
            </span>

            <div class="category-visual">

                <svg
                    width="62"
                    height="62"
                    viewBox="0 0 62 62"
                >

                    <rect
                        x="4"
                        y="4"
                        width="54"
                        height="54"
                        rx="12"
                        fill="#eff6ff"
                    />

                    <path
                        d="M17 25
                           L45 25
                           L42 47
                           L20 47
                           Z"
                        fill="#2563eb"
                    />

                    <path
                        d="M23 25
                           Q31 11 39 25"
                        fill="none"
                        stroke="#111827"
                        stroke-width="4"
                    />

                </svg>

            </div>

            <h3>
                Fashion
            </h3>

            <p>
                Everyday styles and essentials
            </p>

        </a>


        <a href="products"
           class="category">

            <span class="category-number">
                02
            </span>

            <div class="category-visual">

                <svg
                    width="62"
                    height="62"
                    viewBox="0 0 62 62"
                >

                    <rect
                        x="4"
                        y="4"
                        width="54"
                        height="54"
                        rx="12"
                        fill="#eff6ff"
                    />

                    <rect
                        x="14"
                        y="17"
                        width="34"
                        height="23"
                        rx="3"
                        fill="#2563eb"
                    />

                    <path
                        d="M9 44
                           H53"
                        stroke="#111827"
                        stroke-width="4"
                        stroke-linecap="round"
                    />

                    <circle
                        cx="31"
                        cy="28"
                        r="3"
                        fill="white"
                    />

                </svg>

            </div>

            <h3>
                Electronics
            </h3>

            <p>
                Smart products and accessories
            </p>

        </a>


        <a href="products"
           class="category">

            <span class="category-number">
                03
            </span>

            <div class="category-visual">

                <svg
                    width="62"
                    height="62"
                    viewBox="0 0 62 62"
                >

                    <rect
                        x="4"
                        y="4"
                        width="54"
                        height="54"
                        rx="12"
                        fill="#eff6ff"
                    />

                    <path
                        d="M15 29
                           L31 17
                           L47 29
                           V46
                           H15
                           Z"
                        fill="#2563eb"
                    />

                    <rect
                        x="27"
                        y="35"
                        width="8"
                        height="11"
                        fill="white"
                    />

                </svg>

            </div>

            <h3>
                Home & Living
            </h3>

            <p>
                Products for your everyday space
            </p>

        </a>


        <a href="products"
           class="category">

            <span class="category-number">
                04
            </span>

            <div class="category-visual">

                <svg
                    width="62"
                    height="62"
                    viewBox="0 0 62 62"
                >

                    <rect
                        x="4"
                        y="4"
                        width="54"
                        height="54"
                        rx="12"
                        fill="#eff6ff"
                    />

                    <path
                        d="M17 29
                           Q17 18 31 18
                           Q45 18 45 29"
                        fill="none"
                        stroke="#2563eb"
                        stroke-width="6"
                    />

                    <rect
                        x="12"
                        y="27"
                        width="10"
                        height="18"
                        rx="4"
                        fill="#111827"
                    />

                    <rect
                        x="40"
                        y="27"
                        width="10"
                        height="18"
                        rx="4"
                        fill="#111827"
                    />

                </svg>

            </div>

            <h3>
                Accessories
            </h3>

            <p>
                Complete your everyday setup
            </p>

        </a>

    </div>

</section>



<!-- =====================================================
     WHY SHOP WITH US
===================================================== -->

<section
    class="section why-section"
    id="why"
>


    <div class="section-header">

        <small>
            ShopSphere Experience
        </small>

        <h2>
            Why Shop With Us
        </h2>

        <p>
            Everything you need for a simple and reliable
            shopping experience.
        </p>

    </div>


    <div class="why-grid">


        <div class="why">

            <div class="why-icon">
                🚚
            </div>

            <h3>
                Fast Delivery
            </h3>

            <p>
                Quick and reliable delivery
                right to your doorstep.
            </p>

        </div>


        <div class="why">

            <div class="why-icon">
                🔐
            </div>

            <h3>
                Secure Shopping
            </h3>

            <p>
                Your account and checkout
                are protected.
            </p>

        </div>


        <div class="why">

            <div class="why-icon">
                ✓
            </div>

            <h3>
                Quality Products
            </h3>

            <p>
                Discover products selected
                for quality and value.
            </p>

        </div>


        <div class="why">

            <div class="why-icon">
                ♡
            </div>

            <h3>
                Customer First
            </h3>

            <p>
                A smooth experience from
                browsing to delivery.
            </p>

        </div>

    </div>

</section>



<!-- =====================================================
     FOOTER
===================================================== -->

<footer>

    © 2026
    <strong>ShopSphere</strong>.
    All rights reserved.

</footer>



<!-- =====================================================
     SLIDER JAVASCRIPT
===================================================== -->

<script>

    let currentSlide = 0;

    let timer;


    const slides =
        document.querySelectorAll(".slide");

    const dots =
        document.querySelectorAll(".dot");


    function showSlide(index) {

        if (index >= slides.length) {
            index = 0;
        }

        if (index < 0) {
            index = slides.length - 1;
        }

        currentSlide = index;


        slides.forEach(function(slide) {

            slide.classList.remove("active");

        });


        dots.forEach(function(dot) {

            dot.classList.remove("active");

        });


        slides[currentSlide]
            .classList.add("active");


        dots[currentSlide]
            .classList.add("active");

    }


    function nextSlide() {

        showSlide(currentSlide + 1);

        restartTimer();

    }


    function previousSlide() {

        showSlide(currentSlide - 1);

        restartTimer();

    }


    function goToSlide(index) {

        showSlide(index);

        restartTimer();

    }


    function startTimer() {

        timer = setInterval(function() {

            showSlide(currentSlide + 1);

        }, 5000);

    }


    function restartTimer() {

        clearInterval(timer);

        startTimer();

    }


    startTimer();

</script>


</body>

</html>