package com.shopsphere.swing.controller;

import com.shopsphere.swing.dao.CustomerDAO;

import java.util.List;

public class CustomerController {

    private final CustomerDAO customerDAO;

    public CustomerController() {

        customerDAO = new CustomerDAO();
    }


    public List<Object[]> getAllCustomers() {

        return customerDAO.getAllCustomers();
    }


    public boolean updateCustomer(
            int userId,
            String name,
            String email,
            String phone
    ) {

        if (userId <= 0) {
            return false;
        }

        if (name == null || name.trim().isEmpty()) {
            return false;
        }

        if (email == null || email.trim().isEmpty()) {
            return false;
        }

        if (phone == null || phone.trim().isEmpty()) {
            return false;
        }

        return customerDAO.updateCustomer(
                userId,
                name.trim(),
                email.trim(),
                phone.trim()
        );
    }


    public boolean deactivateCustomer(int userId) {

        if (userId <= 0) {
            return false;
        }

        return customerDAO.deactivateCustomer(userId);
    }


    public boolean activateCustomer(int userId) {

        if (userId <= 0) {
            return false;
        }

        return customerDAO.activateCustomer(userId);
    }
}