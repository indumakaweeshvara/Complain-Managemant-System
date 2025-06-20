package controller;

import Dto.User;
import Model.UserModel;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/Signup")
public class SignUpServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String username = req.getParameter("username");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String role = req.getParameter("role");

        // Check for null or empty values
        if (username == null || username.trim().isEmpty() ||
                email == null || email.trim().isEmpty() ||
                password == null || password.trim().isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/index.jsp?error=Missing+required+fields");
            return;
        }

        // Set default role if none provided
        if (role == null || role.trim().isEmpty()) {
            role = "employee"; // Default role
        }

        User user = new User();
        user.setUsername(username);
        user.setEmail(email);
        user.setPassword(password);
        user.setRole(role);

        boolean success = new UserModel().register(user);
        if (success) {
            resp.sendRedirect(req.getContextPath() + "/index.jsp?message=Registration+successful.+Please+log+in.");
        } else {
            resp.sendRedirect(req.getContextPath() + "/jsp/signup.jsp?error=Registration+failed.+User+may+already+exist");
        }
    }
}