<%--
  Created by IntelliJ IDEA.
  User: Indu xxx
  Date: 6/16/2025
  Time: 8:44 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <title>Sign Up - Complaint Management System</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      background-color: #f1f1f1;
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
    }
    .signup-form {
      background-color: white;
      padding: 30px;
      border-radius: 10px;
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
      width: 350px;
    }
    .signup-form h2 {
      text-align: center;
      margin-bottom: 20px;
    }
    .signup-form input, .signup-form select {
      width: 100%;
      padding: 10px;
      margin: 10px 0;
      border: 1px solid #ccc;
      border-radius: 5px;
    }
    .signup-form button {
      width: 100%;
      padding: 10px;
      background-color: #4CAF50;
      border: none;
      color: white;
      border-radius: 5px;
      cursor: pointer;
    }
    .error {
      color: red;
      text-align: center;
      margin-bottom: 10px;
    }
    .message {
      color: green;
      text-align: center;
      margin-bottom: 10px;
    }
  </style>
</head>
<body>
<div class="signup-form">
  <h2>Sign Up</h2>

  <!-- Display error or success messages -->
  <%
    String error = request.getParameter("error");
    String message = request.getParameter("message");
    if (error != null) {
  %>
  <div class="error"><%= error %></div>
  <% } else if (message != null) { %>
  <div class="message"><%= message %></div>
  <% } %>

  <form action="signup" method="post">
    <input type="text" name="username" placeholder="Username" required />
    <input type="password" name="password" placeholder="Password" required />

    <!-- Role Selection -->
    <select name="role" required>
      <option value="">Select Role</option>
      <option value="Employee">Employee</option>
      <option value="Admin">Admin</option>
    </select>

    <button type="submit">Sign Up</button>
  </form>

  <p style="text-align: center; margin-top: 15px;">
    Already have an account? <a href="login.jsp">Login</a>
  </p>
</div>
</body>
</html>