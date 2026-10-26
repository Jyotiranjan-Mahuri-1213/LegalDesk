<%--
  Created by IntelliJ IDEA.
  User: jyotiranjanmahuri
  Date: 23-10-2026
  Time: 23:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.court.entity.Case" %>
<%@ page import="com.court.entity.User" %>

<%
    if (session.getAttribute("loggedInUser") == null
            || !"ADMIN".equals(session.getAttribute("userRole"))) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    List<Case> cases =
            (List<Case>) request.getAttribute("cases");

    List<User> approvedLawyers =
            (List<User>) request.getAttribute("approvedLawyers");

    String assignment = request.getParameter("assignment");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>LegalDesk | Case Management</title>

    <style>
        * {
            box-sizing: border-box;
            font-family: Arial, sans-serif;
        }

        body {
            margin: 0;
            padding: 30px;
            background: #f1f5f9;
            color: #1e293b;
        }

        .container {
            max-width: 1400px;
            margin: auto;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 15px;
            margin-bottom: 25px;
        }

        h1 {
            color: #172554;
            margin-bottom: 8px;
        }

        .back {
            background: #172554;
            color: white;
            padding: 11px 16px;
            border-radius: 6px;
            text-decoration: none;
        }

        .back:hover {
            background: #1e40af;
        }

        .table-container {
            background: white;
            padding: 20px;
            border-radius: 10px;
            overflow-x: auto;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            min-width: 1100px;
        }

        th, td {
            padding: 14px;
            text-align: left;
            border-bottom: 1px solid #e2e8f0;
            vertical-align: middle;
        }

        th {
            background: #172554;
            color: white;
            white-space: nowrap;
        }

        tbody tr:hover {
            background: #f8fafc;
        }

        .status {
            display: inline-block;
            padding: 5px 10px;
            border-radius: 20px;
            background: #fef3c7;
            color: #92400e;
            font-size: 12px;
            font-weight: bold;
        }

        .assigned {
            color: #166534;
            font-weight: bold;
        }

        .unassigned {
            color: #b45309;
            font-weight: bold;
        }

        select,
        button {
            padding: 9px;
            margin: 4px 0;
            border-radius: 5px;
            border: 1px solid #cbd5e1;
        }

        select {
            width: 210px;
            max-width: 100%;
            background: white;
        }

        button {
            background: #2563eb;
            color: white;
            cursor: pointer;
            border: none;
            font-weight: bold;
        }

        button:hover {
            background: #1d4ed8;
        }

        .message {
            padding: 14px 18px;
            margin-bottom: 20px;
            border-radius: 7px;
            font-weight: bold;
        }

        .success {
            background: #dcfce7;
            color: #166534;
            border: 1px solid #86efac;
        }

        .error {
            background: #fee2e2;
            color: #991b1b;
            border: 1px solid #fca5a5;
        }

        .empty {
            padding: 25px;
            text-align: center;
            color: #64748b;
        }

        .no-lawyers {
            color: #b45309;
            font-size: 13px;
            display: block;
            margin-bottom: 5px;
        }

        @media (max-width: 768px) {
            body {
                padding: 15px;
            }

            .table-container {
                padding: 12px;
            }
        }
    </style>
</head>

<body>
<div class="container">

    <div class="header">
        <div>
            <h1>Case Management</h1>
            <p>View registered cases and assign or change their lawyers.</p>
        </div>

        <a class="back"
           href="<%= request.getContextPath() %>/admin/dashboard">
            Back to Dashboard
        </a>
    </div>

    <% if ("success".equals(assignment)) { %>
    <div class="message success">
        Lawyer assigned successfully.
    </div>
    <% } else if ("invalidLawyer".equals(assignment)) { %>
    <div class="message error">
        Invalid selection. Please choose an active, approved lawyer.
    </div>
    <% } else if ("failed".equals(assignment)) { %>
    <div class="message error">
        Unable to assign the lawyer. Please try again.
    </div>
    <% } %>

    <div class="table-container">

        <% if (cases == null || cases.isEmpty()) { %>

        <div class="empty">
            No registered cases found.
        </div>

        <% } else { %>

        <table>
            <thead>
            <tr>
                <th>Case Number</th>
                <th>Title</th>
                <th>Case Type</th>
                <th>Litigant ID</th>
                <th>Filing Date</th>
                <th>Status</th>
                <th>Lawyer Assignment</th>
                <th>Assign / Change Lawyer</th>
            </tr>
            </thead>

            <tbody>
            <% for (Case courtCase : cases) { %>
            <tr>
                <td><%= courtCase.getCaseNumber() %></td>
                <td><%= courtCase.getTitle() %></td>
                <td><%= courtCase.getCaseType() %></td>
                <td><%= courtCase.getLitigantId() %></td>
                <td><%= courtCase.getFilingDate() %></td>

                <td>
                            <span class="status">
                                <%= courtCase.getStatus() %>
                            </span>
                </td>

                <td>
                    <% if (courtCase.getLawyerId() > 0) { %>
                    <span class="assigned">
                                    Assigned (ID: <%= courtCase.getLawyerId() %>)
                                </span>
                    <% } else { %>
                    <span class="unassigned">
                                    Not assigned
                                </span>
                    <% } %>
                </td>

                <td>
                    <% if (approvedLawyers != null
                            && !approvedLawyers.isEmpty()) { %>

                    <form method="post"
                          action="<%= request.getContextPath() %>/admin/assign-lawyer">

                        <input type="hidden"
                               name="caseId"
                               value="<%= courtCase.getId() %>">

                        <select name="lawyerId" required>
                            <option value="">Select approved lawyer</option>

                            <% for (User lawyer : approvedLawyers) { %>
                            <option value="<%= lawyer.getId() %>"
                                    <%= courtCase.getLawyerId() == lawyer.getId()
                                            ? "selected" : "" %>>
                                <%= lawyer.getName() %>
                                (ID: <%= lawyer.getId() %>)
                            </option>
                            <% } %>
                        </select>

                        <button type="submit">
                            <%= courtCase.getLawyerId() > 0
                                    ? "Change Lawyer"
                                    : "Assign Lawyer" %>
                        </button>
                    </form>

                    <% } else { %>

                    <span class="no-lawyers">
                                    No approved active lawyers available.
                                </span>

                    <% } %>
                </td>
            </tr>
            <% } %>
            </tbody>
        </table>

        <% } %>

    </div>
</div>
</body>
</html>
