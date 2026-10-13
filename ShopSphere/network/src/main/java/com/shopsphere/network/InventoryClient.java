package com.shopsphere.network;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.Socket;

public class InventoryClient {

    private static final String HOST = "localhost";
    private static final int PORT = 5000;

    public static void main(String[] args) {

        System.out.println("=================================");
        System.out.println("   ShopSphere Inventory Client");
        System.out.println("=================================");

        System.out.println("Connecting to server...");

        try (
                Socket socket = new Socket(HOST, PORT);

                BufferedReader reader =
                        new BufferedReader(
                                new InputStreamReader(
                                        socket.getInputStream()
                                )
                        );

                PrintWriter writer =
                        new PrintWriter(
                                socket.getOutputStream(),
                                true
                        );

                BufferedReader console =
                        new BufferedReader(
                                new InputStreamReader(
                                        System.in
                                )
                        )
        ) {

            System.out.println(
                    "Connected to server successfully."
            );

            String welcomeMessage = reader.readLine();

            System.out.println(
                    "Server: " + welcomeMessage
            );

            System.out.println();
            System.out.println("Available commands:");
            System.out.println("GET_PRODUCT <productId>");
            System.out.println("GET_STOCK <productId>");
            System.out.println("SEARCH_PRODUCT <keyword>");
            System.out.println("EXIT");
            System.out.println();

            while (true) {

                System.out.print("Enter command: ");

                String command = console.readLine();

                if (command == null) {
                    break;
                }

                command = command.trim();

                if (command.isEmpty()) {
                    continue;
                }

                writer.println(command);

                /*
                 * SEARCH_PRODUCT can return multiple
                 * lines, so read until END.
                 */
                String response;

                while ((response = reader.readLine()) != null) {

                    System.out.println(
                            "Server: " + response
                    );

                    if (response.equals("END")) {
                        break;
                    }
                }

                if (command.equalsIgnoreCase("EXIT")) {
                    break;
                }

                System.out.println();
            }

            System.out.println();
            System.out.println(
                    "Client disconnected."
            );

        } catch (IOException e) {

            System.out.println(
                    "Unable to connect to server."
            );

            System.out.println(
                    "Error: " + e.getMessage()
            );
        }
    }
}