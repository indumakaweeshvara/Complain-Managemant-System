<%--
  Created by IntelliJ IDEA.
  User: Indu xxx
  Date: 6/16/2025
  Time: 10:09 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
  // Invalidate the session
  session.invalidate();
  // Redirect to login page
  response.sendRedirect("login.jsp");
%>