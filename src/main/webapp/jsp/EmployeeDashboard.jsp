
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String error = (String) request.getSession().getAttribute("error");
    if (error != null) {
%>
<div class="alert alert-danger"><%= error %></div>
<%
        request.getSession().removeAttribute("error");
    }

    String msg = (String) request.getSession().getAttribute("msg");
    if (msg != null) {
%>
<div class="alert alert-success"><%= msg %></div>
<%
        request.getSession().removeAttribute("msg");
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Employee Dashboard</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/employeeDashboard.css">
</head>
<body>

<div class="d-flex" id="wrapper">
    <!-- Sidebar -->
    <!-- Sidebar -->
    <div class="sidebar" id="sidebar-wrapper">
        <div class="sidebar-heading">CMS Portal</div>
        <div class="list-group list-group-flush">
            <a href="#" class="list-group-item list-group-item-action">
                <i class="bi bi-speedometer2"></i> Dashboard
            </a>
            <a href="#" class="list-group-item list-group-item-action">
                <i class="bi bi-file-earmark-text"></i> My Complaints
            </a>
            <a href="#" class="list-group-item list-group-item-action">
                <i class="bi bi-person-circle"></i> Profile
            </a>
            <a href="${pageContext.request.contextPath}/index.jsp" class="list-group-item list-group-item-action">
                <i class="bi bi-box-arrow-right"></i> Logout
            </a>
        </div>
    </div>
    <!-- Page Content -->
    <div id="page-content-wrapper" class="w-100">
        <nav class="navbar navbar-expand-lg navbar-dark dashboard-navbar">
            <div class="container-fluid">
                <span class="navbar-brand">My Complaints Dashboard</span>
                <button class="btn btn-light btn-sm" onclick="location.href='${pageContext.request.contextPath}/index.jsp'">Logout</button>
            </div>
        </nav>

        <div class="container-fluid px-4 py-3">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <p class="text-muted">Track and manage your submitted complaints</p>
                <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#newComplaintModal">
                    <i class="bi bi-plus-circle me-1"></i> Submit New Complaint
                </button>
            </div>

            <div class="card">
                <div class="card-body">
                    <table class="table table-hover" id="complaintsTable">
                        <thead>
                        <tr>
                            <th>ID</th>
                            <th>Subject</th>
                            <th>Description</th>
                            <th>Date</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                        </thead>
                        <tbody>
                        <%
                            java.util.List<Dto.Complaints> userComplaints =
                                    (java.util.List<Dto.Complaints>) request.getAttribute("userComplaints");
                            if (userComplaints != null && !userComplaints.isEmpty()) {
                                for (Dto.Complaints complaint : userComplaints) {
                        %>
                        <tr>
                            <td><%= complaint.getId() %></td>
                            <td><%= complaint.getSubject() %></td>
                            <td><%= complaint.getDescription() %></td>
                            <td><%= complaint.getDate_submitted() %></td>
                            <td>
                                <span class="badge <%= complaint.getStatus().equals("Pending") ? "bg-warning" :
                                    complaint.getStatus().equals("In Progress") ? "bg-info" :
                                    complaint.getStatus().equals("Resolved") ? "bg-success" : "bg-danger" %>">
                                    <%= complaint.getStatus() %>
                                </span>
                            </td>
                            <td>
                                <% if (!"Resolved".equals(complaint.getStatus()) && !"Rejected".equals(complaint.getStatus())) { %>
                                <a href="${pageContext.request.contextPath}/employee/editComplaintForm?complaintId=<%= complaint.getId() %>"
                                   class="btn btn-sm btn-warning" title="Edit">
                                    <i class="bi bi-pencil"></i>
                                </a>
                                <form action="${pageContext.request.contextPath}/employee/deleteComplaint" method="post" style="display:inline;" onsubmit="return confirm('Are you sure you want to delete this complaint?');">
                                    <input type="hidden" name="complaintId" value="<%= complaint.getId() %>">
                                    <button type="submit" class="btn btn-sm btn-danger" title="Delete">
                                        <i class="bi bi-trash"></i>
                                    </button>
                                </form>
                                <% } else { %>
                                <span class="text-muted">No actions</span>
                                <% } %>
                            </td>
                        </tr>
                        <%

                            }
                        } else {
                        %>
                        <tr><td colspan="6" class="text-center">No complaints found</td></tr>
                        <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Modal -->
<div class="modal fade" id="newComplaintModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Submit New Complaint</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="${pageContext.request.contextPath}/employee/submitComplaint" method="post">
                <div class="modal-body">
                    <div class="mb-3">
                        <label for="subject" class="form-label">Subject *</label>
                        <input type="text" class="form-control" id="subject" name="subject" required maxlength="100" placeholder="Enter complaint subject">
                    </div>
                    <div class="mb-3">
                        <label for="description" class="form-label">Description *</label>
                        <textarea class="form-control" id="description" name="description" rows="5" required maxlength="500" placeholder="Describe your complaint in detail"></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary">Submit Complaint</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>