package com.shopsphere.swing.controller;

import com.shopsphere.swing.dao.UserDAO;

public class LoginController {

    private UserDAO userDAO;

    public LoginController() {
        userDAO = new UserDAO();
    }

    public boolean login(String username, String password) {

        System.out.println("DEBUG: LoginController called");

        boolean result = userDAO.validateAdmin(username, password);

        System.out.println("DEBUG: Authentication result = " + result);

        return result;
    }
}