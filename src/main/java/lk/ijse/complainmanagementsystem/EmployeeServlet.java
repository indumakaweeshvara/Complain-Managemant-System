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

@WebServlet("/employee")
public class EmployeeServlet extends HttpServlet {

    private final ComplaintDao complaintDao = new ComplaintDao();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Handle complaint submission
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("currentUser") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        User currentUser = (User) session.getAttribute("currentUser");

        String title = request.getParameter("title");
        String description = request.getParameter("description");

        Complaint complaint = new Complaint();
        complaint.setTitle(title);
        complaint.setDescription(description);
        complaint.setUserId(currentUser.getId());
        complaint.setStatus("Pending");

        boolean isAdded = complaintDao.addComplaint(complaint);

        if (isAdded) {
            response.sendRedirect("employee_dashboard.jsp?success=ComplaintSubmitted");
        } else {
            response.sendRedirect("employee_dashboard.jsp?error=SubmissionFailed");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Handle complaint viewing
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("currentUser") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        User currentUser = (User) session.getAttribute("currentUser");

        List<Complaint> complaintList = complaintDao.getComplaintsByUserId(currentUser.getId());
        request.setAttribute("complaints", complaintList);
        request.getRequestDispatcher("employee_dashboard.jsp").forward(request, response);
    }
}