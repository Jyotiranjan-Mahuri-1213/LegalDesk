package com.court.controller;

import com.court.dao.AdminDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/admin/dashboard")
public class AdminDashboardController extends HttpServlet {

    private final AdminDAO adminDAO = new AdminDAO();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        int totalUsers = adminDAO.getTotalUsers();
        System.out.println("Total users sent to JSP: " + totalUsers);
        request.setAttribute("totalUsers", totalUsers);

        request.getRequestDispatcher("/admin/dashboard.jsp")
                .forward(request, response);
    }
}