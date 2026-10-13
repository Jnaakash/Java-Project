package com.shopsphere.swing;

import com.shopsphere.swing.controller.CategoryController;

import javax.swing.*;
import javax.swing.table.DefaultTableModel;
import java.awt.*;
import java.util.List;

public class CategoryFrame extends JFrame {

    private JTextField categoryNameField;

    private JRadioButton activeRadioButton;
    private JRadioButton inactiveRadioButton;

    private JTable categoryTable;
    private DefaultTableModel tableModel;

    private CategoryController categoryController;

    private int selectedCategoryId = -1;

    public CategoryFrame() {

        categoryController = new CategoryController();

        setTitle("ShopSphere - Category Management");
        setSize(750, 550);
        setLocationRelativeTo(null);
        setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);

        createUI();
        loadCategories();
    }

    private void createUI() {

        JPanel mainPanel =
                new JPanel(new BorderLayout(10, 10));

        mainPanel.setBorder(
                BorderFactory.createEmptyBorder(
                        10, 10, 10, 10
                )
        );

        // =========================
        // FORM PANEL
        // =========================

        JPanel formPanel =
                new JPanel(new GridLayout(2, 2, 10, 10));

        formPanel.add(
                new JLabel("Category Name:")
        );

        categoryNameField = new JTextField();

        formPanel.add(categoryNameField);

        formPanel.add(
                new JLabel("Status:")
        );

        JPanel statusPanel =
                new JPanel(new FlowLayout(FlowLayout.LEFT));

        activeRadioButton =
                new JRadioButton("Active", true);

        inactiveRadioButton =
                new JRadioButton("Inactive");

        ButtonGroup statusGroup =
                new ButtonGroup();

        statusGroup.add(activeRadioButton);
        statusGroup.add(inactiveRadioButton);

        statusPanel.add(activeRadioButton);
        statusPanel.add(inactiveRadioButton);

        formPanel.add(statusPanel);

        mainPanel.add(
                formPanel,
                BorderLayout.NORTH
        );

        // =========================
        // TABLE
        // =========================

        tableModel =
                new DefaultTableModel(
                        new Object[]{
                                "ID",
                                "Category Name",
                                "Status"
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

        categoryTable =
                new JTable(tableModel);

        categoryTable.setSelectionMode(
                ListSelectionModel.SINGLE_SELECTION
        );

        JScrollPane scrollPane =
                new JScrollPane(categoryTable);

        mainPanel.add(
                scrollPane,
                BorderLayout.CENTER
        );

        // =========================
        // BUTTON PANEL
        // =========================

        JPanel buttonPanel =
                new JPanel(new FlowLayout());

        JButton addButton =
                new JButton("Add");

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

        buttonPanel.add(addButton);
        buttonPanel.add(updateButton);
        buttonPanel.add(deactivateButton);
        buttonPanel.add(activateButton);
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
                e -> addCategory()
        );

        updateButton.addActionListener(
                e -> updateCategory()
        );

        deactivateButton.addActionListener(
                e -> deactivateCategory()
        );

        activateButton.addActionListener(
                e -> activateCategory()
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

        categoryTable
                .getSelectionModel()
                .addListSelectionListener(e -> {

                    if (!e.getValueIsAdjusting()) {

                        int row =
                                categoryTable
                                        .getSelectedRow();

                        if (row >= 0) {

                            selectedCategoryId =
                                    Integer.parseInt(
                                            tableModel
                                                    .getValueAt(
                                                            row,
                                                            0
                                                    )
                                                    .toString()
                                    );

                            categoryNameField.setText(
                                    tableModel
                                            .getValueAt(
                                                    row,
                                                    1
                                            )
                                            .toString()
                            );

                            String status =
                                    tableModel
                                            .getValueAt(
                                                    row,
                                                    2
                                            )
                                            .toString();

                            if (status.equalsIgnoreCase(
                                    "ACTIVE")) {

                                activeRadioButton
                                        .setSelected(true);

                            } else {

                                inactiveRadioButton
                                        .setSelected(true);
                            }
                        }
                    }
                });
    }

    // =========================
    // LOAD CATEGORIES
    // =========================

    private void loadCategories() {

        tableModel.setRowCount(0);

        List<Object[]> categories =
                categoryController.getAllCategories();

        for (Object[] category : categories) {

            tableModel.addRow(category);
        }
    }

    // =========================
    // ADD CATEGORY
    // =========================

    private void addCategory() {

        String name =
                categoryNameField.getText().trim();

        boolean status =
                activeRadioButton.isSelected();

        if (name.isEmpty()) {

            JOptionPane.showMessageDialog(
                    this,
                    "Please enter category name.",
                    "Validation Error",
                    JOptionPane.WARNING_MESSAGE
            );

            return;
        }

        boolean success =
                categoryController.addCategory(
                        name,
                        status
                );

        if (success) {

            JOptionPane.showMessageDialog(
                    this,
                    "Category added successfully.",
                    "Success",
                    JOptionPane.INFORMATION_MESSAGE
            );

            clearFields();
            loadCategories();

        } else {

            JOptionPane.showMessageDialog(
                    this,
                    "Unable to add category.",
                    "Error",
                    JOptionPane.ERROR_MESSAGE
            );
        }
    }

    // =========================
    // UPDATE CATEGORY
    // =========================

    private void updateCategory() {

        if (selectedCategoryId == -1) {

            JOptionPane.showMessageDialog(
                    this,
                    "Please select a category first.",
                    "Selection Required",
                    JOptionPane.WARNING_MESSAGE
            );

            return;
        }

        String name =
                categoryNameField.getText().trim();

        boolean status =
                activeRadioButton.isSelected();

        if (name.isEmpty()) {

            JOptionPane.showMessageDialog(
                    this,
                    "Please enter category name.",
                    "Validation Error",
                    JOptionPane.WARNING_MESSAGE
            );

            return;
        }

        boolean success =
                categoryController.updateCategory(
                        selectedCategoryId,
                        name,
                        status
                );

        if (success) {

            JOptionPane.showMessageDialog(
                    this,
                    "Category updated successfully.",
                    "Success",
                    JOptionPane.INFORMATION_MESSAGE
            );

            clearFields();
            loadCategories();

        } else {

            JOptionPane.showMessageDialog(
                    this,
                    "Unable to update category.",
                    "Error",
                    JOptionPane.ERROR_MESSAGE
            );
        }
    }

    // =========================
    // DEACTIVATE CATEGORY
    // =========================

    private void deactivateCategory() {

        if (selectedCategoryId == -1) {

            JOptionPane.showMessageDialog(
                    this,
                    "Please select a category first.",
                    "Selection Required",
                    JOptionPane.WARNING_MESSAGE
            );

            return;
        }

        int choice =
                JOptionPane.showConfirmDialog(
                        this,
                        "Are you sure you want to deactivate this category?",
                        "Confirm Deactivation",
                        JOptionPane.YES_NO_OPTION
                );

        if (choice != JOptionPane.YES_OPTION) {
            return;
        }

        boolean success =
                categoryController.deactivateCategory(
                        selectedCategoryId
                );

        if (success) {

            JOptionPane.showMessageDialog(
                    this,
                    "Category deactivated successfully.",
                    "Success",
                    JOptionPane.INFORMATION_MESSAGE
            );

            clearFields();
            loadCategories();

        } else {

            JOptionPane.showMessageDialog(
                    this,
                    "Unable to deactivate category.",
                    "Error",
                    JOptionPane.ERROR_MESSAGE
            );
        }
    }

    // =========================
    // ACTIVATE CATEGORY
    // =========================

    private void activateCategory() {

        if (selectedCategoryId == -1) {

            JOptionPane.showMessageDialog(
                    this,
                    "Please select a category first.",
                    "Selection Required",
                    JOptionPane.WARNING_MESSAGE
            );

            return;
        }

        boolean success =
                categoryController.activateCategory(
                        selectedCategoryId
                );

        if (success) {

            JOptionPane.showMessageDialog(
                    this,
                    "Category activated successfully.",
                    "Success",
                    JOptionPane.INFORMATION_MESSAGE
            );

            clearFields();
            loadCategories();

        } else {

            JOptionPane.showMessageDialog(
                    this,
                    "Unable to activate category.",
                    "Error",
                    JOptionPane.ERROR_MESSAGE
            );
        }
    }

    // =========================
    // CLEAR
    // =========================

    private void clearFields() {

        categoryNameField.setText("");

        activeRadioButton.setSelected(true);

        selectedCategoryId = -1;

        categoryTable.clearSelection();
    }
}