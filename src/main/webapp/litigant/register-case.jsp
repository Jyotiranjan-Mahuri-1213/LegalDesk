<%--
  Created by IntelliJ IDEA.
  User: jyotiranjanmahuri
  Date: 23-10-2026
  Time: 20:44
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    if (session.getAttribute("loggedInUser") == null
            || !"LITIGANT".equals(session.getAttribute("userRole"))) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>LegalDesk | Register Case</title>

    <style>
        * {
            box-sizing: border-box;
            font-family: Arial, sans-serif;
        }

        body {
            margin: 0;
            padding: 30px 15px;
            background: #f1f5f9;
            color: #1e293b;
        }

        .container {
            max-width: 650px;
            margin: 25px auto;
            padding: 30px;
            background: white;
            border-radius: 12px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.07);
        }

        h2 {
            margin-top: 0;
            color: #1e3a8a;
        }

        label {
            display: block;
            margin: 18px 0 7px;
            font-weight: bold;
        }

        input, select, textarea {
            width: 100%;
            padding: 12px;
            border: 1px solid #cbd5e1;
            border-radius: 6px;
            font-size: 15px;
        }

        textarea {
            min-height: 120px;
            resize: vertical;
        }

        button {
            margin-top: 22px;
            padding: 12px 20px;
            border: none;
            border-radius: 6px;
            background: #1d4ed8;
            color: white;
            font-size: 15px;
            cursor: pointer;
        }

        button:hover {
            background: #1e40af;
        }

        .back {
            display: inline-block;
            margin-top: 20px;
            color: #1d4ed8;
            text-decoration: none;
        }
    </style>
</head>

<body>
<main class="container">
    <h2>Register a Court Case</h2>
    <p>Enter the details of your case below.</p>

    <form action="${pageContext.request.contextPath}/cases/create"
          method="post">

        <label for="title">Case Title *</label>
        <input type="text" id="title" name="title"
               maxlength="200" required>

        <label for="caseType">Case Type *</label>
        <select id="caseType" name="caseType" required>
            <option value="">Select case type</option>
            <option value="Civil">Civil</option>
            <option value="Criminal">Criminal</option>
            <option value="Family">Family</option>
            <option value="Property">Property</option>
            <option value="Consumer">Consumer</option>
            <option value="Other">Other</option>
        </select>

        <label for="description">Case Description</label>
        <textarea id="description" name="description"
                  placeholder="Describe your case..."></textarea>

        <button type="submit">Submit Case</button>
    </form>

    <a class="back"
       href="${pageContext.request.contextPath}/litigant/dashboard">
        Back to Dashboard
    </a>
</main>
</body>
</html>
