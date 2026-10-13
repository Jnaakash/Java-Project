<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Order Placed | ShopSphere</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap"
          rel="stylesheet">

    <style>

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: "Inter", sans-serif;
            min-height: 100vh;
            background:
                radial-gradient(circle at 15% 20%, rgba(37,99,235,.14), transparent 30%),
                radial-gradient(circle at 85% 80%, rgba(124,58,237,.12), transparent 30%),
                #f7f9fc;
            color: #111827;
        }

        .navbar {
            height: 72px;
            background: rgba(255,255,255,.92);
            backdrop-filter: blur(14px);
            border-bottom: 1px solid #e5e7eb;

            display: flex;
            align-items: center;
            justify-content: space-between;

            padding: 0 7%;
            position: sticky;
            top: 0;
            z-index: 10;
        }

        .brand {
            text-decoration: none;
            color: #111827;
            font-size: 23px;
            font-weight: 800;
            letter-spacing: -.6px;
        }

        .brand span {
            color: #2563eb;
        }

        .nav-links {
            display: flex;
            gap: 28px;
            align-items: center;
        }

        .nav-links a {
            text-decoration: none;
            color: #4b5563;
            font-size: 14px;
            font-weight: 600;
            transition: .2s;
        }

        .nav-links a:hover {
            color: #2563eb;
        }

        .page {
            min-height: calc(100vh - 72px);

            display: flex;
            justify-content: center;
            align-items: center;

            padding: 50px 20px;
        }

        .success-card {
            width: 100%;
            max-width: 650px;

            background: rgba(255,255,255,.94);
            border: 1px solid #e5e7eb;
            border-radius: 26px;

            padding: 48px 40px;

            text-align: center;

            box-shadow:
                0 25px 70px rgba(15,23,42,.10);

            animation: cardIn .65s ease;
        }

        @keyframes cardIn {
            from {
                opacity: 0;
                transform: translateY(25px) scale(.97);
            }

            to {
                opacity: 1;
                transform: translateY(0) scale(1);
            }
        }

        .success-icon {
            width: 90px;
            height: 90px;

            margin: 0 auto 25px;

            border-radius: 50%;

            display: flex;
            align-items: center;
            justify-content: center;

            background: #dcfce7;
            color: #16a34a;

            font-size: 46px;
            font-weight: 700;

            animation: pop .7s ease .15s both;
        }

        @keyframes pop {
            from {
                transform: scale(.4);
                opacity: 0;
            }

            70% {
                transform: scale(1.08);
            }

            to {
                transform: scale(1);
                opacity: 1;
            }
        }

        .success-card h1 {
            font-size: 32px;
            margin-bottom: 12px;
            color: #111827;
        }

        .success-card .subtitle {
            color: #6b7280;
            line-height: 1.7;
            font-size: 15px;
            max-width: 470px;
            margin: auto;
        }

        .order-box {
            margin: 30px 0;

            padding: 20px;

            border-radius: 16px;

            background: #f8fafc;
            border: 1px solid #e5e7eb;
        }

        .order-label {
            color: #6b7280;
            font-size: 13px;
            margin-bottom: 7px;
        }

        .order-id {
            color: #2563eb;
            font-size: 24px;
            font-weight: 800;
        }

        .info-row {
            display: flex;
            justify-content: center;
            gap: 35px;

            margin: 25px 0;

            color: #4b5563;
            font-size: 13px;
        }

        .info-item {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .actions {
            display: flex;
            justify-content: center;
            gap: 12px;
            flex-wrap: wrap;
        }

        .btn {
            text-decoration: none;
            border-radius: 12px;
            padding: 13px 21px;
            font-size: 14px;
            font-weight: 700;
            transition: .2s;
        }

        .btn-primary {
            color: white;
            background: #2563eb;
            box-shadow: 0 8px 20px rgba(37,99,235,.22);
        }

        .btn-primary:hover {
            background: #1d4ed8;
            transform: translateY(-2px);
        }

        .btn-secondary {
            color: #374151;
            background: white;
            border: 1px solid #d1d5db;
        }

        .btn-secondary:hover {
            border-color: #2563eb;
            color: #2563eb;
            transform: translateY(-2px);
        }

        .note {
            margin-top: 28px;
            color: #9ca3af;
            font-size: 12px;
        }

        @media (max-width: 650px) {

            .navbar {
                padding: 0 20px;
            }

            .nav-links {
                gap: 14px;
            }

            .nav-links a:nth-child(2),
            .nav-links a:nth-child(3) {
                display: none;
            }

            .success-card {
                padding: 38px 22px;
                border-radius: 20px;
            }

            .success-card h1 {
                font-size: 26px;
            }

            .info-row {
                flex-direction: column;
                gap: 12px;
            }
        }

    </style>
</head>

<body>

<nav class="navbar">

    <a class="brand"
       href="${pageContext.request.contextPath}/">
        Shop<span>Sphere</span>
    </a>

    <div class="nav-links">
        <a href="${pageContext.request.contextPath}/products">Products</a>
        <a href="${pageContext.request.contextPath}/orders">My Orders</a>
        <a href="${pageContext.request.contextPath}/cart">Cart</a>
    </div>

</nav>


<main class="page">

    <section class="success-card">

        <div class="success-icon">
            ✓
        </div>

        <h1>Order Placed Successfully!</h1>

        <p class="subtitle">
            Thank you for shopping with ShopSphere.
            Your order has been successfully placed and is now being processed.
        </p>


        <div class="order-box">

            <div class="order-label">
                Your Order ID
            </div>

            <div class="order-id">
                #${orderId}
            </div>

        </div>


        <div class="info-row">

            <div class="info-item">
                ✓ Order Confirmed
            </div>

            <div class="info-item">
                ✓ Payment Recorded
            </div>

            <div class="info-item">
                ✓ Processing Started
            </div>

        </div>


        <div class="actions">

            <a class="btn btn-primary"
               href="${pageContext.request.contextPath}/order-details?id=${orderId}">
                View Order Details
            </a>

            <a class="btn btn-secondary"
               href="${pageContext.request.contextPath}/orders">
                My Orders
            </a>

            <a class="btn btn-secondary"
               href="${pageContext.request.contextPath}/products">
                Continue Shopping
            </a>

        </div>


        <p class="note">
            Keep your order ID for future reference.
        </p>

    </section>

</main>

</body>
</html>