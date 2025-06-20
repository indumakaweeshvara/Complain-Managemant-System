<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>--%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard - Complaints Management</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/adminDashboard.css">
    <style>
        .sidebar {
            min-width: 240px;
            max-width: 240px;
            min-height: 100vh;
            background: linear-gradient(145deg, #202C4C, #2c5364);
            color: #fff;
            display: flex;
            flex-direction: column;
            box-shadow: 4px 0 20px rgba(0, 0, 0, 0.1);
            position: fixed;
            left: 0;
            top: 0;
            z-index: 1000;
        }

        .sidebar-heading {
            font-size: 20px;
            font-weight: 600;
            padding: 20px;
            background-color: rgba(255, 255, 255, 0.05);
            text-align: center;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }

        .sidebar .list-group {
            flex-grow: 1;
            padding: 10px 0;
        }

        .sidebar .list-group-item {
            color: #e0e0e0;
            background: transparent;
            border: none;
            padding: 12px 20px;
            font-weight: 500;
            font-size: 15px;
            display: flex;
            align-items: center;
            transition: all 0.3s ease;
        }

        .sidebar .list-group-item i {
            margin-right: 12px;
            font-size: 18px;
        }

        .sidebar .list-group-item:hover {
            background: rgba(255, 255, 255, 0.08);
            color: #ffffff;
            transform: translateX(3px);
        }

        .sidebar .list-group-item.active {
            background-color: rgba(255, 255, 255, 0.15);
            color: #fff;
            font-weight: 600;
        }

        #page-content-wrapper {
            margin-left: 240px;
            flex: 1;
            padding: 0;
            background: #f8f9fa;
            min-height: 100vh;
        }

        @media (max-width: 768px) {
            .sidebar {
                position: absolute;
                transform: translateX(-100%);
                transition: transform 0.3s ease;
            }

            .sidebar.show {
                transform: translateX(0);
            }

            #page-content-wrapper {
                margin-left: 0;
            }
        }
    </style>
</head>
<body>

<div class="d-flex" id="wrapper">
    <!-- Sidebar -->
    <div class="sidebar" id="sidebar-wrapper">
        <div class="sidebar-heading">Admin Portal</div>
        <div class="list-group list-group-flush">
            <a href="#" class="list-group-item list-group-item-action">
                <i class="bi bi-file-earmark-text"></i> All Complaints
            </a>
            <a href="#" class="list-group-item list-group-item-action">
                <i class="bi bi-gear"></i> Settings
            </a>
            <a href="${pageContext.request.contextPath}/index.jsp" class="list-group-item list-group-item-action">
                <i class="bi bi-box-arrow-right"></i> Logout
            </a>
        </div>
    </div>

    <!-- Page Content -->
    <div id="page-content-wrapper" class="w-100">
        <nav class="navbar navbar-expand-lg navbar-dark mb-4">
            <div class="container-fluid">
                <span class="navbar-brand">Admin Complaints Dashboard</span>
                <button class="btn btn-light btn-sm" onclick="location.href='${pageContext.request.contextPath}/index.jsp'">Logout</button>
            </div>
        </nav>

        <div class="container-fluid px-4 py-3">
            <!-- Dashboard Header -->
            <div class="row mb-4">
                <div class="col-md-8">
                    <h2>Admin Dashboard - Complaints List</h2>
                    <p class="text-muted">Manage all user complaints</p>
                </div>
            </div>

            <!-- Display messages -->
            <% if(request.getParameter("error") != null) { %>
            <div class="alert alert-danger">
                <%= request.getParameter("error") %>
            </div>
            <% } %>

            <% if(request.getParameter("success") != null) { %>
            <div class="alert alert-success">
                <%= request.getParameter("success") %>
            </div>
            <% } %>

            <!-- Complaints Table -->
            <div class="card">
                <div class="card-body">
                    <table class="table table-hover">
                        <thead>
                        <tr>
                            <th>ID</th>
                            <th>User ID</th>
                            <th>Subject</th>
                            <th>Description</th>
                            <th>Status</th>
                            <th>Date Submitted</th>
                            <th>Actions</th>
                        </tr>
                        </thead>
                        <tbody>
                        <%
                            java.util.List<Dto.Complaints> complaints = (java.util.List<Dto.Complaints>) request.getAttribute("complaints");
                            if (complaints != null && !complaints.isEmpty()) {
                                for (Dto.Complaints complaint : complaints) {
                        %>
                        <tr>
                            <td><%= complaint.getId() %></td>
                            <td><%= complaint.getUserId() %></td>
                            <td><%= complaint.getSubject() %></td>
                            <td><%= complaint.getDescription() %></td>
                            <td>
                                <span class="badge <%= complaint.getStatus().equals("Pending") ? "bg-warning" :
                                    complaint.getStatus().equals("In Progress") ? "bg-info" :
                                    complaint.getStatus().equals("Resolved") ? "bg-success" : "bg-danger" %>">
                                    <%= complaint.getStatus() %>
                                </span>
                            </td>
                            <td><%= complaint.getDate_submitted() %></td>
                            <td>
                                <!-- View complaint details -->
                                <form action="${pageContext.request.contextPath}/admin/viewComplaint" method="get" style="display:inline;">
                                    <input type="hidden" name="id" value="<%= complaint.getId() %>" />
                                    <button type="submit" class="btn btn-sm btn-info" title="View Complaint">
                                        <i class="bi bi-eye"></i>
                                    </button>
                                </form>

                                <!-- Update status modal trigger -->
                                <form action="${pageContext.request.contextPath}/admin/editStatus" method="get" style="display:inline;">
                                    <input type="hidden" name="id" value="<%= complaint.getId() %>" />
                                    <button type="submit" class="btn btn-sm btn-warning" title="Edit Status">
                                        <i class="bi bi-pencil"></i>
                                    </button>
                                </form>

                                <!-- Delete complaint -->
                                <form action="${pageContext.request.contextPath}/admin" method="post" style="display:inline;"
                                      onsubmit="return confirm('Are you sure you want to delete this complaint?');">
                                    <input type="hidden" name="action" value="delete">
                                    <input type="hidden" name="complaintId" value="<%= complaint.getId() %>">
                                    <button type="submit" class="btn btn-sm btn-danger" title="Delete Complaint">
                                        <i class="bi bi-trash"></i>
                                    </button>
                                </form>
                            </td>
                        </tr>
                        <%
                            }
                        } else {
                        %>
                        <tr>
                            <td colspan="7" class="text-center">No complaints found.</td>
                        </tr>
                        <%
                            }
                        %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<%-- Modal to edit status --%>
<%
    Dto.Complaints complaint = (Dto.Complaints) request.getAttribute("complaint");
    if (complaint != null) {
%>
<div class="modal show" tabindex="-1" style="display: block; background-color: rgba(0,0,0,0.5);">
    <div class="modal-dialog">
        <div class="modal-content">
            <form action="${pageContext.request.contextPath}/admin" method="post">
                <div class="modal-header">
                    <h5 class="modal-title">Update Status for Complaint #<%= complaint.getId() %></h5>
                    <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn-close" aria-label="Close"></a>
                </div>
                <div class="modal-body">
                    <input type="hidden" name="action" value="updateStatus">
                    <input type="hidden" name="complaintId" value="<%= complaint.getId() %>">

                    <div class="mb-3">
                        <label for="statusSelect" class="form-label">Status</label>
                        <select class="form-select" id="statusSelect" name="status" required>
                            <option value="Pending" <%= "Pending".equals(complaint.getStatus()) ? "selected" : "" %>>Pending</option>
                            <option value="In Progress" <%= "In Progress".equals(complaint.getStatus()) ? "selected" : "" %>>In Progress</option>
                            <option value="Resolved" <%= "Resolved".equals(complaint.getStatus()) ? "selected" : "" %>>Resolved</option>
                        </select>
                    </div>

                    <!-- Add remarks section -->
                    <div class="mb-3">
                        <label for="remarksTextarea" class="form-label">Admin Remarks</label>
                        <textarea class="form-control" id="remarksTextarea" name="remarks" rows="4"
                                  placeholder="Add your comments or notes about this complaint"><%= complaint.getRemarks() != null ? complaint.getRemarks() : "" %></textarea>
                        <div class="form-text text-muted">These remarks will be visible to the admin team only</div>
                    </div>
                </div>
                <div class="modal-footer">
                    <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-secondary">Cancel</a>
                    <button type="submit" class="btn btn-primary">Save Changes</button>
                </div>
            </form>
        </div>
    </div>
</div>
<%
    }
%>

<%-- Modal to view complaint details --%>
<%
    Dto.Complaints viewComplaint = (Dto.Complaints) request.getAttribute("viewComplaint");
    if (viewComplaint != null) {
%>
<div class="modal show" tabindex="-1" style="display: block; background-color: rgba(0,0,0,0.5);">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Complaint Details #<%= viewComplaint.getId() %></h5>
                <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn-close" aria-label="Close"></a>
            </div>
            <div class="modal-body">
                <div class="mb-3">
                    <strong>Subject:</strong>
                    <p><%= viewComplaint.getSubject() %></p>
                </div>
                <div class="mb-3">
                    <strong>Description:</strong>
                    <p><%= viewComplaint.getDescription() %></p>
                </div>
                <div class="mb-3">
                    <strong>Status:</strong>
                    <span class="badge <%= viewComplaint.getStatus().equals("Pending") ? "bg-warning" :
                        viewComplaint.getStatus().equals("In Progress") ? "bg-info" :
                        viewComplaint.getStatus().equals("Resolved") ? "bg-success" : "bg-danger" %>">
                        <%= viewComplaint.getStatus() %>
                    </span>
                </div>
                <div class="mb-3">
                    <strong>Submitted By:</strong>
                    <p>User #<%= viewComplaint.getUserId() %></p>
                </div>
                <div class="mb-3">
                    <strong>Date Submitted:</strong>
                    <p><%= viewComplaint.getDate_submitted() %></p>
                </div>
                <!-- Display remarks if they exist -->
                <% if (viewComplaint.getRemarks() != null && !viewComplaint.getRemarks().isEmpty()) { %>
                <div class="mb-3">
                    <strong>Admin Remarks:</strong>
                    <div class="card bg-light mt-2">
                        <div class="card-body">
                            <p class="card-text"><%= viewComplaint.getRemarks() %></p>
                        </div>
                    </div>
                </div>
                <% } %>
            </div>
            <div class="modal-footer">
                <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-secondary">Close</a>
            </div>
        </div>
    </div>
</div>
<%
    }
%>

<!-- Bootstrap JS (for modal functionality) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Toggle sidebar on mobile
    document.addEventListener('DOMContentLoaded', function() {
        const menuToggle = document.querySelector('.navbar-toggler');
        if (menuToggle) {
            menuToggle.addEventListener('click', function() {
                document.querySelector('.sidebar').classList.toggle('show');
            });
        }
    });
</script>
</body>
</html>