package com.shopsphere.dao;

import com.shopsphere.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class AddressDAO {

    public int saveAddress(int userId,
                           String addressLine,
                           String city,
                           String state,
                           String pincode,
                           String addressType) {

        String sql =
                "INSERT INTO addresses " +
                "(user_id, address_line, city, state, pincode, address_type) " +
                "VALUES (?, ?, ?, ?, ?, ?)";

        try (
            Connection connection = DBConnection.getConnection();
            PreparedStatement ps = connection.prepareStatement(
                    sql,
                    PreparedStatement.RETURN_GENERATED_KEYS
            )
        ) {

            ps.setInt(1, userId);
            ps.setString(2, addressLine);
            ps.setString(3, city);
            ps.setString(4, state);
            ps.setString(5, pincode);
            ps.setString(6, addressType);

            ps.executeUpdate();

            try (ResultSet rs = ps.getGeneratedKeys()) {

                if (rs.next()) {
                    return rs.getInt(1);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return -1;
    }


    public AddressData getAddressById(int addressId) {

        String sql =
                "SELECT address_id, user_id, address_line, " +
                "city, state, pincode, address_type " +
                "FROM addresses " +
                "WHERE address_id = ?";

        try (
            Connection connection = DBConnection.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql)
        ) {

            ps.setInt(1, addressId);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {

                    AddressData address = new AddressData();

                    address.setAddressId(
                            rs.getInt("address_id")
                    );

                    address.setUserId(
                            rs.getInt("user_id")
                    );

                    address.setAddressLine(
                            rs.getString("address_line")
                    );

                    address.setCity(
                            rs.getString("city")
                    );

                    address.setState(
                            rs.getString("state")
                    );

                    address.setPincode(
                            rs.getString("pincode")
                    );

                    address.setAddressType(
                            rs.getString("address_type")
                    );

                    return address;
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }


    public static class AddressData {

        private int addressId;
        private int userId;
        private String addressLine;
        private String city;
        private String state;
        private String pincode;
        private String addressType;


        public int getAddressId() {
            return addressId;
        }

        public void setAddressId(int addressId) {
            this.addressId = addressId;
        }


        public int getUserId() {
            return userId;
        }

        public void setUserId(int userId) {
            this.userId = userId;
        }


        public String getAddressLine() {
            return addressLine;
        }

        public void setAddressLine(String addressLine) {
            this.addressLine = addressLine;
        }


        public String getCity() {
            return city;
        }

        public void setCity(String city) {
            this.city = city;
        }


        public String getState() {
            return state;
        }

        public void setState(String state) {
            this.state = state;
        }


        public String getPincode() {
            return pincode;
        }

        public void setPincode(String pincode) {
            this.pincode = pincode;
        }


        public String getAddressType() {
            return addressType;
        }

        public void setAddressType(String addressType) {
            this.addressType = addressType;
        }
    }
}