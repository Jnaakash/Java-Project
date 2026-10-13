package com.shopsphere.swing;

import com.shopsphere.swing.controller.OrderController;

import javax.swing.*;
import javax.swing.table.DefaultTableModel;
import java.awt.*;
import java.util.List;

public class OrderFrame extends JFrame {

    private JTable orderTable;
    private DefaultTableModel tableModel;

    private JComboBox<String> statusComboBox;

    private final OrderController orderController;

    private int selectedOrderId = -1;

    public OrderFrame() {

        orderController = new OrderController();

        setTitle("ShopSphere - Order Management");
        setSize(900, 600);
        setLocationRelativeTo(null);
        setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);

        createUI();
        loadOrders();
    }

    private void createUI() {

        JPanel mainPanel =
                new JPanel(new BorderLayout(10, 10));

        mainPanel.setBorder(
                BorderFactory.createEmptyBorder(
                        15, 15, 15, 15
                )
        );

        JLabel titleLabel =
                new JLabel(
                        "Order Management",
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

        // Table
        String[] columns = {
                "Order ID",
                "Customer",
                "Total Amount",
                "Order Date",
                "Status"
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

        orderTable =
                new JTable(tableModel);

        orderTable.setSelectionMode(
                ListSelectionModel.SINGLE_SELECTION
        );

        orderTable
                .getSelectionModel()
                .addListSelectionListener(e -> {

                    if (!e.getValueIsAdjusting()) {
                        selectOrder();
                    }

                });

        JScrollPane scrollPane =
                new JScrollPane(orderTable);

        mainPanel.add(
                scrollPane,
                BorderLayout.CENTER
        );

        // Bottom panel
        JPanel bottomPanel =
                new JPanel(
                        new FlowLayout(
                                FlowLayout.CENTER,
                                10,
                                10
                        )
                );

        statusComboBox =
                new JComboBox<>(
                        new String[]{
                                "PLACED",
                                "PROCESSING",
                                "SHIPPED",
                                "DELIVERED",
                                "CANCELLED"
                        }
                );

        JButton updateButton =
                new JButton("Update Status");

        JButton detailsButton =
                new JButton("View Details");

        JButton clearButton =
                new JButton("Clear");

        JButton closeButton =
                new JButton("Close");

        bottomPanel.add(
                new JLabel("New Status:")
        );

        bottomPanel.add(
                statusComboBox
        );

        bottomPanel.add(updateButton);
        bottomPanel.add(detailsButton);
        bottomPanel.add(clearButton);
        bottomPanel.add(closeButton);

        mainPanel.add(
                bottomPanel,
                BorderLayout.SOUTH
        );

        add(mainPanel);

        updateButton.addActionListener(
                e -> updateStatus()
        );

        detailsButton.addActionListener(
                e -> viewDetails()
        );

        clearButton.addActionListener(
                e -> clearSelection()
        );

        closeButton.addActionListener(
                e -> dispose()
        );
    }

    private void loadOrders() {

        tableModel.setRowCount(0);

        List<Object[]> orders =
                orderController.getAllOrders();

        for (Object[] order : orders) {

            tableModel.addRow(order);
        }
    }

    private void selectOrder() {

        int selectedRow =
                orderTable.getSelectedRow();

        if (selectedRow == -1) {
            return;
        }

        selectedOrderId =
                Integer.parseInt(
                        orderTable
                                .getValueAt(
                                        selectedRow,
                                        0
                                )
                                .toString()
                );

        String status =
                orderTable
                        .getValueAt(
                                selectedRow,
                                4
                        )
                        .toString();

        statusComboBox.setSelectedItem(status);
    }

    private void updateStatus() {

        if (selectedOrderId == -1) {

            JOptionPane.showMessageDialog(
                    this,
                    "Please select an order first.",
                    "Validation Error",
                    JOptionPane.WARNING_MESSAGE
            );

            return;
        }

        String newStatus =
                statusComboBox
                        .getSelectedItem()
                        .toString();

        boolean success =
                orderController.updateOrderStatus(
                        selectedOrderId,
                        newStatus
                );

        if (success) {

            JOptionPane.showMessageDialog(
                    this,
                    "Order status updated successfully.",
                    "Success",
                    JOptionPane.INFORMATION_MESSAGE
            );

            loadOrders();

            selectedOrderId = -1;

        } else {

            JOptionPane.showMessageDialog(
                    this,
                    "Unable to update order status.",
                    "Error",
                    JOptionPane.ERROR_MESSAGE
            );
        }
    }

    private void viewDetails() {

        if (selectedOrderId == -1) {

            JOptionPane.showMessageDialog(
                    this,
                    "Please select an order first.",
                    "Validation Error",
                    JOptionPane.WARNING_MESSAGE
            );

            return;
        }

        List<Object[]> items =
                orderController.getOrderItems(
                        selectedOrderId
                );

        if (items.isEmpty()) {

            JOptionPane.showMessageDialog(
                    this,
                    "No order items found.",
                    "Order Details",
                    JOptionPane.INFORMATION_MESSAGE
            );

            return;
        }

        StringBuilder details =
                new StringBuilder();

        details.append(
                "Order ID: "
        ).append(selectedOrderId)
         .append("\n\n");

        details.append(
                String.format(
                        "%-25s %-10s %-12s %-12s%n",
                        "Product",
                        "Quantity",
                        "Price",
                        "Total"
                )
        );

        details.append(
                "------------------------------------------------------------\n"
        );

        for (Object[] item : items) {

            details.append(
                    String.format(
                            "%-25s %-10s ₹%-11.2f ₹%-11.2f%n",
                            item[0],
                            item[1],
                            item[2],
                            item[3]
                    )
            );
        }

        JTextArea textArea =
                new JTextArea(
                        details.toString()
                );

        textArea.setEditable(false);

        textArea.setFont(
                new Font(
                        Font.MONOSPACED,
                        Font.PLAIN,
                        13
                )
        );

        JScrollPane scrollPane =
                new JScrollPane(textArea);

        scrollPane.setPreferredSize(
                new Dimension(650, 300)
        );

        JOptionPane.showMessageDialog(
                this,
                scrollPane,
                "Order Details",
                JOptionPane.INFORMATION_MESSAGE
        );
    }

    private void clearSelection() {

        orderTable.clearSelection();

        selectedOrderId = -1;

        statusComboBox.setSelectedIndex(0);
    }
}