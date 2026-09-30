<%--
  Created by IntelliJ IDEA.
  User: jyotiranjanmahuri
  Date: 30-09-2026
  Time: 19:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>LegalDesk - Registration</title>
</head>

<body>

<h1>LegalDesk</h1>
<h2>Create Account</h2>

<%
    String error = request.getParameter("error");

    if ("failed".equals(error)) {
%>

<p>Registration failed. Please try again.</p>

<%
    }
%>

<form action="register" method="post">

    <label>Full Name:</label>
    <br>
    <input type="text" name="fullName" required>
    <br><br>

    <label>Email:</label>
    <br>
    <input type="email" name="email" required>
    <br><br>

    <label>Password:</label>
    <br>
    <input type="password" name="password" required>
    <br><br>

    <label>Mobile Number:</label>
    <br>
    <input type="text" name="mobileNo" required>
    <br><br>

    <label>Role:</label>
    <br>
    <select name="role" required>

        <option value="">Select Role</option>
        <option value="LAWYER">Lawyer</option>
        <option value="LITIGANT">Litigant</option>

    </select>

    <br><br>

    <button type="submit">Register</button>

</form>

<br>

<p>
    Already have an account?
    <a href="login.jsp">Login</a>
</p>

</body>
</html>