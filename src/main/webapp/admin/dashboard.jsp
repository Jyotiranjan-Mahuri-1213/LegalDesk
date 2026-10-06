<%--
  Created by IntelliJ IDEA.
  User: jyotiranjanmahuri
  Date: 05-10-2026
  Time: 22:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>LegalDesk - Admin Dashboard</title>

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Arial, Helvetica, sans-serif;
        }

        body {
            background: #f4f6f9;
            color: #1f2937;
        }

        /* Sidebar */
        .sidebar {
            position: fixed;
            left: 0;
            top: 0;
            width: 250px;
            height: 100vh;
            background: #172554;
            color: white;
            padding: 25px 18px;
        }

        .logo {
            text-align: center;
            margin-bottom: 40px;
        }

        .logo h1 {
            font-size: 28px;
            letter-spacing: 1px;
        }

        .logo p {
            font-size: 12px;
            color: #bfdbfe;
            margin-top: 5px;
        }

        .menu-title {
            font-size: 11px;
            color: #93c5fd;
            margin: 20px 12px 10px;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .menu a {
            display: block;
            color: #e0e7ff;
            text-decoration: none;
            padding: 13px 15px;
            margin-bottom: 7px;
            border-radius: 8px;
            transition: 0.3s;
        }

        .menu a:hover,
        .menu a.active {
            background: #2563eb;
            color: white;
        }

        .logout {
            position: absolute;
            bottom: 25px;
            left: 18px;
            right: 18px;
        }

        .logout a {
            display: block;
            text-align: center;
            padding: 12px;
            border: 1px solid #60a5fa;
            border-radius: 8px;
            color: white;
            text-decoration: none;
        }

        .logout a:hover {
            background: #dc2626;
            border-color: #dc2626;
        }

        /* Main */
        .main {
            margin-left: 250px;
            min-height: 100vh;
        }

        /* Topbar */
        .topbar {
            height: 75px;
            background: white;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 35px;
            border-bottom: 1px solid #e5e7eb;
        }

        .topbar h2 {
            font-size: 22px;
            color: #172554;
        }

        .admin-profile {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: #2563eb;
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
        }

        .admin-info strong {
            display: block;
            font-size: 14px;
        }

        .admin-info span {
            font-size: 12px;
            color: #6b7280;
        }

        /* Content */
        .content {
            padding: 35px;
        }

        .welcome {
            margin-bottom: 30px;
        }

        .welcome h1 {
            font-size: 30px;
            color: #111827;
            margin-bottom: 8px;
        }

        .welcome p {
            color: #6b7280;
        }

        /* Statistics */
        .stats {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
            margin-bottom: 30px;
        }

        .stat-card {
            background: white;
            padding: 22px;
            border-radius: 12px;
            border: 1px solid #e5e7eb;
            box-shadow: 0 3px 10px rgba(0, 0, 0, 0.04);
        }

        .stat-card p {
            color: #6b7280;
            font-size: 14px;
            margin-bottom: 10px;
        }

        .stat-card h2 {
            font-size: 28px;
            color: #172554;
        }

        .stat-card span {
            font-size: 12px;
            color: #16a34a;
        }

        /* Feature cards */
        .section-title {
            margin-bottom: 18px;
            color: #172554;
        }

        .features {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
        }

        .feature-card {
            background: white;
            padding: 25px;
            border-radius: 12px;
            border: 1px solid #e5e7eb;
            transition: 0.3s;
            cursor: pointer;
        }

        .feature-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.08);
        }

        .icon {
            width: 48px;
            height: 48px;
            border-radius: 10px;
            background: #dbeafe;
            color: #2563eb;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 22px;
            margin-bottom: 18px;
        }

        .feature-card h3 {
            margin-bottom: 8px;
            color: #172554;
        }

        .feature-card p {
            color: #6b7280;
            font-size: 14px;
            line-height: 1.5;
        }

        .feature-card a {
            display: inline-block;
            margin-top: 15px;
            color: #2563eb;
            text-decoration: none;
            font-size: 14px;
            font-weight: bold;
        }

        /* Responsive */
        @media (max-width: 1000px) {
            .stats {
                grid-template-columns: repeat(2, 1fr);
            }

            .features {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 700px) {
            .sidebar {
                width: 70px;
                padding: 20px 8px;
            }

            .logo h1 {
                font-size: 16px;
            }

            .logo p,
            .menu-title,
            .menu a span {
                display: none;
            }

            .menu a {
                text-align: center;
                font-size: 18px;
            }

            .main {
                margin-left: 70px;
            }

            .stats,
            .features {
                grid-template-columns: 1fr;
            }

            .content {
                padding: 20px;
            }
        }
    </style>


</head>

<body>

<!-- Sidebar -->

<div class="sidebar">
    <div class="logo">
        <h1>LegalDesk</h1>
        <p>Legal Case Management</p>
    </div>

    <div class="menu-title">Main Menu</div>

    <div class="menu">
        <a href="#" class="active">▣ <span>Dashboard</span></a>
        <a href="#">⚖ <span>Lawyer Verification</span></a>
        <a href="#">👥 <span>User Management</span></a>
        <a href="#">📁 <span>Case Management</span></a>
        <a href="#">📅 <span>Hearings</span></a>
        <a href="#">🔔 <span>Notifications</span></a>
        <a href="#">📊 <span>Reports</span></a>
    </div>

    <div class="logout">
        <a href="../logout">Logout</a>
    </div>
    ```

</div>

<!-- Main Content -->

<div class="main">

    ```
    <!-- Top Bar -->
    <div class="topbar">

        <h2>Admin Dashboard</h2>

        <div class="admin-profile">
            <div class="avatar">A</div>

            <div class="admin-info">
                <strong>System Admin</strong>
                <span>Administrator</span>
            </div>
        </div>

    </div>


    <!-- Content -->
    <div class="content">

        <div class="welcome">
            <h1>Welcome back, Admin 👋</h1>
            <p>Manage users, lawyers, cases and hearings from your LegalDesk control panel.</p>
        </div>


        <!-- Statistics -->
        <div class="stats">

            <div class="stat-card">
                <p>Total Users</p>
                <h2>${totalUsers}</h2>
                <span>System users</span>
            </div>

            <div class="stat-card">
                <p>Pending Lawyers</p>
                <h2>${pendingLawyers}</h2>
                <span>Awaiting verification</span>
            </div>

            <div class="stat-card">
                <p>Total Cases</p>
                <h2>0</h2>
                <span>Registered cases</span>
            </div>

            <div class="stat-card">
                <p>Upcoming Hearings</p>
                <h2>0</h2>
                <span>Scheduled hearings</span>
            </div>

        </div>


        <!-- Management -->
        <h2 class="section-title">Management</h2>

        <div class="features">

            <div class="feature-card">
                <div class="icon">⚖</div>
                <h3>Lawyer Verification</h3>
                <p>Review and manage lawyer registration requests waiting for Admin approval.</p>
                <a href="#">Manage →</a>
            </div>

            <div class="feature-card">
                <div class="icon">👥</div>
                <h3>User Management</h3>
                <p>View and manage registered lawyers, litigants and other system users.</p>
                <a href="#">Manage →</a>
            </div>

            <div class="feature-card">
                <div class="icon">📁</div>
                <h3>Case Management</h3>
                <p>Monitor registered cases and manage case-related information.</p>
                <a href="#">Manage →</a>
            </div>

            <div class="feature-card">
                <div class="icon">📅</div>
                <h3>Hearing Management</h3>
                <p>View scheduled hearings and manage court hearing information.</p>
                <a href="#">Manage →</a>
            </div>

            <div class="feature-card">
                <div class="icon">🔔</div>
                <h3>Notifications</h3>
                <p>Monitor important notifications and hearing reminders generated by the system.</p>
                <a href="#">View →</a>
            </div>

            <div class="feature-card">
                <div class="icon">📊</div>
                <h3>Reports</h3>
                <p>Generate reports related to users, cases, hearings and system activity.</p>
                <a href="#">View Reports →</a>
            </div>

        </div>

    </div>


</div>

</body>
</html>
