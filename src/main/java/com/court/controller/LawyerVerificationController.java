package com.court.controller;

import com.court.dao.AdminDAO;
import com.court.entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/lawyers")
public class LawyerVerificationController extends HttpServlet {

    private final AdminDAO adminDAO = new AdminDAO();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        List<User> pendingLawyers = adminDAO.getPendingLawyers();

        System.out.println("Pending lawyers sent to JSP: "
                + pendingLawyers.size());

        request.setAttribute("pendingLawyers", pendingLawyers);

        request.getRequestDispatcher("/admin/lawyers.jsp")
                .forward(request, response);
    }
}