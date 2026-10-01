package com.court.controller;

import com.court.dao.UserDAO;
import com.court.entity.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/register")
public class RegisterController extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() {

        userDAO = new UserDAO();
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("========== REGISTRATION DEBUG ==========");
        System.out.println("Request URI: " + request.getRequestURI());
        System.out.println("Request Method: " + request.getMethod());
        System.out.println("Content Type: " + request.getContentType());
        System.out.println("Parameter Names: " +
                java.util.Collections.list(request.getParameterNames()));
        System.out.println("Name Parameter: " + request.getParameter("name"));
        System.out.println("=========================================");

        String name = request.getParameter("name");
        System.out.println("Name received from form: " + name);
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String mobileNo = request.getParameter("mobileNo");
        String role = request.getParameter("role");

        if (!"LAWYER".equals(role) && !"LITIGANT".equals(role)) {
            response.sendError(
                    HttpServletResponse.SC_FORBIDDEN,
                    "Invalid registration role"
            );
            return;
        }

        User user = new User();

        user.setName(name);
        user.setEmail(email);
        user.setPassword(password);
        user.setMobileNo(mobileNo);
        user.setRole(role);
        user.setStatus("ACTIVE");

        if ("LAWYER".equals(role)) {
            user.setVerificationStatus("PENDING");
            user.setVerificationRemarks("Awaiting Admin verification");
        } else {
            user.setVerificationStatus("NOT_REQUIRED");
            user.setVerificationRemarks(null);
        }

        System.out.println("Registration request received");
        System.out.println("Name stored in User object: " + user.getName());

        boolean registered = userDAO.registerUser(user);

        System.out.println("Registration result: " + registered);

        if (registered) {
            System.out.println("Registration successful");
            response.sendRedirect(
                    request.getContextPath() + "/login.jsp?registered=true"
            );
        } else {
            System.out.println("Registration failed in UserDAO");
            response.sendRedirect(
                    request.getContextPath() + "/register.jsp?error=failed");
        }
    }
}