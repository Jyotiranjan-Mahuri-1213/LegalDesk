<%--
  Created by IntelliJ IDEA.
  User: jyotiranjanmahuri
  Date: 01-10-2026
  Time: 20:53
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>LegalDesk- Login</title>

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Arial, sans-serif;
        }

        body {
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            background: #f1f5f9;
        }

        .login-container {
            width: 100%;
            max-width: 420px;
            padding: 35px;
            background: white;
            border-radius: 12px;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.08);
        }

        h2 {
            text-align: center;
            color: #172554;
            margin-bottom: 10px;
        }

        .subtitle {
            text-align: center;
            color: #64748b;
            margin-bottom: 25px;
            font-size: 14px;
        }

        label {
            display: block;
            margin-bottom: 7px;
            color: #334155;
            font-weight: bold;
            font-size: 14px;
        }

        input {
            width: 100%;
            padding: 12px;
            margin-bottom: 18px;
            border: 1px solid #cbd5e1;
            border-radius: 6px;
            font-size: 14px;
        }

        input:focus {
            outline: none;
            border-color: #2563eb;
        }

        button {
            width: 100%;
            padding: 12px;
            background: #1e3a8a;
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 15px;
            cursor: pointer;
        }

        button:hover {
            background: #1d4ed8;
        }

        .message {
            text-align: center;
            font-size: 13px;
            margin-bottom: 15px;
        }

        .success {
            color: #15803d;
        }

        .error {
            color: #dc2626;
        }

        .register-link {
            text-align: center;
            margin-top: 20px;
            font-size: 14px;
            color: #64748b;
        }

        a {
            color: #2563eb;
            text-decoration: none;
        }

        .brand {
            text-align: center;
            color: #1e3a8a;
            font-size: 13px;
            margin-bottom: 20px;
            font-weight: bold;
            letter-spacing: 1px;
        }
    </style>
</head>

<body>

<div class="login-container">

    <div class="brand">LEGALDESK</div>

    <h2>Welcome Back</h2>

    <p class="subtitle">Login to your LegalDesk account</p>

    <% if ("true".equals(request.getParameter("registered"))) { %>
    <p class="message success">
        Registration successful. Please login.
    </p>
    <% } %>

    <% if ("failed".equals(request.getParameter("error"))) { %>
    <p class="message error">
        Invalid email or password.
    </p>
    <% } %>

    <form action="login" method="post">

        <label for="email">Email Address</label>
        <input
                type="email"
                id="email"
                name="email"
                placeholder="Enter your email"
                required
        >

        <label for="password">Password</label>
        <input
                type="password"
                id="password"
                name="password"
                placeholder="Enter your password"
                required
        >

        <button type="submit">Login</button>



    </form>

    <div class="register-link">
        Don't have an account?
        <a href="register.jsp">Register here</a>
    </div>
</div>

</body>
</html>
