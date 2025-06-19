<%--
  Created by IntelliJ IDEA.
  User: Indu xxx
  Date: 6/16/2025
  Time: 10:05 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Model.Complaint" %>
<%@ page import="java.util.List" %>
<%
    // Session check
    Object userObj = session.getAttribute("currentUser");
    if (userObj == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="styles.css"> <!-- Optional CSS file -->
</head>
<body>

<h2>Admin Dashboard</h2>

<a href="logout.jsp">Logout</a>

<% if (request.getParameter("success") != null) { %>
<p style="color: green;"><%= request.getParameter("success") %></p>
<% } %>
<% if (request.getParameter("error") != null) { %>
<p style="color: red;"><%= request.getParameter("error") %></p>
<% } %>

<table border="1" cellpadding="8" cellspacing="0">
    <thead>
    <tr>
        <th>ID</th>
        <th>User ID</th>
        <th>Title</th>
        <th>Description</th>
        <th>Status</th>
        <th>Remarks</th>
        <th>Actions</th>
    </tr>
    </thead>
    <tbody>
    <%
        List<Complaint> complaints = (List<Complaint>) request.getAttribute("complaints");
        if (complaints != null) {
            for (Complaint complaint : complaints) {
    %>
    <tr>
        <td><%= complaint.getId() %></td>
        <td><%= complaint.getUserId() %></td>
        <td><%= complaint.getTitle() %></td>
        <td><%= complaint.getDescription() %></td>
        <td><%= complaint.getStatus() %></td>
        <td><%= complaint.getRemarks() == null ? "" : complaint.getRemarks() %></td>
        <td>
            <!-- Update form -->
            <form action="admin" method="post" style="display: inline-block; margin-bottom: 5px;">
                <input type="hidden" name="action" value="update">
                <input type="hidden" name="complaintId" value="<%= complaint.getId() %>">
                <label>Status:</label>
                <select name="status" required>
                    <option value="Pending" <%= "Pending".equals(complaint.getStatus()) ? "selected" : "" %>>Pending</option>
                    <option value="In Progress" <%= "In Progress".equals(complaint.getStatus()) ? "selected" : "" %>>In Progress</option>
                    <option value="Resolved" <%= "Resolved".equals(complaint.getStatus()) ? "selected" : "" %>>Resolved</option>
                </select><br>
                <label>Remarks:</label>
                <input type="text" name="remarks" value="<%= complaint.getRemarks() == null ? "" : complaint.getRemarks() %>" required><br>
                <button type="submit">Update</button>
            </form>

            <!-- Delete form -->
            <form action="admin" method="post" style="display: inline-block;">
                <input type="hidden" name="action" value="delete">
                <input type="hidden" name="complaintId" value="<%= complaint.getId() %>">
                <button type="submit" onclick="return confirm('Are you sure you want to delete this complaint?')">Delete</button>
            </form>
        </td>
    </tr>
    <%
        }
    } else {
    %>
    <tr>
        <td colspan="7">No complaints found.</td>
    </tr>
    <% } %>
    </tbody>
</table>

</body>
</html>
