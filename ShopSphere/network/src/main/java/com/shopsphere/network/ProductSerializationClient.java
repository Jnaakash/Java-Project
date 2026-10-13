package com.shopsphere.network;

import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.net.Socket;

import com.shopsphere.model.Product;

public class ProductSerializationClient {

    private static final String HOST = "localhost";
    private static final int PORT = 6000;

    public static void main(String[] args) {

        System.out.println("=================================");
        System.out.println(" ShopSphere Serialization Client");
        System.out.println("=================================");

        try (
                Socket socket =
                        new Socket(HOST, PORT);

                ObjectOutputStream output =
                        new ObjectOutputStream(
                                socket.getOutputStream()
                        );

                ObjectInputStream input =
                        new ObjectInputStream(
                                socket.getInputStream()
                        )
        ) {

            System.out.println(
                    "Connected to Serialization Server."
            );

            Product product = new Product();

            product.setProductId(101);
            product.setCategoryId(1);
            product.setName("Serialization Demo Product");
            product.setBrand("ShopSphere");
            product.setDescription(
                    "Product object transferred using Java Serialization."
            );
            product.setPrice(1999.0);
            product.setDiscount(10.0);
            product.setStock(50);
            product.setImageUrl("demo.jpg");
            product.setStatus(true);

            System.out.println();
            System.out.println(
                    "Sending Product object..."
            );

            output.writeObject(product);
            output.flush();

            System.out.println(
                    "Product object sent successfully."
            );

            Object response =
                    input.readObject();

            System.out.println();
            System.out.println(
                    "Server Response:"
            );

            System.out.println(response);

        } catch (Exception e) {

            System.out.println(
                    "Serialization Client Error: "
                            + e.getMessage()
            );

            e.printStackTrace();
        }
    }
}