package lk.ijse.complainmanagementsystem;

import Dao.UserDao;
import Model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/signin")
public class SignInServlet extends HttpServlet {

    private final UserDao userDao = new UserDao();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        User user = userDao.loginUser(username, password);

        if (user != null) {
            // Login successful - create session
            HttpSession session = request.getSession();
            session.setAttribute("currentUser", user);

            if ("Admin".equalsIgnoreCase(user.getRole())) {
                response.sendRedirect("admin_dashboard.jsp");
            } else if ("Employee".equalsIgnoreCase(user.getRole())) {
                response.sendRedirect("employee_dashboard.jsp");
            } else {
                // Invalid role
                response.sendRedirect("login.jsp?error=InvalidRole");
            }

        } else {
            // Login failed
            response.sendRedirect("login.jsp?error=InvalidCredentials");
        }
    }
}
