package com.shopsphere.controller;

import com.shopsphere.dao.ProductDAO;
import com.shopsphere.model.Product;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/products")
public class AdminProductServlet extends HttpServlet {

    private ProductDAO productDAO;

    private static final int PAGE_SIZE = 10;

    @Override
    public void init() {
        productDAO = new ProductDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        // =====================================================
        // GET SEARCH AND FILTER VALUES
        // =====================================================

        String keyword =
                request.getParameter("keyword");

        String status =
                request.getParameter("status");


        // =====================================================
        // GET PAGE NUMBER
        // =====================================================

        int page = 1;

        String pageParameter =
                request.getParameter("page");

        if (pageParameter != null
                && !pageParameter.trim().isEmpty()) {

            try {

                page = Integer.parseInt(pageParameter);

            } catch (NumberFormatException e) {

                page = 1;
            }
        }

        // Prevent invalid page numbers
        if (page < 1) {
            page = 1;
        }


        // =====================================================
        // GET TOTAL NUMBER OF PRODUCTS
        // =====================================================

        int totalProducts =
                productDAO.getProductCountForAdmin(
                        keyword,
                        status
                );


        // =====================================================
        // CALCULATE TOTAL PAGES
        // =====================================================

        int totalPages =
                (int) Math.ceil(
                        (double) totalProducts
                                / PAGE_SIZE
                );


        // =====================================================
        // HANDLE PAGE BEYOND TOTAL PAGES
        // =====================================================

        if (totalPages > 0 && page > totalPages) {
            page = totalPages;
        }


        // =====================================================
        // GET PRODUCTS FOR CURRENT PAGE
        // =====================================================

        List<Product> products =
                productDAO.searchProductsForAdmin(
                        keyword,
                        status,
                        page,
                        PAGE_SIZE
                );


        // =====================================================
        // SEND DATA TO JSP
        // =====================================================

        request.setAttribute(
                "products",
                products
        );

        request.setAttribute(
                "keyword",
                keyword
        );

        request.setAttribute(
                "status",
                status
        );

        request.setAttribute(
                "currentPage",
                page
        );

        request.setAttribute(
                "totalPages",
                totalPages
        );

        request.setAttribute(
                "totalProducts",
                totalProducts
        );

        request.setAttribute(
                "pageSize",
                PAGE_SIZE
        );


        // =====================================================
        // OPEN PRODUCTS JSP
        // =====================================================

        request.getRequestDispatcher(
                "/admin/products.jsp"
        ).forward(
                request,
                response
        );
    }
}