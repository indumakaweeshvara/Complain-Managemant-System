
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Sign In</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/index.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
</head>
<body>

<div class="login-container">
    <h2>Sign In</h2>
    <form action="${pageContext.request.contextPath}/Signin" method="post">
        <div class="form-group">
            <label for="username">Username</label>
            <input type="text" id="username" name="username" required />
        </div>

        <div class="form-group">
            <label for="password">Password</label>
            <input type="password" id="password" name="password" required />
            <span class="eye-icon" onclick="togglePassword()"><i class="fas fa-eye eye-icon" id="togglePassword"></i></span>
        </div>

        <button type="submit" class="btn">Sign In</button>
        <div class="links">
            Don't have an account? <a href="${pageContext.request.contextPath}/jsp/signup.jsp">Sign up</a>
        </div>
    </form>
</div>

<script src="${pageContext.request.contextPath}/js/index.js"></script>

</body>
</html>