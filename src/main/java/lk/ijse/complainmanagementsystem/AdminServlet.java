package lk.ijse.complainmanagementsystem;

import Dao.ComplaintDao;
import Model.Complaint;
import Model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin")
public class AdminServlet extends HttpServlet {

    private final ComplaintDao complaintDao = new ComplaintDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Session validation
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("currentUser") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        User currentUser = (User) session.getAttribute("currentUser");
        if (!"Admin".equalsIgnoreCase(currentUser.getRole())) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Fetch all complaints
        List<Complaint> complaintList = complaintDao.getAllComplaints();
        request.setAttribute("complaints", complaintList);

        request.getRequestDispatcher("admin_dashboard.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("update".equals(action)) {
            // Update complaint
            int complaintId = Integer.parseInt(request.getParameter("complaintId"));
            String status = request.getParameter("status");
            String remarks = request.getParameter("remarks");

            boolean isUpdated = complaintDao.updateComplaint(complaintId, status, remarks);

            if (isUpdated) {
                response.sendRedirect("admin?success=ComplaintUpdated");
            } else {
                response.sendRedirect("admin?error=UpdateFailed");
            }

        } else if ("delete".equals(action)) {
            // Delete complaint
            int complaintId = Integer.parseInt(request.getParameter("complaintId"));

            boolean isDeleted = complaintDao.deleteComplaint(complaintId);

            if (isDeleted) {
                response.sendRedirect("admin?success=ComplaintDeleted");
            } else {
                response.sendRedirect("admin?error=DeleteFailed");
            }
        }
    }
}