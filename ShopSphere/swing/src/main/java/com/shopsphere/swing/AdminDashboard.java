package com.shopsphere.swing;

import javax.swing.*;
import java.awt.*;

public class AdminDashboard extends JFrame {

    private JButton productButton;
    private JButton categoryButton;
    private JButton customerButton;
    private JButton orderButton;
    private JButton inventoryButton;
    private JButton logoutButton;

    public AdminDashboard() {

        setTitle("ShopSphere - Admin Dashboard");
        setSize(700, 500);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setLocationRelativeTo(null);

        initializeUI();
    }

    private void initializeUI() {

        JPanel mainPanel =
                new JPanel(new BorderLayout(15, 15));

        mainPanel.setBorder(
                BorderFactory.createEmptyBorder(
                        20, 20, 20, 20
                )
        );

        // ==========================================
        // HEADER
        // ==========================================

        JLabel titleLabel =
                new JLabel(
                        "ShopSphere Admin Dashboard",
                        SwingConstants.CENTER
                );

        titleLabel.setFont(
                new Font("Arial", Font.BOLD, 26)
        );

        mainPanel.add(
                titleLabel,
                BorderLayout.NORTH
        );

        // ==========================================
        // MENU PANEL
        // ==========================================

        JPanel menuPanel =
                new JPanel(
                        new GridLayout(3, 2, 15, 15)
                );

        productButton =
                new JButton("Manage Products");

        categoryButton =
                new JButton("Manage Categories");

        customerButton =
                new JButton("Manage Customers");

        orderButton =
                new JButton("Manage Orders");

        inventoryButton =
                new JButton("Manage Inventory");

        logoutButton =
                new JButton("Logout");

        menuPanel.add(productButton);
        menuPanel.add(categoryButton);
        menuPanel.add(customerButton);
        menuPanel.add(orderButton);
        menuPanel.add(inventoryButton);
        menuPanel.add(logoutButton);

        mainPanel.add(
                menuPanel,
                BorderLayout.CENTER
        );

        // ==========================================
        // FOOTER
        // ==========================================

        JLabel footerLabel =
                new JLabel(
                        "ShopSphere - Administration Panel",
                        SwingConstants.CENTER
                );

        footerLabel.setFont(
                new Font("Arial", Font.PLAIN, 14)
        );

        mainPanel.add(
                footerLabel,
                BorderLayout.SOUTH
        );

        add(mainPanel);

        // ==========================================
        // BUTTON ACTIONS
        // ==========================================

        productButton.addActionListener(
                e -> openProducts()
        );

        categoryButton.addActionListener(
                e -> openCategories()
        );

        customerButton.addActionListener(
                e -> openCustomers()
        );

        orderButton.addActionListener(
                e -> openOrders()
        );

        inventoryButton.addActionListener(
                e -> openInventory()
        );

        logoutButton.addActionListener(
                e -> logout()
        );
    }

    // ==========================================
    // PRODUCT MANAGEMENT
    // ==========================================

    private void openProducts() {

        ProductFrame productFrame =
                new ProductFrame();

        productFrame.setVisible(true);
    }

    // ==========================================
    // CATEGORY MANAGEMENT
    // ==========================================

    private void openCategories() {

        CategoryFrame categoryFrame =
                new CategoryFrame();

        categoryFrame.setVisible(true);
    }

    // ==========================================
    // CUSTOMER MANAGEMENT
    // ==========================================

    private void openCustomers() {

        CustomerFrame customerFrame =
                new CustomerFrame();

        customerFrame.setVisible(true);
    }

    // ==========================================
    // ORDER MANAGEMENT
    // ==========================================

    private void openOrders() {

        OrderFrame orderFrame =
                new OrderFrame();

        orderFrame.setVisible(true);
    }

    // ==========================================
    // INVENTORY MANAGEMENT
    // ==========================================

    private void openInventory() {

        InventoryFrame inventoryFrame =
                new InventoryFrame();

        inventoryFrame.setVisible(true);
    }

    // ==========================================
    // LOGOUT
    // ==========================================

    private void logout() {

        int choice =
                JOptionPane.showConfirmDialog(
                        this,
                        "Are you sure you want to logout?",
                        "Logout",
                        JOptionPane.YES_NO_OPTION
                );

        if (choice == JOptionPane.YES_OPTION) {

            dispose();

            new LoginFrame().setVisible(true);
        }
    }
}