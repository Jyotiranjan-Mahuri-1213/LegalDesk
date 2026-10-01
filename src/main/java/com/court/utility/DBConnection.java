package com.court.utility;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {

    private static final String url = "jdbc:mysql://localhost:3306/legaldesk_db";

    private static final String user = "root";

    private static final String password = "Jyoti@2004";

    public static Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");

        return DriverManager.getConnection(url,user,password);
    }

    public static void main(String[] args) {

        try {


            Connection connection = getConnection();

            if (connection != null) {
                System.out.println(
                        " Connected Successfully!"
                );

                connection.close();
            }

        } catch (Exception e) {

            e.printStackTrace();
        }
    }
}