package com.court.dao;

import com.court.entity.User;
import com.court.utility.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class AdminDAO {


    public int getTotalUsers() {

        String sql = "select count(*) from users";

        try {
            Connection connection = DBConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                int totalUsers = rs.getInt(1);
                System.out.println("Total users from database: " + totalUsers);
                return totalUsers;
            }

        } catch (Exception e) {
            System.out.println("Error getting total users:");
            e.printStackTrace();
        }

        return 0;
    }



    public int getPendingLawyersCount() {

        String sql = "select count(*) from users where role = 'LAWYER' and verification_status = 'PENDING' ";

        try {
            Connection connection = DBConnection.getConnection();

             PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (Exception e) {
            System.out.println("Error getting pending lawyers count:");
            e.printStackTrace();
        }

        return 0;
    }

    public boolean approveLawyer(int userId) {

        String sql = "update users set verification_status = 'APPROVED', verification_remarks = 'Approved by Admin' where id = ? AND role = 'LAWYER'";

        try {
            Connection connection = DBConnection.getConnection();

             PreparedStatement ps = connection.prepareStatement(sql) ;

            ps.setInt(1, userId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            System.out.println("Error approving lawyer:");
            e.printStackTrace();
        }

        return false;
    }


    public boolean rejectLawyer(int userId) {

        String sql = "update users set verification_status = 'REJECTED', verification_remarks = 'Rejected by Admin' WHERE id = ? AND role = 'LAWYER'";

        try {
            Connection connection = DBConnection.getConnection();

             PreparedStatement ps = connection.prepareStatement(sql);

            ps.setInt(1, userId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            System.out.println("Error rejecting lawyer:");
            e.printStackTrace();
        }

        return false;
    }

    public List<User> getPendingLawyers() {

        List<User> lawyers = new ArrayList<>();

        String sql = "SELECT * FROM users " +
                "WHERE role = 'LAWYER' " +
                "AND verification_status = 'PENDING'";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {

                User user = new User();

                user.setId(rs.getInt("id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setMobileNo(rs.getString("mobile_no"));
                user.setRole(rs.getString("role"));
                user.setStatus(rs.getString("status"));
                user.setVerificationStatus(
                        rs.getString("verification_status")
                );
                user.setVerificationRemarks(
                        rs.getString("verification_remarks")
                );

                lawyers.add(user);
            }

        } catch (Exception e) {
            System.out.println("Error getting pending lawyers:");
            e.printStackTrace();
        }

        return lawyers;
    }
}