package com.court.dao;

import com.court.entity.User;
import com.court.utility.DBConnection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {

    public boolean registerUser(User user) {

        String sql = "insert into users (name, email, password, mobile_no, role, status, verification_status, verification_remarks) values (?, ?, ?, ?, ?, ?, ?, ?)";

        try {
                DriverManager.getConnection("com.mysql.cj.jdbc.Driver");
            System.out.println("MySQL Driver: " +
                    com.mysql.cj.jdbc.Driver.class.getName());
                Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, user.getName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword());
            ps.setString(4, user.getMobileNo());
            ps.setString(5, user.getRole());
            ps.setString(6, user.getStatus());
            ps.setString(7, user.getVerificationStatus());
            ps.setString(8, user.getVerificationRemarks());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            System.out.println("Registration database error:");
            e.printStackTrace();
            return false;
        }
    }
    public User loginUser(String email, String password) {

        String sql = " select * from users where email = ? and password = ? and status = 'ACTIVE' )";

        try {
            DriverManager.getConnection("com.mysql.cj.jdbc.driver");
            Connection connection = DBConnection.getConnection();

            PreparedStatement ps =
                    connection.prepareStatement(sql);

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

                rs.close();
                ps.close();
                connection.close();

                return user;
            }

            rs.close();
            ps.close();
            connection.close();

        } catch (Exception e) {
            System.out.println("Registration database error:");
            e.printStackTrace();
        }

        return null;
    }
}