package com.shopsphere.swing;

import com.shopsphere.swing.controller.ProductController;

import javax.swing.*;
import javax.swing.table.DefaultTableModel;
import java.awt.*;
import java.util.List;

public class ProductFrame extends JFrame {

    private JTextField nameField;
    private JTextField brandField;
    private JTextField priceField;
    private JTextField stockField;

    private JTable productTable;
    private DefaultTableModel tableModel;

    private ProductController productController;

    private int selectedProductId = -1;

    public ProductFrame() {

        productController = new ProductController();

        setTitle("ShopSphere - Product Management");
        setSize(900, 600);
        setLocationRelativeTo(null);
        setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);

        createUI();
        loadProducts();
    }

    private void createUI() {

        JPanel mainPanel = new JPanel(new BorderLayout(10, 10));
        mainPanel.setBorder(
                BorderFactory.createEmptyBorder(10, 10, 10, 10)
        );

        // =========================
        // FORM PANEL
        // =========================

        JPanel formPanel = new JPanel(
                new GridLayout(4, 2, 10, 10)
        );

        formPanel.add(new JLabel("Product Name:"));
        nameField = new JTextField();
        formPanel.add(nameField);

        formPanel.add(new JLabel("Brand:"));
        brandField = new JTextField();
        formPanel.add(brandField);

        formPanel.add(new JLabel("Price:"));
        priceField = new JTextField();
        formPanel.add(priceField);

        formPanel.add(new JLabel("Stock:"));
        stockField = new JTextField();
        formPanel.add(stockField);

        mainPanel.add(formPanel, BorderLayout.NORTH);

        // =========================
        // TABLE
        // =========================

        tableModel = new DefaultTableModel(
                new Object[]{
                        "ID",
                        "Product Name",
                        "Brand",
                        "Price",
                        "Stock"
                },
                0
        ) {

            @Override
            public boolean isCellEditable(
                    int row,
                    int column) {

                return false;
            }
        };

        productTable = new JTable(tableModel);

        productTable.setSelectionMode(
                ListSelectionModel.SINGLE_SELECTION
        );

        JScrollPane scrollPane =
                new JScrollPane(productTable);

        mainPanel.add(scrollPane, BorderLayout.CENTER);

        // =========================
        // BUTTON PANEL
        // =========================

        JPanel buttonPanel = new JPanel(
                new FlowLayout()
        );

        JButton addButton =
                new JButton("Add");

        JButton updateButton =
                new JButton("Update");

        JButton deleteButton =
                new JButton("Deactivate");

        JButton clearButton =
                new JButton("Clear");

        JButton closeButton =
                new JButton("Close");

        buttonPanel.add(addButton);
        buttonPanel.add(updateButton);
        buttonPanel.add(deleteButton);
        buttonPanel.add(clearButton);
        buttonPanel.add(closeButton);

        mainPanel.add(
                buttonPanel,
                BorderLayout.SOUTH
        );

        add(mainPanel);

        // =========================
        // BUTTON ACTIONS
        // =========================

        addButton.addActionListener(
                e -> addProduct()
        );

        updateButton.addActionListener(
                e -> updateProduct()
        );

        deleteButton.addActionListener(
                e -> deactivateProduct()
        );

        clearButton.addActionListener(
                e -> clearFields()
        );

        closeButton.addActionListener(
                e -> dispose()
        );

        // =========================
        // TABLE SELECTION
        // =========================

        productTable
                .getSelectionModel()
                .addListSelectionListener(e -> {

                    if (!e.getValueIsAdjusting()) {

                        int row =
                                productTable.getSelectedRow();

                        if (row >= 0) {

                            selectedProductId =
                                    Integer.parseInt(
                                            tableModel
                                                    .getValueAt(row, 0)
                                                    .toString()
                                    );

                            nameField.setText(
                                    tableModel
                                            .getValueAt(row, 1)
                                            .toString()
                            );

                            brandField.setText(
                                    tableModel
                                            .getValueAt(row, 2)
                                            .toString()
                            );

                            priceField.setText(
                                    tableModel
                                            .getValueAt(row, 3)
                                            .toString()
                            );

                            stockField.setText(
                                    tableModel
                                            .getValueAt(row, 4)
                                            .toString()
                            );
                        }
                    }
                });
    }

    // =========================
    // LOAD PRODUCTS
    // =========================

    private void loadProducts() {

        tableModel.setRowCount(0);

        List<Object[]> products =
                productController.getAllProducts();

        for (Object[] product : products) {

            tableModel.addRow(product);
        }
    }

    // =========================
    // ADD PRODUCT
    // =========================

    private void addProduct() {

        boolean success =
                productController.addProduct(
                        nameField.getText(),
                        brandField.getText(),
                        priceField.getText(),
                        stockField.getText()
                );

        if (success) {

            JOptionPane.showMessageDialog(
                    this,
                    "Product added successfully.",
                    "Success",
                    JOptionPane.INFORMATION_MESSAGE
            );

            clearFields();
            loadProducts();

        } else {

            JOptionPane.showMessageDialog(
                    this,
                    "Unable to add product.\n"
                            + "Check the entered values.",
                    "Error",
                    JOptionPane.ERROR_MESSAGE
            );
        }
    }

    // =========================
    // UPDATE PRODUCT
    // =========================

    private void updateProduct() {

        if (selectedProductId == -1) {

            JOptionPane.showMessageDialog(
                    this,
                    "Please select a product first.",
                    "Selection Required",
                    JOptionPane.WARNING_MESSAGE
            );

            return;
        }

        boolean success =
                productController.updateProduct(
                        selectedProductId,
                        nameField.getText(),
                        brandField.getText(),
                        priceField.getText(),
                        stockField.getText()
                );

        if (success) {

            JOptionPane.showMessageDialog(
                    this,
                    "Product updated successfully.",
                    "Success",
                    JOptionPane.INFORMATION_MESSAGE
            );

            clearFields();
            loadProducts();

        } else {

            JOptionPane.showMessageDialog(
                    this,
                    "Unable to update product.",
                    "Error",
                    JOptionPane.ERROR_MESSAGE
            );
        }
    }

    // =========================
    // DEACTIVATE PRODUCT
    // =========================

    private void deactivateProduct() {

        if (selectedProductId == -1) {

            JOptionPane.showMessageDialog(
                    this,
                    "Please select a product first.",
                    "Selection Required",
                    JOptionPane.WARNING_MESSAGE
            );

            return;
        }

        int choice =
                JOptionPane.showConfirmDialog(
                        this,
                        "Are you sure you want to deactivate this product?",
                        "Confirm Deactivation",
                        JOptionPane.YES_NO_OPTION
                );

        if (choice != JOptionPane.YES_OPTION) {
            return;
        }

        boolean success =
                productController.deactivateProduct(
                        selectedProductId
                );

        if (success) {

            JOptionPane.showMessageDialog(
                    this,
                    "Product deactivated successfully.",
                    "Success",
                    JOptionPane.INFORMATION_MESSAGE
            );

            clearFields();
            loadProducts();

        } else {

            JOptionPane.showMessageDialog(
                    this,
                    "Unable to deactivate product.",
                    "Error",
                    JOptionPane.ERROR_MESSAGE
            );
        }
    }

    // =========================
    // CLEAR
    // =========================

    private void clearFields() {

        nameField.setText("");
        brandField.setText("");
        priceField.setText("");
        stockField.setText("");
        

        selectedProductId = -1;

        productTable.clearSelection();
    }
}