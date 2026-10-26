
package com.court.controller;

import com.court.dao.CaseDAO;
import com.court.entity.Case;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

import com.court.dao.UserDAO;
import com.court.entity.User;

@WebServlet("/admin/cases")
public class AdminCaseController extends HttpServlet {

    private final CaseDAO caseDAO = new CaseDAO();
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null
                || session.getAttribute("loggedInUser") == null
                || !"ADMIN".equals(session.getAttribute("userRole"))) {
            response.sendRedirect(
                    request.getContextPath() + "/login.jsp");
            return;
        }

        List<Case> cases = caseDAO.getAllCases();
        List<User> approvedLawyers = userDAO.getApprovedLawyers();

        request.setAttribute("cases", cases);
        request.setAttribute("approvedLawyers", approvedLawyers);

        request.getRequestDispatcher(
                        "/admin/case-management.jsp")
                .forward(request, response);
    }
}
