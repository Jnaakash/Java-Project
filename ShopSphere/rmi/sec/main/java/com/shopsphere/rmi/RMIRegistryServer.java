package com.shopsphere.rmi;

import java.rmi.registry.LocateRegistry;
import java.rmi.registry.Registry;

public class RMIRegistryServer {

    private static final int PORT = 1099;

    public static void main(String[] args) {

        System.out.println("=================================");
        System.out.println("   ShopSphere RMI Server");
        System.out.println("=================================");

        try {

            System.out.println(
                    "Starting RMI Registry..."
            );

            Registry registry =
                    LocateRegistry.createRegistry(PORT);

            System.out.println(
                    "RMI Registry started successfully."
            );

            System.out.println(
                    "Registry Port: " + PORT
            );

            InventoryService service =
                    new InventoryServiceImpl();

            registry.rebind(
                    "InventoryService",
                    service
            );

            System.out.println();
            System.out.println(
                    "InventoryService registered successfully."
            );

            System.out.println(
                    "Service Name: InventoryService"
            );

            System.out.println();
            System.out.println(
                    "RMI Server is running..."
            );

            System.out.println(
                    "Waiting for RMI clients..."
            );

        } catch (Exception e) {

            System.out.println(
                    "RMI Server Error: "
                            + e.getMessage()
            );

            e.printStackTrace();
        }
    }
}