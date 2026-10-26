
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.court.entity.Case" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<%
    List<Case> assignedCases =
            (List<Case>) request.getAttribute("assignedCases");

    Integer assignedCasesCount =
            (Integer) request.getAttribute("assignedCasesCount");

    if (assignedCases == null) {
        assignedCases = java.util.Collections.emptyList();
    }

    if (assignedCasesCount == null) {
        assignedCasesCount = assignedCases.size();
    }

    if (session.getAttribute("loggedInUser") == null
            || !"LAWYER".equals(session.getAttribute("userRole"))) {
        response.sendRedirect(
                request.getContextPath() + "/login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>LegalDesk | Lawyer Dashboard</title>

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Arial, sans-serif;
        }

        body {
            background: #f1f5f9;
            color: #1e293b;
        }

        .navbar {
            background: #14532d;
            color: white;
            padding: 18px 35px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 15px;
            flex-wrap: wrap;
        }

        .brand {
            font-size: 21px;
            font-weight: bold;
        }

        .logout {
            background: #dc2626;
            color: white;
            padding: 9px 16px;
            text-decoration: none;
            border-radius: 5px;
        }

        .logout:hover {
            background: #b91c1c;
        }

        .container {
            max-width: 1400px;
            margin: 35px auto;
            padding: 20px;
        }

        .welcome {
            margin-bottom: 30px;
        }

        .welcome h2 {
            color: #14532d;
            margin-bottom: 10px;
        }

        .welcome p {
            margin-bottom: 8px;
            line-height: 1.6;
        }

        .cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 20px;
            margin-bottom: 35px;
        }

        .card {
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
            border-left: 4px solid #16a34a;
        }

        .card h3 {
            margin-bottom: 12px;
            color: #166534;
        }

        .card p {
            color: #64748b;
            line-height: 1.6;
            font-size: 14px;
        }

        .count {
            font-size: 32px;
            font-weight: bold;
            color: #15803d;
            margin-top: 10px;
        }

        .section-title {
            color: #14532d;
            margin-bottom: 18px;
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
            min-width: 700px;
            border-collapse: collapse;
        }

        th, td {
            padding: 14px;
            text-align: left;
            border-bottom: 1px solid #e2e8f0;
        }

        th {
            background: #14532d;
            color: white;
            white-space: nowrap;
        }

        tbody tr:hover {
            background: #f0fdf4;
        }

        .status {
            display: inline-block;
            padding: 5px 10px;
            border-radius: 20px;
            background: #dcfce7;
            color: #166534;
            font-size: 12px;
            font-weight: bold;
            white-space: nowrap;
        }

        .empty {
            padding: 30px 15px;
            text-align: center;
            color: #64748b;
            line-height: 1.7;
        }

        /* Scheduled hearings section */
        .dashboard-section {
            background: #ffffff;
            padding: 24px;
            margin-top: 30px;
            border-radius: 10px;
            border-left: 4px solid #16a34a;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
        }

        .dashboard-section h2 {
            color: #14532d;
            margin-bottom: 10px;
        }

        .dashboard-section > p {
            color: #64748b;
            margin-bottom: 20px;
            line-height: 1.6;
        }

        .dashboard-section .table-container {
            padding: 0;
            box-shadow: none;
            border-radius: 0;
        }

        .dashboard-section table {
            min-width: 850px;
        }

        .dashboard-section th {
            background: #14532d;
            color: white;
        }

        .dashboard-section td {
            overflow-wrap: anywhere;
        }

        .hearing-status {
            display: inline-block;
            padding: 5px 10px;
            border-radius: 20px;
            background: #dcfce7;
            color: #166534;
            font-size: 12px;
            font-weight: bold;
            white-space: nowrap;
        }

        .empty-message {
            padding: 25px !important;
            text-align: center !important;
            color: #64748b;
        }

        @media (max-width: 600px) {
            .navbar {
                padding: 16px;
            }

            .brand {
                font-size: 18px;
            }

            .container {
                margin: 20px auto;
                padding: 12px;
            }

            .table-container {
                padding: 12px;
            }

            .dashboard-section {
                padding: 16px;
            }

            .dashboard-section .table-container {
                padding: 0;
            }
        }

        .profile-link {
            display: inline-block;
            margin-top: 16px;
            padding: 10px 15px;
            background: #15803d;
            color: #ffffff;
            text-decoration: none;
            border-radius: 6px;
            font-size: 14px;
            font-weight: bold;
            transition: background 0.2s;
        }

        .profile-link:hover {
            background: #166534;
        }

    </style>
</head>

<body>

<header class="navbar">
    <div class="brand">LEGALDESK | LAWYER</div>

    <a class="logout"
       href="${pageContext.request.contextPath}/logout">
        Logout
    </a>
</header>

<main class="container">

    <!-- Welcome -->
    <section class="welcome">
        <h2>
            Welcome, <c:out value="${sessionScope.userName}" />!
        </h2>

        <p>Manage your assigned legal cases and hearing schedules.</p>

        <p>
            Role:
            <strong><c:out value="${sessionScope.userRole}" /></strong>
        </p>
    </section>

    <!-- Dashboard Cards -->
    <section class="cards">

        <div class="card">
            <h3>My Cases</h3>
            <p>Total cases assigned to you.</p>

            <div class="count">
                <%= assignedCasesCount %>
            </div>
        </div>

        <div class="card">
            <h3>Hearing Schedule</h3>
            <p>Review hearing dates and courtroom details in the schedule below.</p>
        </div>

        <div class="card">
            <h3>Notifications</h3>
            <p>Check case updates and hearing notifications.</p>
        </div>


        <div class="card">
            <h3>My Profile</h3>
            <p>View and update your lawyer account information.</p>

            <a href="${pageContext.request.contextPath}/lawyer/profile"
               class="profile-link">
                View Profile →
            </a>
        </div>

    </section>

    <!-- Assigned Cases -->
    <section>
        <h2 class="section-title">My Assigned Cases</h2>

        <div class="table-container">

            <% if (assignedCases.isEmpty()) { %>

            <div class="empty">
                <h3>No Cases Assigned Yet</h3>
                <p>
                    Cases assigned to your account by the Admin
                    will appear here.
                </p>
            </div>

            <% } else { %>

            <table>
                <thead>
                <tr>
                    <th>Case Number</th>
                    <th>Case Title</th>
                    <th>Case Type</th>
                    <th>Filing Date</th>
                    <th>Status</th>
                </tr>
                </thead>

                <tbody>
                <% for (Case courtCase : assignedCases) { %>
                <tr>
                    <td>
                        <c:out value="<%= courtCase.getCaseNumber() %>" />
                    </td>

                    <td>
                        <c:out value="<%= courtCase.getTitle() %>" />
                    </td>

                    <td>
                        <c:out value="<%= courtCase.getCaseType() %>" />
                    </td>

                    <td>
                        <c:out value="<%= courtCase.getFilingDate() %>" />
                    </td>

                    <td>
                            <span class="status">
                                <c:out value="<%= courtCase.getStatus() %>" />
                            </span>
                    </td>
                </tr>
                <% } %>
                </tbody>
            </table>

            <% } %>

        </div>
    </section>

    <!-- Scheduled Hearings -->
    <section class="dashboard-section">

        <h2>📅 Scheduled Hearings</h2>

        <p>
            View hearing dates and details for your assigned cases.
        </p>

        <div class="table-container">

            <table>
                <thead>
                <tr>
                    <th>Case Number</th>
                    <th>Case Title</th>
                    <th>Hearing Date</th>
                    <th>Hearing Time</th>
                    <th>Courtroom</th>
                    <th>Status</th>
                    <th>Notes</th>
                </tr>
                </thead>

                <tbody>

                <c:choose>

                    <c:when test="${empty scheduledHearings}">
                        <tr>
                            <td colspan="7" class="empty-message">
                                No hearings scheduled for your assigned cases.
                            </td>
                        </tr>
                    </c:when>

                    <c:otherwise>

                        <c:forEach var="hearing" items="${scheduledHearings}">
                            <tr>
                                <td>
                                    <c:out value="${hearing.caseNumber}" />
                                </td>

                                <td>
                                    <c:out value="${hearing.caseTitle}" />
                                </td>

                                <td>
                                    <c:out value="${hearing.hearingDate}" />
                                </td>

                                <td>
                                    <c:out value="${hearing.hearingTime}" />
                                </td>

                                <td>
                                    <c:choose>
                                        <c:when test="${empty hearing.courtroom}">
                                            Not specified
                                        </c:when>
                                        <c:otherwise>
                                            <c:out value="${hearing.courtroom}" />
                                        </c:otherwise>
                                    </c:choose>
                                </td>

                                <td>
                                    <span class="hearing-status">
                                        <c:out value="${hearing.status}" />
                                    </span>
                                </td>

                                <td>
                                    <c:choose>
                                        <c:when test="${empty hearing.notes}">
                                            No notes
                                        </c:when>
                                        <c:otherwise>
                                            <c:out value="${hearing.notes}" />
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>

                    </c:otherwise>

                </c:choose>

                </tbody>
            </table>

        </div>
    </section>

</main>

</body>
</html>
