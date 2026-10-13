package com.shopsphere.demo;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/architecture-demo")
public class ArchitectureDemoServlet extends HttpServlet {

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");

        PrintWriter out = response.getWriter();

        out.println("""
                <!DOCTYPE html>
                <html>
                <head>
                    <title>ShopSphere N-Tier Architecture</title>

                    <style>
                        body {
                            font-family: Arial, sans-serif;
                            margin: 40px;
                        }

                        h1 {
                            text-align: center;
                        }

                        .layer {
                            padding: 18px;
                            margin: 12px auto;
                            width: 70%;
                            border: 2px solid #333;
                            text-align: center;
                            border-radius: 8px;
                        }

                        .arrow {
                            text-align: center;
                            font-size: 25px;
                            font-weight: bold;
                        }

                        .description {
                            width: 75%;
                            margin: 30px auto;
                            line-height: 1.6;
                        }
                    </style>
                </head>

                <body>

                <h1>ShopSphere - J2EE / N-Tier Architecture</h1>

                <div class="layer">
                    Presentation Layer
                    <br>
                    JSP / HTML / CSS
                </div>

                <div class="arrow">↓ HTTP Request</div>

                <div class="layer">
                    Controller Layer
                    <br>
                    Servlet
                </div>

                <div class="arrow">↓</div>

                <div class="layer">
                    Service Layer
                    <br>
                    Business Logic
                </div>

                <div class="arrow">↓</div>

                <div class="layer">
                    DAO Layer
                    <br>
                    Data Access Object
                </div>

                <div class="arrow">↓ JDBC</div>

                <div class="layer">
                    Database Layer
                    <br>
                    MySQL
                </div>

                <div class="description">

                    <h2>Architecture Explanation</h2>

                    <p>
                    The browser sends an HTTP request to the web application.
                    </p>

                    <p>
                    The presentation layer displays the user interface
                    using JSP and HTML.
                    </p>

                    <p>
                    The Servlet acts as the controller and receives
                    the client request.
                    </p>

                    <p>
                    The Service layer contains the application/business
                    logic.
                    </p>

                    <p>
                    The DAO layer communicates with the database using JDBC.
                    </p>

                    <p>
                    MySQL stores the persistent application data.
                    </p>

                </div>

                </body>
                </html>
                """);
    }
}