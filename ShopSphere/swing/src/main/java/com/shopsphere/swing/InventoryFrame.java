package com.shopsphere.swing;

import com.shopsphere.swing.controller.InventoryController;

import javax.swing.*;
import javax.swing.table.DefaultTableModel;
import java.awt.*;
import java.util.List;

public class InventoryFrame extends JFrame {

    private JTable inventoryTable;
    private DefaultTableModel tableModel;

    private JTextField productNameField;
    private JTextField stockField;

    private final InventoryController inventoryController;

    private int selectedProductId = -1;

    public InventoryFrame() {

        inventoryController =
                new InventoryController();

        setTitle(
                "ShopSphere - Inventory Management"
        );

        setSize(900, 600);

        setLocationRelativeTo(null);

        setDefaultCloseOperation(
                JFrame.DISPOSE_ON_CLOSE
        );

        createUI();

        loadInventory();
    }

    private void createUI() {

        JPanel mainPanel =
                new JPanel(
                        new BorderLayout(10, 10)
                );

        mainPanel.setBorder(
                BorderFactory.createEmptyBorder(
                        15,
                        15,
                        15,
                        15
                )
        );

        JLabel titleLabel =
                new JLabel(
                        "Inventory Management",
                        SwingConstants.CENTER
                );

        titleLabel.setFont(
                new Font(
                        "Arial",
                        Font.BOLD,
                        22
                )
        );

        mainPanel.add(
                titleLabel,
                BorderLayout.NORTH
        );

        String[] columns = {
                "Product ID",
                "Product Name",
                "Brand",
                "Current Stock",
                "Stock Status"
        };

        tableModel =
                new DefaultTableModel(
                        columns,
                        0
                ) {

                    @Override
                    public boolean isCellEditable(
                            int row,
                            int column
                    ) {
                        return false;
                    }
                };

        inventoryTable =
                new JTable(tableModel);

        inventoryTable.setSelectionMode(
                ListSelectionModel.SINGLE_SELECTION
        );

        inventoryTable
                .getSelectionModel()
                .addListSelectionListener(e -> {

                    if (!e.getValueIsAdjusting()) {
                        selectProduct();
                    }

                });

        JScrollPane scrollPane =
                new JScrollPane(
                        inventoryTable
                );

        mainPanel.add(
                scrollPane,
                BorderLayout.CENTER
        );

        JPanel bottomPanel =
                new JPanel(
                        new GridLayout(
                                2,
                                1,
                                5,
                                5
                        )
                );

        JPanel fieldsPanel =
                new JPanel(
                        new FlowLayout(
                                FlowLayout.CENTER,
                                10,
                                5
                        )
                );

        fieldsPanel.add(
                new JLabel("Product:")
        );

        productNameField =
                new JTextField(20);

        productNameField.setEditable(false);

        fieldsPanel.add(
                productNameField
        );

        fieldsPanel.add(
                new JLabel("Stock:")
        );

        stockField =
                new JTextField(10);

        fieldsPanel.add(
                stockField
        );

        JPanel buttonPanel =
                new JPanel(
                        new FlowLayout(
                                FlowLayout.CENTER,
                                10,
                                5
                        )
                );

        JButton updateButton =
                new JButton("Update Stock");

        JButton restockButton =
                new JButton("Restock");

        JButton clearButton =
                new JButton("Clear");

        JButton closeButton =
                new JButton("Close");

        buttonPanel.add(updateButton);
        buttonPanel.add(restockButton);
        buttonPanel.add(clearButton);
        buttonPanel.add(closeButton);

        bottomPanel.add(fieldsPanel);
        bottomPanel.add(buttonPanel);

        mainPanel.add(
                bottomPanel,
                BorderLayout.SOUTH
        );

        add(mainPanel);

        updateButton.addActionListener(
                e -> updateStock()
        );

        restockButton.addActionListener(
                e -> restock()
        );

        clearButton.addActionListener(
                e -> clearSelection()
        );

        closeButton.addActionListener(
                e -> dispose()
        );
    }

    private void loadInventory() {

        tableModel.setRowCount(0);

        List<Object[]> inventory =
                inventoryController
                        .getAllInventory();

        for (Object[] row : inventory) {
            tableModel.addRow(row);
        }
    }

    private void selectProduct() {

        int selectedRow =
                inventoryTable.getSelectedRow();

        if (selectedRow == -1) {
            return;
        }

        selectedProductId =
                Integer.parseInt(
                        inventoryTable
                                .getValueAt(
                                        selectedRow,
                                        0
                                )
                                .toString()
                );

        productNameField.setText(
                inventoryTable
                        .getValueAt(
                                selectedRow,
                                1
                        )
                        .toString()
        );

        stockField.setText(
                inventoryTable
                        .getValueAt(
                                selectedRow,
                                3
                        )
                        .toString()
        );
    }

    private void updateStock() {

        if (selectedProductId == -1) {

            JOptionPane.showMessageDialog(
                    this,
                    "Please select a product first.",
                    "Validation Error",
                    JOptionPane.WARNING_MESSAGE
            );

            return;
        }

        boolean success =
                inventoryController.updateStock(
                        selectedProductId,
                        stockField.getText()
                );

        if (success) {

            JOptionPane.showMessageDialog(
                    this,
                    "Stock updated successfully.",
                    "Success",
                    JOptionPane.INFORMATION_MESSAGE
            );

            loadInventory();

            clearSelection();

        } else {

            JOptionPane.showMessageDialog(
                    this,
                    "Invalid stock value or update failed.",
                    "Error",
                    JOptionPane.ERROR_MESSAGE
            );
        }
    }

    private void restock() {

        if (selectedProductId == -1) {

            JOptionPane.showMessageDialog(
                    this,
                    "Please select a product first.",
                    "Validation Error",
                    JOptionPane.WARNING_MESSAGE
            );

            return;
        }

        String quantity =
                JOptionPane.showInputDialog(
                        this,
                        "Enter restock quantity:"
                );

        if (quantity == null) {
            return;
        }

        boolean success =
                inventoryController.restock(
                        selectedProductId,
                        quantity
                );

        if (success) {

            JOptionPane.showMessageDialog(
                    this,
                    "Product restocked successfully.",
                    "Success",
                    JOptionPane.INFORMATION_MESSAGE
            );

            loadInventory();

            clearSelection();

        } else {

            JOptionPane.showMessageDialog(
                    this,
                    "Invalid quantity or restock failed.",
                    "Error",
                    JOptionPane.ERROR_MESSAGE
            );
        }
    }

    private void clearSelection() {

        inventoryTable.clearSelection();

        selectedProductId = -1;

        productNameField.setText("");

        stockField.setText("");
    }
}