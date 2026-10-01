<%--
  Created by IntelliJ IDEA.
  User: jyotiranjanmahuri
  Date: 01-10-2026
  Time: 20:55
  To change this template use File | Settings | File Templates.
--%>
```jsp
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>LegalDesk | Dashboard</title>

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
            background: #172554;
            color: white;
            padding: 18px 35px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .brand {
            font-size: 21px;
            font-weight: bold;
            letter-spacing: 1px;
        }

        .logout {
            background: #dc2626;
            color: white;
            padding: 9px 16px;
            text-decoration: none;
            border-radius: 5px;
            font-size: 14px;
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
            color: #172554;
            margin-bottom: 8px;
        }

        .welcome p {
            color: #64748b;
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
            border-left: 4px solid #2563eb;
        }

        .card h3 {
            color: #1e3a8a;
            margin-bottom: 12px;
        }

        .card p {
            color: #64748b;
            font-size: 14px;
            line-height: 1.6;
        }

        footer {
            text-align: center;
            padding: 25px;
            color: #94a3b8;
            font-size: 13px;
        }
    </style>
</head>

<body>

<header class="navbar">
    <div class="brand">LEGALDESK</div>
    <a class="logout" href="logout">Logout</a>
</header>

<main class="container">

    <section class="welcome">
        <h2>Welcome to LegalDesk</h2>
        <p>Court Case Scheduling and Hearing Notification System</p>
    </section>

    <section class="cards">

        <div class="card">
            <h3>Case Management</h3>
            <p>View and manage court case information.</p>
        </div>

        <div class="card">
            <h3>Hearing Schedule</h3>
            <p>View upcoming court hearing dates and schedules.</p>
        </div>

        <div class="card">
            <h3>Notifications</h3>
            <p>Stay informed about hearing dates and case updates.</p>
        </div>

        <div class="card">
            <h3>Reports</h3>
            <p>Access case-related reports and information.</p>
        </div>

    </section>

</main>

<footer>
    © 2026 LegalDesk | Court Case Scheduling System
</footer>

</body>
</html>
```
