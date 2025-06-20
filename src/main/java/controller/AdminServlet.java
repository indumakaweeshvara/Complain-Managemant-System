package controller;

import Dto.Complaints;
import Model.ComplaintsModel;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/admin/*")
public class AdminServlet extends HttpServlet {

    private final ComplaintsModel complaintsModel = new ComplaintsModel();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getPathInfo();

        try {
            if (path != null && path.equals("/viewComplaint")) {
                // Load complaint by id to display details
                int id = Integer.parseInt(request.getParameter("id"));
                Complaints complaint = complaintsModel.getComplaintById(id);
                request.setAttribute("viewComplaint", complaint); // Use a different attribute name

                // Also load all complaints for table display
                List<Complaints> complaintsList = complaintsModel.getAllComplaints();
                request.setAttribute("complaints", complaintsList);

                request.getRequestDispatcher("/jsp/AdminDashboard.jsp").forward(request, response);
            } else if ("/admin/editComplaint".equals(path)) {
                String idParam = request.getParameter("id");
                if (idParam != null) {
                    int complaintId = Integer.parseInt(idParam);
                    Complaints complaint = complaintsModel.getComplaintById(complaintId); // Implement this
                    request.setAttribute("selectedComplaint", complaint);
                    List<Complaints> complaints = complaintsModel.getAllComplaints(); // Optional: To refill table
                    request.setAttribute("complaints", complaints);
                    request.getRequestDispatcher("/WEB-INF/views/adminDashboard.jsp").forward(request, response);
                }
            }
            else if (path != null && path.equals("/editStatus")) {
                // Load complaint by id to edit status
                int id = Integer.parseInt(request.getParameter("id"));
                Complaints complaint = complaintsModel.getComplaintById(id);
                request.setAttribute("complaint", complaint); // Use this attribute name for edit modal

                // Also load all complaints for table display
                List<Complaints> complaintsList = complaintsModel.getAllComplaints();
                request.setAttribute("complaints", complaintsList);

                request.getRequestDispatcher("/jsp/AdminDashboard.jsp").forward(request, response);
            } else {
                // Default: load all complaints
                List<Complaints> complaintsList = complaintsModel.getAllComplaints();
                request.setAttribute("complaints", complaintsList);
                request.getRequestDispatcher("/jsp/AdminDashboard.jsp").forward(request, response);
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            if ("updateStatus".equals(action)) {
                int complaintId = Integer.parseInt(request.getParameter("complaintId"));
                String status = request.getParameter("status");
                String remarks = request.getParameter("remarks");

                complaintsModel.updateComplaintStatusAndRemarks(complaintId, status, remarks);

            } else if ("delete".equals(action)) {
                int complaintId = Integer.parseInt(request.getParameter("complaintId"));
                complaintsModel.deleteComplaintById(complaintId);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        response.sendRedirect(request.getContextPath() + "/admin/dashboard");
    }
}
