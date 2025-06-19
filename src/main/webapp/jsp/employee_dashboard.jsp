<%--
  Created by IntelliJ IDEA.
  User: Indu xxx
  Date: 6/16/2025
  Time: 8:56 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.util.List" %>
<%@ page import="Model.Complaint" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
  // Session validation
  if (session == null || session.getAttribute("username") == null) {
    response.sendRedirect("login.jsp?error=Please login first");
    return;
  }

  String username = (String) session.getAttribute("username");
  List<Complaint> complaints = (List<Complaint>) request.getAttribute("complaints");
%>

<!DOCTYPE html>
<html>
<head>
  <title>Employee Dashboard</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      background-color: #f1f1f1;
      padding: 20px;
    }
    .container {
      max-width: 900px;
      margin: auto;
      background-color: white;
      padding: 30px;
      border-radius: 10px;
      box-shadow: 0 0 10px rgba(0,0,0,0.2);
    }
    h2 {
      text-align: center;
    }
    form {
      margin-bottom: 30px;
    }
    input, textarea, button {
      width: 100%;
      padding: 10px;
      margin-top: 10px;
      border-radius: 5px;
      border: 1px solid #ccc;
    }
    button {
      background-color: #4CAF50;
      color: white;
      border: none;
      cursor: pointer;
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
    .action-btn {
      padding: 5px 10px;
      border: none;
      border-radius: 5px;
      cursor: pointer;
      color: white;
    }
    .edit-btn {
      background-color: #ffc107;
    }
    .delete-btn {
      background-color: #f44336;
    }
    .logout-btn {
      background-color: #555;
      padding: 10px 20px;
      margin-top: 20px;
      display: inline-block;
    }
  </style>
</head>
<body>

<div class="container">
  <h2>Welcome, <%= username %></h2>

  <!-- New Complaint Form -->
  <h3>Submit New Complaint</h3>
  <form action="employee" method="post">
    <label for="title">Title:</label>
    <input type="text" name="title" id="title" required>

    <label for="description">Description:</label>
    <textarea name="description" id="description" rows="4" required></textarea>

    <input type="hidden" name="action" value="create">

    <button type="submit">Submit Complaint</button>
  </form>

  <!-- Complaints List -->
  <h3>Your Complaints</h3>
  <table>
    <tr>
      <th>ID</th>
      <th>Title</th>
      <th>Description</th>
      <th>Status</th>
      <th>Actions</th>
    </tr>

    <%
      if (complaints != null && !complaints.isEmpty()) {
        for (Complaint complaint : complaints) {
    %>
    <tr>
      <td><%= complaint.getId() %></td>
      <td><%= complaint.getTitle() %></td>
      <td><%= complaint.getDescription() %></td>
      <td><%= complaint.getStatus() %></td>
      <td>
        <% if (!"Resolved".equalsIgnoreCase(complaint.getStatus())) { %>
        <!-- Edit Button -->
        <form action="employee" method="post" style="display: inline;">
          <input type="hidden" name="action" value="edit">
          <input type="hidden" name="complaintId" value="<%= complaint.getId() %>">
          <button type="submit" class="action-btn edit-btn">Edit</button>
        </form>

        <!-- Delete Button -->
        <form action="employee" method="post" style="display: inline;">
          <input type="hidden" name="action" value="delete">
          <input type="hidden" name="complaintId" value="<%= complaint.getId() %>">
          <button type="submit" class="action-btn delete-btn">Delete</button>
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

  <!-- Logout Button -->
  <form action="logout" method="post">
    <button type="submit" class="logout-btn">Logout</button>
  </form>

</div>

</body>
</html>