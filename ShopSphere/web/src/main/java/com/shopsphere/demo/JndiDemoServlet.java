package com.shopsphere.demo;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import javax.sql.DataSource;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/jndi-demo")
public class JndiDemoServlet extends HttpServlet {

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType(
                "text/html;charset=UTF-8"
        );

        PrintWriter out =
                response.getWriter();

        out.println("<html><body>");
        out.println("<h1>ShopSphere JNDI Demo</h1>");

        try {

            InitialContext context =
                    new InitialContext();

            DataSource dataSource =
                    (DataSource) context.lookup(
                            "java:comp/env/jdbc/ShopSphereDB"
                    );

            try (var connection =
                         dataSource.getConnection()) {

                out.println(
                        "<p>JNDI lookup successful.</p>"
                );

                out.println(
                        "<p>Database connection successful.</p>"
                );

            }

        } catch (NamingException e) {

            out.println(
                    "<p>JNDI resource is not configured.</p>"
            );

            out.println(
                    "<p>Error: "
                            + e.getMessage()
                            + "</p>"
            );

        } catch (Exception e) {

            out.println(
                    "<p>Database connection failed.</p>"
            );

            out.println(
                    "<p>Error: "
                            + e.getMessage()
                            + "</p>"
            );
        }

        out.println("</body></html>");
    }
}