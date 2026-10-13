package com.shopsphere.demo;

import java.net.URL;
import java.net.URLConnection;

public class UrlConnectionDemo {

    public static void main(String[] args) {

        try {
            URL url = new URL("https://example.com");

            URLConnection connection = url.openConnection();

            System.out.println("===== URL INFORMATION =====");
            System.out.println("Protocol: " + url.getProtocol());
            System.out.println("Host: " + url.getHost());
            System.out.println("Port: " + url.getPort());
            System.out.println("Path: " + url.getPath());

            System.out.println();

            System.out.println("===== URL CONNECTION =====");
            System.out.println("Content Type: "
                    + connection.getContentType());
            System.out.println("Content Length: "
                    + connection.getContentLengthLong());

        } catch (Exception e) {
            System.out.println("URL Connection Error: "
                    + e.getMessage());
        }
    }
}