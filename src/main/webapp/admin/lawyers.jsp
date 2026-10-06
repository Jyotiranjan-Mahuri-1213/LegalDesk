<%--
  Created by IntelliJ IDEA.
  User: jyotiranjanmahuri
  Date: 06-10-2026
  Time: 13:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.court.entity.User" %>

<!DOCTYPE html>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>LegalDesk - Lawyer Verification</title>

    <style>
        * {
            box-sizing: border-box;
            font-family: Arial, Helvetica, sans-serif;
        }

        body {
            margin: 0;
            background: #f4f6f9;
            color: #1f2937;
        }

        .header {
            background: #172554;
            color: white;
            padding: 20px 35px;
        }

        .header h1 {
            margin: 0;
            font-size: 26px;
        }

        .header p {
            margin: 5px 0 0;
            color: #bfdbfe;
        }

        .content {
            padding: 35px;
        }

        .back {
            display: inline-block;
            margin-bottom: 20px;
            color: #2563eb;
            text-decoration: none;
            font-weight: bold;
        }

        .card {
            background: white;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 3px 12px rgba(0,0,0,0.06);
        }

        .card h2 {
            margin-top: 0;
            color: #172554;
        }

        .description {
            color: #6b7280;
            margin-bottom: 25px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th {
            background: #eff6ff;
            color: #172554;
            padding: 14px;
            text-align: left;
            font-size: 14px;
        }

        td {
            padding: 14px;
            border-bottom: 1px solid #e5e7eb;
            font-size: 14px;
        }

        tr:hover {
            background: #f9fafb;
        }

        .status {
            display: inline-block;
            padding: 6px 10px;
            border-radius: 20px;
            background: #fef3c7;
            color: #92400e;
            font-size: 12px;
            font-weight: bold;
        }

        .empty {
            text-align: center;
            padding: 40px;
            color: #6b7280;
        }

        .count {
            display: inline-block;
            margin-left: 10px;
            background: #2563eb;
            color: white;
            padding: 4px 9px;
            border-radius: 15px;
            font-size: 12px;
        }
        .action-form {
            display: flex;
            gap: 8px;
        }

        .action-btn {
            border: none;
            padding: 8px 14px;
            border-radius: 6px;
            font-size: 13px;
            font-weight: bold;
            cursor: pointer;
            transition: 0.2s;
        }

        .approve-btn {
            background: #16a34a;
            color: white;
        }

        .approve-btn:hover {
            background: #15803d;
        }

        .reject-btn {
            background: #dc2626;
            color: white;
        }

        .reject-btn:hover {
            background: #b91c1c;
        }

        @media (max-width: 800px) {
            .content {
                padding: 20px;
                overflow-x: auto;
            }

            table {
                min-width: 750px;
            }

        }
    </style>

</head>

<body>

<div class="header">
    <h1>LegalDesk</h1>
    <p>Lawyer Verification Management</p>
</div>

<div class="content">

    <a class="back" href="dashboard">← Back to Dashboard</a>

    <div class="card">

        <h2>
            Pending Lawyer Verification
            <%
                List<User> pendingLawyers =
                        (List<User>) request.getAttribute("pendingLawyers");

                int count = pendingLawyers != null
                        ? pendingLawyers.size()
                        : 0;
            %>

            <span class="count"><%= count %></span>
        </h2>

        <p class="description">
            Review lawyer registration requests that are waiting for
            administrator verification.
        </p>

        <% if (pendingLawyers != null && !pendingLawyers.isEmpty()) { %>

        <table>

            <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Email</th>
                <th>Mobile</th>
                <th>Status</th>
                <th>Actions</th>
            </tr>
            </thead>

            <tbody>

            <% for (User lawyer : pendingLawyers) { %>

            <tr>
                <td><%= lawyer.getId() %></td>
                <td><%= lawyer.getName() %></td>
                <td><%= lawyer.getEmail() %></td>
                <td><%= lawyer.getMobileNo() %></td>

                <td>
                <span class="status">
                    <%= lawyer.getVerificationStatus() %>
                </span>
                </td>
                <td>
                    <form class="action-form"
                          action="<%= request.getContextPath() %>/admin/lawyer-action"
                          method="post">

                        <input type="hidden"
                               name="userId"
                               value="<%= lawyer.getId() %>">

                        <button type="submit"
                                name="action"
                                value="approve"
                                class="action-btn approve-btn">
                            Approve
                        </button>

                        <button type="submit"
                                name="action"
                                value="reject"
                                class="action-btn reject-btn">
                            Reject
                        </button>

                    </form>
                </td>
            </tr>

            <% } %>

            </tbody>

        </table>

        <% } else { %>

        <div class="empty">
            <h3>No Pending Lawyers</h3>
            <p>There are currently no lawyer registrations waiting for verification.</p>
        </div>

        <% } %>

    </div>

</div>

</body>
</html>
