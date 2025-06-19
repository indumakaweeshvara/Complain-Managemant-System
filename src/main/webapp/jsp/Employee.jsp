<%--
  Created by IntelliJ IDEA.
  User: Indu xxx
  Date: 6/16/2025
  Time: 8:51 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.util.List" %>
<%@ page import="Model.Complaint" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  HttpSession session = request.getSession(false);
  if (session == null || session.getAttribute("user") == null) {
    response.sendRedirect("login.jsp?error=Please login first");
    return;
  }
  // Assuming you have set the username in the session
  String username = (String) session.getAttribute("username");
%>
<!DOCTYPE html>
<html>
<head>
  <title>Employee Dashboard - Complaint Management System</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      background-color: #f1f1f1;
      padding: 20px;
    }
    .dashboard {
      max-width: 900px;
      margin: auto;
      background-color: white;
      padding: 30px;
      border-radius: 10px;
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
    }
    table {
      width: 100%;
      border-collapse: collapse;
      margin-top: 20px;
    }
    th, td {
      border: 1px solid #ddd;
      padding: 12px;
      text-align: left;
    }
    th {
      background-color: #4CAF50;
      color: white;
    }
    button {
      padding: 6px 12px;
      border: none;
      border-radius: 5px;
      cursor: pointer;
      color: white;
    }
    .edit-btn { background-color: #ffc107; }
    .delete-btn { background-color: #f44336; }
  </style>
</head>
<body>
<div class="dashboard">
  <h2>Welcome, <%= username %></h2>
  <h3>Submit a New Complaint</h3>
  <form action="employee" method="post">
    <label>Complaint Title:</label><br>
    <input type="text" name="title" required style="width: 100%; padding: 8px;"><br><br>
    <label>Complaint Description:</label><br>
    <textarea name="description" rows="4" required style="width: 100%; padding: 8px;"></textarea><br><br>
    <input type="hidden" name="action" value="create">
    <button type="submit" style="background-color: #4CAF50;">Submit Complaint</button>
  </form>

  <h3>Your Complaints</h3>
  <table>
    <tr>
      <th>ID</th>
      <th>Title</th>
      <th>Description</th>
      <th>Status</th>
      <th>Actions</th>
    </tr>

    <%-- Assuming you set a List<Complaint> as a request attribute from your servlet --%>
    <%
      List<Complaint> complaintList = (List<Complaint>) request.getAttribute("complaints");
      if (complaintList != null && !complaintList.isEmpty()) {
        for (Complaint complaint : complaintList) {
    %>
    <tr>
      <td><%= complaint.getId() %></td>
      <td><%= complaint.getTitle() %></td>
      <td><%= complaint.getDescription() %></td>
      <td><%= complaint.getStatus() %></td>
      <td>
        <% if (!"Resolved".equalsIgnoreCase(complaint.getStatus())) { %>
        <!-- Edit Form -->
        <form action="employee" method="post" style="display: inline;">
          <input type="hidden" name="action" value="edit">
          <input type="hidden" name="complaintId" value="<%= complaint.getId() %>">
          <button type="submit" class="edit-btn">Edit</button>
        </form>

        <!-- Delete Form -->
        <form action="employee" method="post" style="display: inline;">
          <input type="hidden" name="action" value="delete">
          <input type="hidden" name="complaintId" value="<%= complaint.getId() %>">
          <button type="submit" class="delete-btn">Delete</button>
        </form>
        <% } else { %>
        <span style="color: gray;">No Actions</span>
        <% } %>
      </td>
    </tr>
    <%
      }
    } else {
    %>
    <tr>
      <td colspan="5" style="text-align: center;">No complaints submitted yet.</td>
    </tr>
    <%
      }
    %>
  </table>

  <br><br>
  <form action="logout" method="post">
    <button type="submit" style="background-color: #555;">Logout</button>
  </form>
</div>
</body>
</html>