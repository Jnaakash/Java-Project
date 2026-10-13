<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>

    <title>ShopSphere - Create Account</title>

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <style>

        /* =====================================================
           RESET
        ===================================================== */

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }


        /* =====================================================
           BODY / ANIMATED BACKGROUND
        ===================================================== */

        body {

            font-family: Arial, Helvetica, sans-serif;

            min-height: 100vh;

            display: flex;
            align-items: center;
            justify-content: center;

            padding: 30px 15px;

            overflow-x: hidden;

            background:
                linear-gradient(
                    120deg,
                    #020617,
                    #0f172a,
                    #172554,
                    #312e81,
                    #1e1b4b,
                    #020617
                );

            background-size: 400% 400%;

            animation:
                backgroundMove 15s ease infinite;

            position: relative;
        }


        @keyframes backgroundMove {

            0% {
                background-position: 0% 50%;
            }

            25% {
                background-position: 50% 100%;
            }

            50% {
                background-position: 100% 50%;
            }

            75% {
                background-position: 50% 0%;
            }

            100% {
                background-position: 0% 50%;
            }
        }


        /* =====================================================
           ANIMATED GRID
        ===================================================== */

        .background-grid {

            position: fixed;

            inset: 0;

            pointer-events: none;

            opacity: 0.18;

            background-image:
                linear-gradient(
                    rgba(147,197,253,0.18) 1px,
                    transparent 1px
                ),
                linear-gradient(
                    90deg,
                    rgba(147,197,253,0.18) 1px,
                    transparent 1px
                );

            background-size: 55px 55px;

            transform:
                perspective(500px)
                rotateX(60deg)
                scale(1.5);

            transform-origin:
                center bottom;

            animation:
                gridMove 12s linear infinite;
        }


        @keyframes gridMove {

            from {
                background-position: 0 0;
            }

            to {
                background-position: 0 55px;
            }
        }


        /* =====================================================
           GLOWING ORBS
        ===================================================== */

        .orb {

            position: fixed;

            border-radius: 50%;

            pointer-events: none;

            filter: blur(4px);

            opacity: 0.65;

            z-index: 0;
        }


        .orb-one {

            width: 320px;
            height: 320px;

            top: -100px;
            left: -90px;

            background:
                radial-gradient(
                    circle,
                    rgba(59,130,246,0.75),
                    rgba(59,130,246,0)
                );

            animation:
                orbOneMove 10s ease-in-out infinite alternate;
        }


        .orb-two {

            width: 380px;
            height: 380px;

            right: -120px;
            bottom: -130px;

            background:
                radial-gradient(
                    circle,
                    rgba(139,92,246,0.65),
                    rgba(139,92,246,0)
                );

            animation:
                orbTwoMove 13s ease-in-out infinite alternate;
        }


        .orb-three {

            width: 240px;
            height: 240px;

            right: 25%;
            top: 8%;

            background:
                radial-gradient(
                    circle,
                    rgba(14,165,233,0.55),
                    rgba(14,165,233,0)
                );

            animation:
                orbThreeMove 9s ease-in-out infinite alternate;
        }


        @keyframes orbOneMove {

            from {
                transform:
                    translate(0,0)
                    scale(1);
            }

            to {
                transform:
                    translate(120px,80px)
                    scale(1.2);
            }
        }


        @keyframes orbTwoMove {

            from {
                transform:
                    translate(0,0)
                    scale(1);
            }

            to {
                transform:
                    translate(-100px,-80px)
                    scale(1.15);
            }
        }


        @keyframes orbThreeMove {

            from {
                transform:
                    translate(0,0);
            }

            to {
                transform:
                    translate(-80px,100px);
            }
        }


        /* =====================================================
           PARTICLES
        ===================================================== */

        .particles {

            position: fixed;

            inset: 0;

            pointer-events: none;

            z-index: 1;

            overflow: hidden;
        }


        .particle {

            position: absolute;

            width: 4px;
            height: 4px;

            border-radius: 50%;

            background:
                rgba(191,219,254,0.85);

            box-shadow:
                0 0 12px
                rgba(96,165,250,0.9);

            animation:
                particleFloat linear infinite;
        }


        .particle:nth-child(1) {
            left: 8%;
            top: 80%;
            animation-duration: 8s;
            animation-delay: -2s;
        }

        .particle:nth-child(2) {
            left: 18%;
            top: 60%;
            animation-duration: 11s;
            animation-delay: -5s;
        }

        .particle:nth-child(3) {
            left: 30%;
            top: 90%;
            animation-duration: 9s;
            animation-delay: -1s;
        }

        .particle:nth-child(4) {
            left: 42%;
            top: 70%;
            animation-duration: 13s;
            animation-delay: -7s;
        }

        .particle:nth-child(5) {
            left: 55%;
            top: 85%;
            animation-duration: 10s;
            animation-delay: -3s;
        }

        .particle:nth-child(6) {
            left: 67%;
            top: 65%;
            animation-duration: 12s;
            animation-delay: -6s;
        }

        .particle:nth-child(7) {
            left: 78%;
            top: 90%;
            animation-duration: 9s;
            animation-delay: -4s;
        }

        .particle:nth-child(8) {
            left: 90%;
            top: 75%;
            animation-duration: 14s;
            animation-delay: -8s;
        }


        @keyframes particleFloat {

            0% {

                transform:
                    translateY(100px)
                    translateX(0)
                    scale(0.5);

                opacity: 0;
            }

            20% {
                opacity: 1;
            }

            50% {

                transform:
                    translateY(-350px)
                    translateX(40px)
                    scale(1);
            }

            80% {
                opacity: 0.8;
            }

            100% {

                transform:
                    translateY(-700px)
                    translateX(-30px)
                    scale(0.3);

                opacity: 0;
            }
        }


        /* =====================================================
           MOUSE GLOW
        ===================================================== */

        .mouse-glow {

            position: fixed;

            width: 400px;
            height: 400px;

            border-radius: 50%;

            pointer-events: none;

            background:
                radial-gradient(
                    circle,
                    rgba(96,165,250,0.18),
                    transparent 65%
                );

            transform:
                translate(-50%, -50%);

            z-index: 2;

            transition:
                left 0.12s ease,
                top 0.12s ease;
        }


        /* =====================================================
           MAIN GLASS CARD
        ===================================================== */

        .register-wrapper {

            width: 100%;

            max-width: 1050px;

            min-height: 650px;

            display: grid;

            grid-template-columns:
                45% 55%;

            position: relative;

            z-index: 10;

            overflow: hidden;

            border-radius: 28px;

            /* TRANSPARENT GLASS */

            background:
                rgba(255,255,255,0.16);

            border:
                1px solid
                rgba(255,255,255,0.35);

            backdrop-filter:
                blur(24px);

            -webkit-backdrop-filter:
                blur(24px);

            box-shadow:

                0 35px 100px
                rgba(0,0,0,0.40),

                inset 0 1px 1px
                rgba(255,255,255,0.35),

                0 0 80px
                rgba(59,130,246,0.12);

            animation:
                cardEnter 0.9s
                cubic-bezier(0.22,1,0.36,1)
                forwards;

            opacity: 0;

            transform:
                translateY(35px)
                scale(0.97);
        }


        @keyframes cardEnter {

            to {

                opacity: 1;

                transform:
                    translateY(0)
                    scale(1);
            }
        }


        /* =====================================================
           LEFT GLASS BRAND SECTION
        ===================================================== */

        .brand-section {

            position: relative;

            padding: 55px 45px;

            color: white;

            overflow: hidden;

            background:

                linear-gradient(
                    145deg,
                    rgba(23,37,84,0.82),
                    rgba(37,99,235,0.68),
                    rgba(79,70,229,0.72)
                );

            border-right:
                1px solid
                rgba(255,255,255,0.18);

            display: flex;

            flex-direction: column;

            justify-content: center;
        }


        /* =====================================================
           BRAND DECORATION
        ===================================================== */

        .brand-section::before {

            content: "";

            position: absolute;

            width: 300px;
            height: 300px;

            border-radius: 50%;

            top: -110px;
            right: -100px;

            background:
                rgba(255,255,255,0.10);

            border:
                1px solid
                rgba(255,255,255,0.10);

            box-shadow:
                0 0 50px
                rgba(255,255,255,0.06);

            animation:
                brandCircle 8s
                ease-in-out infinite alternate;
        }


        .brand-section::after {

            content: "";

            position: absolute;

            width: 230px;
            height: 230px;

            border-radius: 50%;

            bottom: -100px;
            left: -80px;

            background:
                rgba(255,255,255,0.08);

            border:
                1px solid
                rgba(255,255,255,0.08);

            animation:
                brandCircleTwo 10s
                ease-in-out infinite alternate;
        }


        @keyframes brandCircle {

            from {
                transform:
                    scale(1)
                    rotate(0deg);
            }

            to {
                transform:
                    scale(1.25)
                    rotate(20deg);
            }
        }


        @keyframes brandCircleTwo {

            from {
                transform:
                    translate(0,0);
            }

            to {
                transform:
                    translate(40px,-40px);
            }
        }


        /* =====================================================
           BRAND CONTENT
        ===================================================== */

        .brand-logo {

            position: relative;

            z-index: 3;

            font-size: 34px;

            font-weight: 800;

            letter-spacing: -1px;

            margin-bottom: 18px;

            text-shadow:
                0 4px 20px
                rgba(0,0,0,0.15);
        }


        .brand-logo span {

            color: #bfdbfe;
        }


        .brand-title {

            position: relative;

            z-index: 3;

            font-size: 42px;

            line-height: 1.15;

            margin-bottom: 20px;

            text-shadow:
                0 4px 25px
                rgba(0,0,0,0.18);
        }


        .brand-description {

            position: relative;

            z-index: 3;

            color: #e0ecff;

            font-size: 16px;

            line-height: 1.7;

            max-width: 390px;

            margin-bottom: 35px;
        }


        /* =====================================================
           BENEFITS
        ===================================================== */

        .benefits {

            position: relative;

            z-index: 3;
        }


        .benefit {

            display: flex;

            align-items: center;

            gap: 13px;

            margin-bottom: 18px;

            color: #f8fbff;

            font-size: 15px;

            transition:
                transform 0.25s ease;
        }


        .benefit:hover {

            transform:
                translateX(7px);
        }


        .benefit-icon {

            width: 38px;
            height: 38px;

            flex-shrink: 0;

            border-radius: 12px;

            display: flex;

            align-items: center;

            justify-content: center;

            font-size: 18px;

            background:
                rgba(255,255,255,0.15);

            border:
                1px solid
                rgba(255,255,255,0.20);

            backdrop-filter:
                blur(10px);

            -webkit-backdrop-filter:
                blur(10px);

            box-shadow:
                inset 0 1px 1px
                rgba(255,255,255,0.20);
        }


        /* =====================================================
           RIGHT GLASS FORM SECTION
        ===================================================== */

        .form-section {

            padding: 55px 65px;

            display: flex;

            align-items: center;

            justify-content: center;

            position: relative;

            overflow: hidden;

            /* IMPORTANT TRANSPARENT PART */

            background:
                rgba(255,255,255,0.72);

            backdrop-filter:
                blur(22px);

            -webkit-backdrop-filter:
                blur(22px);
        }


        /* Soft light inside form */

        .form-section::before {

            content: "";

            position: absolute;

            width: 250px;
            height: 250px;

            border-radius: 50%;

            top: -120px;
            right: -80px;

            background:
                rgba(96,165,250,0.16);

            filter:
                blur(20px);

            pointer-events: none;
        }


        .form-section::after {

            content: "";

            position: absolute;

            width: 180px;
            height: 180px;

            border-radius: 50%;

            bottom: -80px;
            left: -60px;

            background:
                rgba(129,140,248,0.13);

            filter:
                blur(20px);

            pointer-events: none;
        }


        .form-container {

            width: 100%;

            max-width: 440px;

            position: relative;

            z-index: 5;
        }


        /* =====================================================
           HEADER
        ===================================================== */

        .form-header {

            margin-bottom: 28px;
        }


        .form-header h1 {

            color: #111827;

            font-size: 32px;

            margin-bottom: 9px;
        }


        .form-header p {

            color: #64748b;

            font-size: 14px;
        }


        /* =====================================================
           ALERT
        ===================================================== */

        .alert {

            padding: 12px 15px;

            border-radius: 12px;

            margin-bottom: 20px;

            font-size: 14px;

            animation:
                alertEnter 0.4s ease;
        }


        @keyframes alertEnter {

            from {

                opacity: 0;

                transform:
                    translateY(-8px);
            }

            to {

                opacity: 1;

                transform:
                    translateY(0);
            }
        }


        .success {

            color: #166534;

            background:
                rgba(220,252,231,0.88);

            border:
                1px solid
                rgba(187,247,208,0.9);
        }


        .error {

            color: #b91c1c;

            background:
                rgba(254,226,226,0.88);

            border:
                1px solid
                rgba(254,202,202,0.9);
        }


        /* =====================================================
           FORM
        ===================================================== */

        .form-group {

            margin-bottom: 18px;
        }


        .form-group label {

            display: block;

            color: #374151;

            font-size: 14px;

            font-weight: 600;

            margin-bottom: 8px;
        }


        .input-wrapper {

            position: relative;
        }


        .input-icon {

            position: absolute;

            left: 15px;

            top: 50%;

            transform:
                translateY(-50%);

            font-size: 17px;

            z-index: 3;
        }


        .form-group input {

            width: 100%;

            height: 50px;

            border:
                1px solid
                rgba(148,163,184,0.30);

            border-radius: 13px;

            padding:
                0 15px 0 45px;

            outline: none;

            font-size: 14px;

            color: #111827;

            /* GLASS INPUT */

            background:
                rgba(255,255,255,0.58);

            backdrop-filter:
                blur(10px);

            -webkit-backdrop-filter:
                blur(10px);

            transition:
                all 0.25s ease;

            box-shadow:
                inset 0 1px 1px
                rgba(255,255,255,0.60);
        }


        .form-group input:hover {

            background:
                rgba(255,255,255,0.75);

            border-color:
                rgba(96,165,250,0.45);
        }


        .form-group input:focus {

            border-color:
                rgba(37,99,235,0.75);

            background:
                rgba(255,255,255,0.88);

            box-shadow:

                0 0 0 4px
                rgba(37,99,235,0.10),

                0 8px 25px
                rgba(37,99,235,0.08);

            transform:
                translateY(-1px);
        }


        /* =====================================================
           PASSWORD NOTE
        ===================================================== */

        .password-note {

            margin-top: -8px;

            margin-bottom: 16px;

            font-size: 12px;

            color: #64748b;
        }


        /* =====================================================
           REGISTER BUTTON
        ===================================================== */

        .register-btn {

            width: 100%;

            height: 52px;

            border: none;

            border-radius: 14px;

            background:

                linear-gradient(
                    135deg,
                    #2563eb,
                    #4f46e5
                );

            color: white;

            font-size: 16px;

            font-weight: 700;

            cursor: pointer;

            margin-top: 8px;

            position: relative;

            overflow: hidden;

            box-shadow:

                0 12px 30px
                rgba(37,99,235,0.28),

                inset 0 1px 1px
                rgba(255,255,255,0.25);

            transition:
                all 0.25s ease;
        }


        .register-btn::before {

            content: "";

            position: absolute;

            top: 0;

            left: -120%;

            width: 70%;

            height: 100%;

            background:

                linear-gradient(
                    90deg,
                    transparent,
                    rgba(255,255,255,0.30),
                    transparent
                );

            transform:
                skewX(-20deg);

            transition:
                left 0.6s ease;
        }


        .register-btn:hover::before {

            left: 140%;
        }


        .register-btn:hover {

            transform:
                translateY(-3px);

            box-shadow:

                0 18px 38px
                rgba(37,99,235,0.38);
        }


        .register-btn:active {

            transform:
                translateY(0);
        }


        /* =====================================================
           LOGIN LINK
        ===================================================== */

        .login-link {

            text-align: center;

            margin-top: 24px;

            color: #64748b;

            font-size: 14px;
        }


        .login-link a {

            color: #2563eb;

            font-weight: 700;

            text-decoration: none;

            transition:
                all 0.2s ease;
        }


        .login-link a:hover {

            color: #4f46e5;

            text-decoration: underline;
        }


        /* =====================================================
           MOBILE
        ===================================================== */

        @media (max-width: 850px) {

            .register-wrapper {

                grid-template-columns: 1fr;

                max-width: 550px;
            }


            .brand-section {

                padding: 40px;

                min-height: 300px;
            }


            .brand-title {

                font-size: 34px;
            }


            .brand-description {

                margin-bottom: 20px;
            }


            .benefits {

                display: grid;

                grid-template-columns:
                    1fr 1fr;

                gap: 8px;
            }


            .benefit {

                margin-bottom: 5px;
            }


            .form-section {

                padding: 45px 40px;
            }
        }


        @media (max-width: 500px) {

            body {

                padding: 15px;
            }


            .register-wrapper {

                border-radius: 20px;
            }


            .brand-section {

                padding: 30px 25px;
            }


            .brand-logo {

                font-size: 28px;
            }


            .brand-title {

                font-size: 29px;
            }


            .brand-description {

                font-size: 14px;
            }


            .benefits {

                grid-template-columns:
                    1fr;
            }


            .form-section {

                padding: 35px 25px;
            }


            .form-header h1 {

                font-size: 27px;
            }
        }


        /* =====================================================
           ACCESSIBILITY
        ===================================================== */

        @media (prefers-reduced-motion: reduce) {

            *,
            *::before,
            *::after {

                animation-duration:
                    0.01ms !important;

                animation-iteration-count:
                    1 !important;
            }
        }

    </style>

</head>


<body>


<!-- =========================================================
     ANIMATED BACKGROUND
========================================================= -->

<div class="background-grid"></div>

<div class="orb orb-one"></div>

<div class="orb orb-two"></div>

<div class="orb orb-three"></div>


<div class="particles">

    <span class="particle"></span>
    <span class="particle"></span>
    <span class="particle"></span>
    <span class="particle"></span>
    <span class="particle"></span>
    <span class="particle"></span>
    <span class="particle"></span>
    <span class="particle"></span>

</div>


<div class="mouse-glow" id="mouseGlow"></div>



<!-- =========================================================
     REGISTER CARD
========================================================= -->

<div class="register-wrapper">


    <!-- =====================================================
         LEFT BRAND
    ====================================================== -->

    <div class="brand-section">

        <div class="brand-logo">

            Shop<span>Sphere</span>

        </div>


        <h2 class="brand-title">

            Start Your
            Shopping Journey.

        </h2>


        <p class="brand-description">

            Create your ShopSphere account and discover a smarter,
            faster and better way to shop online.

        </p>


        <div class="benefits">


            <div class="benefit">

                <div class="benefit-icon">
                    🛍️
                </div>

                <span>
                    Explore amazing products
                </span>

            </div>


            <div class="benefit">

                <div class="benefit-icon">
                    🛒
                </div>

                <span>
                    Add products to your cart
                </span>

            </div>


            <div class="benefit">

                <div class="benefit-icon">
                    📦
                </div>

                <span>
                    Track your orders easily
                </span>

            </div>


            <div class="benefit">

                <div class="benefit-icon">
                    🔒
                </div>

                <span>
                    Secure account & checkout
                </span>

            </div>


        </div>

    </div>



    <!-- =====================================================
         RIGHT FORM
    ====================================================== -->

    <div class="form-section">

        <div class="form-container">


            <div class="form-header">

                <h1>
                    Create Account
                </h1>

                <p>
                    Join ShopSphere today. It only takes a minute.
                </p>

            </div>



            <!-- SUCCESS -->

            <% if ("1".equals(request.getParameter("success"))) { %>

                <div class="alert success">

                    ✓ Registration successful!

                    You can now login to your account.

                </div>

            <% } %>



            <!-- ERROR -->

            <% if ("1".equals(request.getParameter("error"))) { %>

                <div class="alert error">

                    ✕ Registration failed.
                    Please check your details and try again.

                </div>

            <% } %>



            <!-- =================================================
                 REGISTRATION FORM
            ================================================== -->

            <form
                action="register"
                method="post"
            >


                <!-- NAME -->

                <div class="form-group">

                    <label for="name">
                        Full Name
                    </label>


                    <div class="input-wrapper">

                        <span class="input-icon">
                            👤
                        </span>


                        <input
                            type="text"
                            id="name"
                            name="name"
                            placeholder="Enter your full name"
                            autocomplete="name"
                            required
                        >

                    </div>

                </div>



                <!-- EMAIL -->

                <div class="form-group">

                    <label for="email">
                        Email Address
                    </label>


                    <div class="input-wrapper">

                        <span class="input-icon">
                            ✉️
                        </span>


                        <input
                            type="email"
                            id="email"
                            name="email"
                            placeholder="Enter your email"
                            autocomplete="email"
                            required
                        >

                    </div>

                </div>



                <!-- PASSWORD -->

                <div class="form-group">

                    <label for="password">
                        Password
                    </label>


                    <div class="input-wrapper">

                        <span class="input-icon">
                            🔒
                        </span>


                        <input
                            type="password"
                            id="password"
                            name="password"
                            placeholder="Create a password"
                            autocomplete="new-password"
                            required
                        >

                    </div>

                </div>


                <div class="password-note">

                    Use a strong password to keep your account secure.

                </div>



                <!-- MOBILE -->

                <div class="form-group">

                    <label for="mobile">
                        Mobile Number
                    </label>


                    <div class="input-wrapper">

                        <span class="input-icon">
                            📱
                        </span>


                        <input
                            type="text"
                            id="mobile"
                            name="mobile"
                            placeholder="Enter your mobile number"
                            autocomplete="tel"
                            required
                        >

                    </div>

                </div>



                <!-- BUTTON -->

                <button
                    type="submit"
                    class="register-btn"
                >

                    Create My Account →

                </button>


            </form>



            <!-- LOGIN -->

            <div class="login-link">

                Already have an account?

                <a href="login">
                    Login here
                </a>

            </div>


        </div>

    </div>


</div>



<!-- =========================================================
     MOUSE FOLLOW EFFECT
========================================================= -->

<script>

    const mouseGlow =
        document.getElementById("mouseGlow");


    document.addEventListener(
        "mousemove",
        function(event) {

            mouseGlow.style.left =
                event.clientX + "px";

            mouseGlow.style.top =
                event.clientY + "px";

        }
    );

</script>


</body>
</html>