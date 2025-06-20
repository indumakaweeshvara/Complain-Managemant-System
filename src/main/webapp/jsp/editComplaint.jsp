
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Dto.Complaints" %>

<%
    Complaints complaint = (Complaints) request.getAttribute("complaint");
    if (complaint == null) {
        response.sendRedirect(request.getContextPath() + "/employee");
        return;
    }

    // Get error message from request attribute, not session
    String error = (String) request.getAttribute("error");
%>


<!DOCTYPE html>
<html>
<head>
    <title>Edit Complaint</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/editComplaint.css">
</head>
<body>
<div class="container mt-5">
    <h2>Edit Complaint</h2>

    <% if (error != null) { %>
    <div class="alert alert-danger"><%= error %></div>
    <% } %>

    <form action="<%= request.getContextPath() %>/employee/updateComplaint" method="post">
        <input type="hidden" name="complaintId" value="<%= complaint.getId() %>">

        <div class="mb-3">
            <label for="subject" class="form-label">Subject</label>
            <input type="text" class="form-control" id="subject" name="subject" value="<%= complaint.getSubject() %>" required>
        </div>

        <div class="mb-3">
            <label for="description" class="form-label">Description</label>
            <textarea class="form-control" id="description" name="description" rows="5" required><%= complaint.getDescription() %></textarea>
        </div>

        <button type="submit" class="btn btn-primary">Update Complaint</button>
        <a href="<%= request.getContextPath() %>/employee" class="btn btn-secondary ms-2">Cancel</a>
    </form>
</div>
</body>
</html>
