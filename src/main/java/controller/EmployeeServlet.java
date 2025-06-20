package controller;

import Dto.Complaints;
import Dto.User;
import Model.ComplaintsModel;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/employee/*")
public class EmployeeServlet extends HttpServlet {
    private ComplaintsModel complaintsModel;

    @Override
    public void init() {
        complaintsModel = new ComplaintsModel();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getPathInfo();
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/index.jsp");
            return;
        }

        if ("/editComplaintForm".equals(path)) {
            try {
                int id = Integer.parseInt(req.getParameter("complaintId"));
                Complaints complaint = complaintsModel.getComplaintById(id);

                if (complaint == null || complaint.getUserId() != user.getId()) {
                    session.setAttribute("error", "Complaint not found or access denied.");
                    resp.sendRedirect(req.getContextPath() + "/employee");
                    return;
                }

                if (isComplaintClosed(complaint)) {
                    session.setAttribute("error", "Cannot edit a complaint that is already " + complaint.getStatus());
                    resp.sendRedirect(req.getContextPath() + "/employee");
                    return;
                }

                req.setAttribute("complaint", complaint);
                req.getRequestDispatcher("/jsp/editComplaint.jsp").forward(req, resp);
            } catch (Exception e) {
                session.setAttribute("error", "Invalid complaint ID.");
                resp.sendRedirect(req.getContextPath() + "/employee");
            }
            return;
        }

        List<Complaints> userComplaints = complaintsModel.getComplaintsByUser(String.valueOf(user.getId()));
        req.setAttribute("userComplaints", userComplaints);
        req.getRequestDispatcher("/jsp/EmployeeDashboard.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getPathInfo();
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || !"employee".equals(user.getRole())) {
            resp.sendRedirect(req.getContextPath() + "/index.jsp");
            return;
        }

        switch (path) {
            case "/submitComplaint":
                handleSubmitComplaint(req, resp, session, user);
                break;

            case "/updateComplaint":
                handleUpdateComplaint(req, resp, session, user);
                break;

            case "/deleteComplaint":
                handleDeleteComplaint(req, resp, session, user);
                break;

            default:
                resp.sendRedirect(req.getContextPath() + "/employee");
                break;
        }
    }

    private void handleSubmitComplaint(HttpServletRequest req, HttpServletResponse resp,
                                       HttpSession session, User user) throws IOException {
        try {
            Complaints newComplaint = new Complaints();
            newComplaint.setUserId(user.getId());
            newComplaint.setSubject(req.getParameter("subject"));
            newComplaint.setDescription(req.getParameter("description"));
            newComplaint.setStatus("Pending");
            newComplaint.setDate_submitted(new java.util.Date());

            if (complaintsModel.addComplaint(newComplaint)) {
                session.setAttribute("msg", "Complaint submitted successfully!");
            } else {
                session.setAttribute("error", "Failed to submit complaint.");
            }
            resp.sendRedirect(req.getContextPath() + "/employee/dashboard");
        } catch (Exception e) {
            session.setAttribute("error", "Error submitting complaint: " + e.getMessage());
            resp.sendRedirect(req.getContextPath() + "/employee");
        }
    }

    private void handleUpdateComplaint(HttpServletRequest req, HttpServletResponse resp,
                                       HttpSession session, User user) throws IOException {
        try {
            int complaintId = Integer.parseInt(req.getParameter("complaintId"));
            Complaints existing = complaintsModel.getComplaintById(complaintId);

            if (existing == null || existing.getUserId() != user.getId()) {
                session.setAttribute("error", "Invalid complaint or access denied.");
                resp.sendRedirect(req.getContextPath() + "/employee");
                return;
            }

            if (isComplaintClosed(existing)) {
                session.setAttribute("error", "Cannot update a complaint that is already " + existing.getStatus());
                resp.sendRedirect(req.getContextPath() + "/employee");
                return;
            }

            existing.setSubject(req.getParameter("subject"));
            existing.setDescription(req.getParameter("description"));

            if (complaintsModel.updateComplaint(existing)) {
                session.setAttribute("msg", "Complaint updated successfully.");
            } else {
                session.setAttribute("error", "Update failed.");
            }
            resp.sendRedirect(req.getContextPath() + "/employee");

        } catch (Exception e) {
            session.setAttribute("error", "An error occurred: " + e.getMessage());
            resp.sendRedirect(req.getContextPath() + "/employee");
        }
    }

    private void handleDeleteComplaint(HttpServletRequest req, HttpServletResponse resp,
                                       HttpSession session, User user) throws IOException {
        try {
            int complaintId = Integer.parseInt(req.getParameter("complaintId"));
            Complaints existing = complaintsModel.getComplaintById(complaintId);

            if (existing == null || existing.getUserId() != user.getId()) {
                session.setAttribute("error", "Invalid complaint or access denied.");
                resp.sendRedirect(req.getContextPath() + "/employee");
                return;
            }

            if (isComplaintClosed(existing)) {
                session.setAttribute("error", "Cannot delete a complaint that is already " + existing.getStatus());
                resp.sendRedirect(req.getContextPath() + "/employee");
                return;
            }

            if (complaintsModel.deleteComplaint(complaintId)) {
                session.setAttribute("msg", "Complaint deleted successfully.");
            } else {
                session.setAttribute("error", "Failed to delete complaint.");
            }
            resp.sendRedirect(req.getContextPath() + "/employee");

        } catch (Exception e) {
            session.setAttribute("error", "An error occurred while deleting complaint: " + e.getMessage());
            resp.sendRedirect(req.getContextPath() + "/employee");
        }
    }

    private boolean isComplaintClosed(Complaints complaint) {
        return "Resolved".equalsIgnoreCase(complaint.getStatus()) ||
                "Rejected".equalsIgnoreCase(complaint.getStatus());
    }
}