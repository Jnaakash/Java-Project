package com.shopsphere.rmi;

import java.rmi.registry.LocateRegistry;
import java.rmi.registry.Registry;

import java.io.BufferedReader;
import java.io.InputStreamReader;

public class RMIClient {

    private static final String HOST = "localhost";
    private static final int PORT = 1099;

    public static void main(String[] args) {

        System.out.println("=================================");
        System.out.println("   ShopSphere RMI Client");
        System.out.println("=================================");

        try {

            System.out.println(
                    "Connecting to RMI Registry..."
            );

            Registry registry =
                    LocateRegistry.getRegistry(
                            HOST,
                            PORT
                    );

            System.out.println(
                    "Connected to RMI Registry."
            );

            InventoryService service =
                    (InventoryService)
                            registry.lookup(
                                    "InventoryService"
                            );

            System.out.println(
                    "InventoryService found successfully."
            );

            System.out.println();
            System.out.println("Available commands:");
            System.out.println(
                    "GET_PRODUCT <productId>"
            );
            System.out.println(
                    "GET_STOCK <productId>"
            );
            System.out.println(
                    "SEARCH_PRODUCT <keyword>"
            );
            System.out.println("EXIT");
            System.out.println();

            BufferedReader console =
                    new BufferedReader(
                            new InputStreamReader(
                                    System.in
                            )
                    );

            while (true) {

                System.out.print("Enter command: ");

                String command =
                        console.readLine();

                if (command == null) {
                    break;
                }

                command = command.trim();

                if (command.isEmpty()) {
                    continue;
                }

                if (command.equalsIgnoreCase("EXIT")) {

                    System.out.println(
                            "RMI Client disconnected."
                    );

                    break;
                }

                String upperCommand =
                        command.toUpperCase();

                if (upperCommand.startsWith(
                        "GET_PRODUCT ")) {

                    String idText =
                            command.substring(
                                    "GET_PRODUCT ".length()
                            ).trim();

                    try {

                        int productId =
                                Integer.parseInt(idText);

                        String result =
                                service.getProduct(
                                        productId
                                );

                        System.out.println();
                        System.out.println(
                                "Remote Server Response:"
                        );

                        System.out.println(result);

                    } catch (NumberFormatException e) {

                        System.out.println(
                                "ERROR: Product ID must be a number."
                        );
                    }

                } else if (upperCommand.startsWith(
                        "GET_STOCK ")) {

                    String idText =
                            command.substring(
                                    "GET_STOCK ".length()
                            ).trim();

                    try {

                        int productId =
                                Integer.parseInt(idText);

                        String result =
                                service.getStock(
                                        productId
                                );

                        System.out.println();
                        System.out.println(
                                "Remote Server Response:"
                        );

                        System.out.println(result);

                    } catch (NumberFormatException e) {

                        System.out.println(
                                "ERROR: Product ID must be a number."
                        );
                    }

                } else if (upperCommand.startsWith(
                        "SEARCH_PRODUCT ")) {

                    String keyword =
                            command.substring(
                                    "SEARCH_PRODUCT ".length()
                            ).trim();

                    String result =
                            service.searchProduct(
                                    keyword
                            );

                    System.out.println();
                    System.out.println(
                            "Remote Server Response:"
                    );

                    System.out.println(result);

                } else {

                    System.out.println(
                            "ERROR: Unknown command."
                    );

                    System.out.println(
                            "Use GET_PRODUCT <id>"
                    );

                    System.out.println(
                            "Use GET_STOCK <id>"
                    );

                    System.out.println(
                            "Use SEARCH_PRODUCT <keyword>"
                    );
                }

                System.out.println();
            }

        } catch (Exception e) {

            System.out.println();
            System.out.println(
                    "RMI Client Error: "
                            + e.getMessage()
            );

            e.printStackTrace();
        }
    }
}