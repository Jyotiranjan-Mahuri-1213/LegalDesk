package com.court.controller;

import com.court.dao.AdminDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/admin/lawyer-action")
public class LawyerVerificationActionController extends HttpServlet {

    private final AdminDAO adminDAO = new AdminDAO();

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        String userIdParam = request.getParameter("userId");

        int userId = Integer.parseInt(userIdParam);

        if ("approve".equals(action)) {

            adminDAO.approveLawyer(userId);

        } else if ("reject".equals(action)) {

            adminDAO.rejectLawyer(userId);
        }

        response.sendRedirect(
                request.getContextPath() + "/admin/lawyers"
        );
    }
}