<%--
  Created by IntelliJ IDEA.
  User: jyotiranjanmahuri
  Date: 23-10-2026
  Time: 13:41
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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

        .container {
            max-width: 1100px;
            margin: 40px auto;
            padding: 20px;
        }

        .welcome {
            margin-bottom: 30px;
        }

        .welcome h2 {
            color: #14532d;
            margin-bottom: 10px;
        }

        .cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 20px;
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
    </style>
</head>

<body>
<header class="navbar">
    <div class="brand">LEGALDESK | LAWYER</div>
    <a class="logout"
       href="${pageContext.request.contextPath}/logout">Logout</a>
</header>

<main class="container">
    <section class="welcome">
        <h2>
            Welcome, <%= session.getAttribute("userName") %>!
        </h2>
        <p>Manage your legal cases and hearing schedules.</p>
        <p>
            Role:
            <strong><%= session.getAttribute("userRole") %></strong>
        </p>
    </section>

    <section class="cards">
        <div class="card">
            <h3>My Cases</h3>
            <p>View and track cases assigned to you.</p>
        </div>

        <div class="card">
            <h3>Hearing Schedule</h3>
            <p>Review upcoming hearing dates.</p>
        </div>

        <div class="card">
            <h3>Notifications</h3>
            <p>Check case updates and hearing notifications.</p>
        </div>

        <div class="card">
            <h3>Profile</h3>
            <p>View your lawyer account information.</p>
        </div>
    </section>
</main>
</body>
</html>
