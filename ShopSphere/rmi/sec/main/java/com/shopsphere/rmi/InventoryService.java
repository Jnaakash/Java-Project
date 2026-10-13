package com.shopsphere.rmi;

import java.rmi.Remote;
import java.rmi.RemoteException;

public interface InventoryService extends Remote {

    String getProduct(int productId)
            throws RemoteException;

    String getStock(int productId)
            throws RemoteException;

    String searchProduct(String keyword)
            throws RemoteException;
}