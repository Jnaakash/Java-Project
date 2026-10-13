package com.shopsphere.swing.controller;

import com.shopsphere.swing.dao.InventoryDAO;

import java.util.List;

public class InventoryController {

    private final InventoryDAO inventoryDAO;

    public InventoryController() {
        inventoryDAO = new InventoryDAO();
    }

    public List<Object[]> getAllInventory() {
        return inventoryDAO.getAllInventory();
    }

    public boolean updateStock(
            int productId,
            String stockText
    ) {

        if (productId <= 0) {
            return false;
        }

        try {

            int stock =
                    Integer.parseInt(
                            stockText.trim()
                    );

            if (stock < 0) {
                return false;
            }

            return inventoryDAO.updateStock(
                    productId,
                    stock
            );

        } catch (NumberFormatException e) {

            return false;
        }
    }

    public boolean restock(
            int productId,
            String quantityText
    ) {

        if (productId <= 0) {
            return false;
        }

        try {

            int quantity =
                    Integer.parseInt(
                            quantityText.trim()
                    );

            if (quantity <= 0) {
                return false;
            }

            return inventoryDAO.restock(
                    productId,
                    quantity
            );

        } catch (NumberFormatException e) {

            return false;
        }
    }
}