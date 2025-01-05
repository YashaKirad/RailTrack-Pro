<%@ include file="dbConnection.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String lastName = request.getParameter("lastName");
    String firstName = request.getParameter("firstName");
    String email = request.getParameter("email");
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    try {
        // SQL query to insert new user data
        String query = "INSERT INTO Customer (LastName, FirstName, EmailAddress, Username, Password) VALUES (?, ?, ?, ?, ?)";
        PreparedStatement stmt = conn.prepareStatement(query);
        stmt.setString(1, lastName);
        stmt.setString(2, firstName);
        stmt.setString(3, email);
        stmt.setString(4, username);
        stmt.setString(5, password);

        int rows = stmt.executeUpdate();
        if (rows > 0) {
            out.println("<script>alert('Account created successfully!'); window.location='customerLogin.jsp';</script>");
        } else {
            out.println("<script>alert('Account creation failed. Please try again.'); window.location='register.jsp';</script>");
        }
    } catch (SQLIntegrityConstraintViolationException e) {
        out.println("<script>alert('Email or Username already exists. Please use a different one.'); window.location='register.jsp';</script>");
    } catch (Exception e) {
        out.println("<script>alert('An error occurred: " + e.getMessage() + "'); window.location='register.jsp';</script>");
    }
%>
