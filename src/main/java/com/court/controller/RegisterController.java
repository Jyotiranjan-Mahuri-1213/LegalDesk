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

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String mobileNo = request.getParameter("mobileNo");
        String role = request.getParameter("role");

        User user = new User();

        user.setName(name);
        user.setEmail(email);
        user.setPassword(password);
        user.setMobileNo(mobileNo);
        user.setRole(role);
        user.setStatus("ACTIVE");

        boolean registered = userDAO.registerUser(user);

        if (registered) {

            response.sendRedirect("login.jsp");

        } else {

            response.sendRedirect("register.jsp?error=failed");
        }
    }
}