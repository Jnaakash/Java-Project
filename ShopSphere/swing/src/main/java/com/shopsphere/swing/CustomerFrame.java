package com.shopsphere.swing;

import com.shopsphere.swing.controller.CustomerController;

import javax.swing.*;
import javax.swing.table.DefaultTableModel;
import java.awt.*;
import java.util.List;

public class CustomerFrame extends JFrame {

    private JTextField nameField;
    private JTextField emailField;
    private JTextField phoneField;

    private JTable customerTable;

    private DefaultTableModel tableModel;

    private CustomerController controller;

    private int selectedCustomerId = -1;


    public CustomerFrame() {

        controller = new CustomerController();

        setTitle("ShopSphere - Customer Management");

        setSize(900, 600);

        setLocationRelativeTo(null);

        setDefaultCloseOperation(
                JFrame.DISPOSE_ON_CLOSE
        );

        createUI();

        loadCustomers();
    }


    private void createUI() {

        JPanel mainPanel =
                new JPanel(new BorderLayout(10, 10));

        mainPanel.setBorder(
                BorderFactory.createEmptyBorder(
                        10, 10, 10, 10
                )
        );


        // ==========================
        // FORM PANEL
        // ==========================

        JPanel formPanel =
                new JPanel(new GridLayout(3, 2, 10, 10));


        formPanel.add(
                new JLabel("Customer Name:")
        );

        nameField = new JTextField();

        formPanel.add(nameField);


        formPanel.add(
                new JLabel("Email:")
        );

        emailField = new JTextField();

        formPanel.add(emailField);


        formPanel.add(
                new JLabel("Phone:")
        );

        phoneField = new JTextField();

        formPanel.add(phoneField);


        mainPanel.add(
                formPanel,
                BorderLayout.NORTH
        );


        // ==========================
        // TABLE
        // ==========================

        tableModel =
                new DefaultTableModel(
                        new Object[]{
                                "ID",
                                "Name",
                                "Email",
                                "Phone",
                                "Status"
                        },
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


        customerTable =
                new JTable(tableModel);


        customerTable.setRowHeight(25);


        customerTable
                .getSelectionModel()
                .addListSelectionListener(e -> {

                    if (!e.getValueIsAdjusting()) {

                        selectCustomer();
                    }
                });


        JScrollPane scrollPane =
                new JScrollPane(customerTable);


        mainPanel.add(
                scrollPane,
                BorderLayout.CENTER
        );


        // ==========================
        // BUTTON PANEL
        // ==========================

        JPanel buttonPanel =
                new JPanel(
                        new FlowLayout(
                                FlowLayout.CENTER,
                                10,
                                10
                        )
                );


        JButton updateButton =
                new JButton("Update");


        JButton deactivateButton =
                new JButton("Deactivate");


        JButton activateButton =
                new JButton("Activate");


        JButton clearButton =
                new JButton("Clear");


        JButton closeButton =
                new JButton("Close");


        buttonPanel.add(updateButton);

        buttonPanel.add(deactivateButton);

        buttonPanel.add(activateButton);

        buttonPanel.add(clearButton);

        buttonPanel.add(closeButton);


        mainPanel.add(
                buttonPanel,
                BorderLayout.SOUTH
        );


        // ==========================
        // EVENTS
        // ==========================

        updateButton.addActionListener(
                e -> updateCustomer()
        );


        deactivateButton.addActionListener(
                e -> deactivateCustomer()
        );


        activateButton.addActionListener(
                e -> activateCustomer()
        );


        clearButton.addActionListener(
                e -> clearFields()
        );


        closeButton.addActionListener(
                e -> dispose()
        );


        add(mainPanel);
    }


    // ==============================
    // LOAD CUSTOMERS
    // ==============================

    private void loadCustomers() {

        tableModel.setRowCount(0);

        List<Object[]> customers =
                controller.getAllCustomers();


        for (Object[] customer : customers) {

            tableModel.addRow(customer);
        }
    }


    // ==============================
    // SELECT CUSTOMER
    // ==============================

    private void selectCustomer() {

        int row =
                customerTable.getSelectedRow();


        if (row == -1) {
            return;
        }


        selectedCustomerId =
                Integer.parseInt(
                        customerTable
                                .getValueAt(row, 0)
                                .toString()
                );


        nameField.setText(
                customerTable
                        .getValueAt(row, 1)
                        .toString()
        );


        emailField.setText(
                customerTable
                        .getValueAt(row, 2)
                        .toString()
        );


        phoneField.setText(
                customerTable
                        .getValueAt(row, 3)
                        .toString()
        );
    }


    // ==============================
    // UPDATE
    // ==============================

    private void updateCustomer() {

        if (selectedCustomerId <= 0) {

            JOptionPane.showMessageDialog(
                    this,
                    "Please select a customer first."
            );

            return;
        }


        boolean success =
                controller.updateCustomer(
                        selectedCustomerId,
                        nameField.getText(),
                        emailField.getText(),
                        phoneField.getText()
                );


        if (success) {

            JOptionPane.showMessageDialog(
                    this,
                    "Customer updated successfully."
            );

            loadCustomers();

            clearFields();

        } else {

            JOptionPane.showMessageDialog(
                    this,
                    "Customer update failed.",
                    "Error",
                    JOptionPane.ERROR_MESSAGE
            );
        }
    }


    // ==============================
    // DEACTIVATE
    // ==============================

    private void deactivateCustomer() {

        if (selectedCustomerId <= 0) {

            JOptionPane.showMessageDialog(
                    this,
                    "Please select a customer first."
            );

            return;
        }


        int confirm =
                JOptionPane.showConfirmDialog(
                        this,
                        "Deactivate this customer?",
                        "Confirm",
                        JOptionPane.YES_NO_OPTION
                );


        if (confirm != JOptionPane.YES_OPTION) {
            return;
        }


        boolean success =
                controller.deactivateCustomer(
                        selectedCustomerId
                );


        if (success) {

            JOptionPane.showMessageDialog(
                    this,
                    "Customer deactivated."
            );

            loadCustomers();

            clearFields();

        } else {

            JOptionPane.showMessageDialog(
                    this,
                    "Operation failed.",
                    "Error",
                    JOptionPane.ERROR_MESSAGE
            );
        }
    }


    // ==============================
    // ACTIVATE
    // ==============================

    private void activateCustomer() {

        if (selectedCustomerId <= 0) {

            JOptionPane.showMessageDialog(
                    this,
                    "Please select a customer first."
            );

            return;
        }


        boolean success =
                controller.activateCustomer(
                        selectedCustomerId
                );


        if (success) {

            JOptionPane.showMessageDialog(
                    this,
                    "Customer activated."
            );

            loadCustomers();

            clearFields();

        } else {

            JOptionPane.showMessageDialog(
                    this,
                    "Operation failed.",
                    "Error",
                    JOptionPane.ERROR_MESSAGE
            );
        }
    }


    // ==============================
    // CLEAR
    // ==============================

    private void clearFields() {

        selectedCustomerId = -1;

        nameField.setText("");

        emailField.setText("");

        phoneField.setText("");

        customerTable.clearSelection();
    }
}