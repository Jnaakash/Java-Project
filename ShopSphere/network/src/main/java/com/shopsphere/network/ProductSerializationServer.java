package com.shopsphere.network;

import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.net.ServerSocket;
import java.net.Socket;

import com.shopsphere.model.Product;

public class ProductSerializationServer {

    private static final int PORT = 6000;

    public static void main(String[] args) {

        System.out.println("=================================");
        System.out.println(" ShopSphere Serialization Server");
        System.out.println("=================================");

        try (ServerSocket serverSocket =
                     new ServerSocket(PORT)) {

            System.out.println(
                    "Serialization Server started successfully."
            );

            System.out.println(
                    "Listening on port: " + PORT
            );

            System.out.println(
                    "Waiting for client connection..."
            );

            try (Socket socket =
                         serverSocket.accept()) {

                System.out.println(
                        "Client connected: "
                                + socket.getInetAddress()
                );

                ObjectInputStream input =
                        new ObjectInputStream(
                                socket.getInputStream()
                        );

                ObjectOutputStream output =
                        new ObjectOutputStream(
                                socket.getOutputStream()
                        );

                System.out.println(
                        "Waiting for Product object..."
                );

                Object receivedObject =
                        input.readObject();

                if (receivedObject
                        instanceof Product) {

                    Product product =
                            (Product) receivedObject;

                    System.out.println();
                    System.out.println(
                            "Product object received successfully!"
                    );

                    System.out.println(
                            "Product ID: "
                                    + product.getProductId()
                    );

                    System.out.println(
                            "Name: "
                                    + product.getName()
                    );

                    System.out.println(
                            "Brand: "
                                    + product.getBrand()
                    );

                    System.out.println(
                            "Price: "
                                    + product.getPrice()
                    );

                    System.out.println(
                            "Stock: "
                                    + product.getStock()
                    );

                    output.writeObject(
                            "Product object received successfully."
                    );

                    output.flush();

                } else {

                    output.writeObject(
                            "ERROR: Received object is not a Product."
                    );

                    output.flush();
                }

                input.close();
                output.close();

                System.out.println();
                System.out.println(
                        "Serialization Server finished."
                );
            }

        } catch (Exception e) {

            System.out.println(
                    "Serialization Server Error: "
                            + e.getMessage()
            );

            e.printStackTrace();
        }
    }
}