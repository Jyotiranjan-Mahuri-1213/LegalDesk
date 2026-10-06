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



    public List<User> getPendingLawyers() {

        List<User> lawyers = new ArrayList<>();

        String sql = "select * from users where role = 'LAWYER' and verification_status = 'PENDING'";

        try{
            Connection connection = DBConnection.getConnection();

             PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery();

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