package com.court.dao;

import com.court.entity.User;
import com.court.utility.DBConnection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {

    public boolean registerUser(User user) {

        String sql = "INSERT INTO users " +
                "(name, email, password, mobile_no, role, status, verification_status, verification_remarks) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            System.out.println("MySQL connection established");

            ps.setString(1, user.getName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword());
            ps.setString(4, user.getMobileNo());
            ps.setString(5, user.getRole());
            ps.setString(6, user.getStatus());
            ps.setString(7, user.getVerificationStatus());
            ps.setString(8, user.getVerificationRemarks());

            int rows = ps.executeUpdate();

            System.out.println("Rows inserted: " + rows);

            return rows > 0;

        } catch (Exception e) {

            System.out.println("Registration database error:");
            e.printStackTrace();

            return false;
        }
    }
    public User loginUser(String email, String password) {

        String sql = "SELECT * FROM users " +
                "WHERE email = ? AND password = ? AND status = 'ACTIVE'";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                User user = new User();

                user.setId(rs.getInt("id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setMobileNo(rs.getString("mobile_no"));
                user.setRole(rs.getString("role"));
                user.setStatus(rs.getString("status"));
                user.setVerificationStatus(
                        rs.getString("verification_status")
                );
                user.setVerificationRemarks(
                        rs.getString("verification_remarks")
                );

                return user;
            }

        } catch (Exception e) {
            System.out.println("Login database error:");
            e.printStackTrace();
        }

        return null;
    }

}