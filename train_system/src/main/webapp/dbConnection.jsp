<%@ page import="java.sql.*" %>
<%
    String dbURL = "jdbc:mysql://localhost:3306/train_db7";
    String dbUser = "root"; // Update with your DB username
    String dbPassword = "Atharva2005**"; // Update with your DB password
    Connection conn = null;
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);
        
    } catch (Exception e) {
        out.println("Database connection failed: " + e.getMessage());
    }
    request.setAttribute("dbConnection", conn);
%>
