
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
import java.sql.Date;
import java.util.UUID;

@WebServlet("/cases/create")
public class CaseController extends HttpServlet {

    private final CaseDAO caseDAO = new CaseDAO();

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null
                || session.getAttribute("loggedInUser") == null
                || !"LITIGANT".equals(session.getAttribute("userRole"))) {

            response.sendError(HttpServletResponse.SC_FORBIDDEN,
                    "Only logged-in litigants can register cases.");
            return;
        }

        try {
            String title = request.getParameter("title");
            String description = request.getParameter("description");
            String caseType = request.getParameter("caseType");

            if (title == null || title.isBlank()
                    || caseType == null || caseType.isBlank()) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST,
                        "Case title and case type are required.");
                return;
            }

            Case courtCase = new Case();

            courtCase.setCaseNumber("LD-" + UUID.randomUUID()
                    .toString().substring(0, 8).toUpperCase());

            courtCase.setTitle(title.trim());
            courtCase.setDescription(
                    description == null ? "" : description.trim());
            courtCase.setCaseType(caseType.trim());
            courtCase.setStatus("PENDING");
            courtCase.setLitigantId(
                    Integer.parseInt(session.getAttribute("userId").toString()));
            courtCase.setLawyerId(0);
            courtCase.setFilingDate(
                    new Date(System.currentTimeMillis()));

            if (caseDAO.createCase(courtCase)) {
                response.sendRedirect(
                        request.getContextPath()
                                + "/litigant/dashboard?caseCreated=success");
            } else {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                        "Unable to register the case.");
            }

        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid user information.");
        }
    }
}
