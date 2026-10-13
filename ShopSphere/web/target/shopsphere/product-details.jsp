<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <title>ShopSphere - Product Details</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 40px;
        }

        .product-details {
            max-width: 600px;
            margin: auto;
            border: 1px solid #ddd;
            border-radius: 10px;
            padding: 30px;
        }

        h1 {
            margin-top: 0;
        }

        .price {
            font-size: 24px;
            font-weight: bold;
        }

        .back {
            display: inline-block;
            margin-top: 20px;
        }

        .add-cart {
            display: inline-block;
            margin-top: 20px;
            padding: 12px 22px;
            background-color: #2563eb;
            color: white;
            text-decoration: none;
            border-radius: 6px;
            font-weight: bold;
        }

        .add-cart:hover {
            background-color: #1d4ed8;
        }
    </style>
</head>

<body>

    <jsp:include page="/WEB-INF/jsp/fragments/header.jspf" />
    
<div class="product-details">

    <h1>${product.name}</h1>

    <p><strong>Brand:</strong> ${product.brand}</p>

    <p><strong>Description:</strong></p>
    <p>${product.description}</p>

    <p class="price">₹${product.price}</p>

    <p><strong>Discount:</strong> ${product.discount}%</p>

    <p><strong>Stock:</strong> ${product.stock}</p>


   <!-- ADD TO CART BUTTON -->

<a class="add-cart"
   href="<%= request.getContextPath() %>/cart?action=add&id=<%= request.getParameter("id") %>">
    🛒 Add to Cart
</a>


    <!-- BACK TO PRODUCTS -->

    <a class="back"
       href="${pageContext.request.contextPath}/products">
        ← Back to Products
    </a>

   



</div>

</body>
</html>