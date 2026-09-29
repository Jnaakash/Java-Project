# Java Servlet Demo (Jakarta Servlet / Tomcat 11)

A small Maven-based web application demonstrating core Java Servlet concepts:
HTTP GET/POST handling, the Servlet lifecycle, `ServletConfig` /
`ServletContext`, session handling with `HttpSession` and `Cookie`,
event listeners, and filters — including an integrated login + session +
authentication-filter example.

## Tech stack

- Java 17
- Jakarta Servlet API 6.1.0 (`provided` scope)
- Apache Tomcat 11
- Maven (WAR packaging)

## Project structure

```
servlet-demo/
├── pom.xml
└── src/main/
    ├── java/com/servlet/
    │   ├── HelloServlet.java      # /hello        - GET & POST demo
    │   ├── LoginServlet.java      # /login (POST)  - creates session
    │   ├── HomeServlet.java       # /home          - protected page
    │   ├── LogoutServlet.java     # /logout        - invalidates session
    │   ├── AuthFilter.java        # guards /home
    │   ├── LoggingFilter.java     # logs every request URI
    │   ├── AppListener.java       # ServletContextListener
    │   └── SessionListener.java   # HttpSessionListener
    └── webapp/
        └── index.html             # forms for /hello and /login
```

## Build

```bash
mvn clean package
```

This produces `target/servlet.war`.

## Deploy to Tomcat 11

1. Copy `target/servlet.war` into Tomcat's `webapps/` directory.
2. Start Tomcat (`startup.bat` on Windows or `startup.sh` on Linux/macOS).
3. Open the app:

   ```
   http://localhost:8080/servlet/
   ```

## Try it out

- `GET /servlet/hello?name=Jahanvi` — greets by name
- Login with `admin` / `1234` on the home page, then visit `/servlet/home`
- Try `/servlet/home` directly without logging in — `AuthFilter` redirects
  you back to the login page
- `/servlet/logout` invalidates the session

## Key concepts covered

- Servlet lifecycle: `init()`, `service()`, `doGet()`, `doPost()`, `destroy()`
- `ServletConfig` (per-servlet) vs `ServletContext` (application-wide)
- Session handling via `HttpSession` and `Cookie`
- `ServletContextListener` / `HttpSessionListener` events
- `Filter` and `chain.doFilter()` for request/response interception
