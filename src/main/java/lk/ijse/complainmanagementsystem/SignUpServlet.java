package lk.ijse.complainmanagementsystem;

import Dao.UserDao;
import Model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/signup")
public class SignUpServlet extends HttpServlet {

    private final UserDao userDao = new UserDao();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        User user = new User();
        user.setUsername(username);
        user.setPassword(password);
        user.setRole(role);

        boolean isRegistered = userDao.registerUser(user);

        if (isRegistered) {
            // Redirect to login page after successful registration
            response.sendRedirect("login.jsp");
        } else {
            // Redirect back to signup page if failed
            response.sendRedirect("signup.jsp?error=RegistrationFailed");
        }
    }
}