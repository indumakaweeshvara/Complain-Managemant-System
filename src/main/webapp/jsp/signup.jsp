
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Sign Up</title>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/signup.css">
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
</head>
<body>
<div class="signup-container">
  <h2>Sign Up</h2>
  <form action="${pageContext.request.contextPath}/Signup" method="post">
    <div class="form-group">
    <label for="username">Username</label>
    <input type="text" id="username" name="username" required>
  </div>
    <div class="form-group">
      <label for="email">Email</label>
      <input type="email" id="email" name="email" required>
    </div>
    <div class="form-group">
      <label for="password">Password</label>
      <input type="password" id="password" name="password" required>
      <i class="fas fa-eye eye-icon" onclick="togglePassword()" id="togglePassword"></i>
    </div>
    <div class="form-group">
      <label for="role">Role</label>
      <select id="role" name="role" required>
        <option value="">Select Role</option>
        <option value="employee">Employee</option>
        <option value="admin">Admin</option>
      </select>
    </div>
    <button type="submit" class="btn">Sign Up</button>
  </form>
  <div class="links">
    Already have an account? <a href="${pageContext.request.contextPath}/index.jsp">Login here</a>.
  </div>
</div>
<script src="${pageContext.request.contextPath}/js/signup.js"></script>
</body>
</html>
