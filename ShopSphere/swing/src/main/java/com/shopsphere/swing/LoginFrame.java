package com.shopsphere.swing;

import com.shopsphere.swing.controller.LoginController;

import javax.swing.*;
import java.awt.*;

public class LoginFrame extends JFrame {

    private JTextField usernameField;
    private JPasswordField passwordField;

    private LoginController loginController;

    public LoginFrame() {

        loginController = new LoginController();

        setTitle("ShopSphere - Admin Login");
        setSize(450, 300);
        setLocationRelativeTo(null);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setResizable(false);

        createUI();
    }

    private void createUI() {

        JPanel mainPanel = new JPanel(new GridBagLayout());
        GridBagConstraints gbc = new GridBagConstraints();

        gbc.insets = new Insets(10, 10, 10, 10);
        gbc.fill = GridBagConstraints.HORIZONTAL;

        JLabel titleLabel = new JLabel(
                "ShopSphere Admin Login",
                SwingConstants.CENTER
        );

        titleLabel.setFont(new Font("Arial", Font.BOLD, 22));

        gbc.gridx = 0;
        gbc.gridy = 0;
        gbc.gridwidth = 2;

        mainPanel.add(titleLabel, gbc);

        // Username
        gbc.gridwidth = 1;

        gbc.gridx = 0;
        gbc.gridy = 1;

        mainPanel.add(new JLabel("Username / Email:"), gbc);

        usernameField = new JTextField(20);

        gbc.gridx = 1;
        gbc.gridy = 1;

        mainPanel.add(usernameField, gbc);

        // Password
        gbc.gridx = 0;
        gbc.gridy = 2;

        mainPanel.add(new JLabel("Password:"), gbc);

        passwordField = new JPasswordField(20);

        gbc.gridx = 1;
        gbc.gridy = 2;

        mainPanel.add(passwordField, gbc);

        // Login Button
        JButton loginButton = new JButton("Login");

        gbc.gridx = 0;
        gbc.gridy = 3;

        mainPanel.add(loginButton, gbc);

        // Exit Button
        JButton exitButton = new JButton("Exit");

        gbc.gridx = 1;
        gbc.gridy = 3;

        mainPanel.add(exitButton, gbc);

        add(mainPanel);

        // Login button action
        loginButton.addActionListener(e -> login());

        // Exit button action
        exitButton.addActionListener(e -> System.exit(0));

        // Enter key login
        passwordField.addActionListener(e -> login());
    }

    private void login() {

        String username = usernameField.getText().trim();

        String password = new String(
                passwordField.getPassword()
        );

        if (username.isEmpty() || password.isEmpty()) {

            JOptionPane.showMessageDialog(
                    this,
                    "Please enter username and password.",
                    "Validation Error",
                    JOptionPane.WARNING_MESSAGE
            );

            return;
        }

        boolean authenticated =
                loginController.login(username, password);

        if (authenticated) {

            JOptionPane.showMessageDialog(
                    this,
                    "Login successful!",
                    "Success",
                    JOptionPane.INFORMATION_MESSAGE
            );

            AdminDashboard dashboard =
                    new AdminDashboard();

            dashboard.setVisible(true);

            dispose();

        } else {

            JOptionPane.showMessageDialog(
                    this,
                    "Invalid admin credentials or account is inactive.",
                    "Login Failed",
                    JOptionPane.ERROR_MESSAGE
            );

            passwordField.setText("");
        }
    }

    public static void main(String[] args) {

        try {

            UIManager.setLookAndFeel(
                    UIManager.getSystemLookAndFeelClassName()
            );

        } catch (Exception e) {

            e.printStackTrace();
        }

        SwingUtilities.invokeLater(() -> {

            LoginFrame loginFrame =
                    new LoginFrame();

            loginFrame.setVisible(true);
        });
    }
}