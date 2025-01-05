<%-- <%@ include file="dbConnection.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String question = request.getParameter("question");

    if (question != null && !question.trim().isEmpty()) {
        String query = "INSERT INTO FAQs (Question, DateAsked) VALUES (?, ?)";
        try {
            // Use the connection already provided in dbConnection.jsp
            PreparedStatement stmt = ((Connection) request.getAttribute("dbConnection")).prepareStatement(query);
            stmt.setString(1, question);
            stmt.setDate(2, new java.sql.Date(System.currentTimeMillis())); // Set the current date

            int rows = stmt.executeUpdate();
            if (rows > 0) {
                out.println("<script>alert('Question submitted successfully!'); window.location='faq.jsp';</script>");
            } else {
                out.println("<script>alert('Failed to submit question. Please try again.'); window.location='faq.jsp';</script>");
            }
        } catch (Exception e) {
            out.println("<p>Error: " + e.getMessage() + "</p>");
        }
    } else {
        response.sendRedirect("faq.jsp");
    }
%>
--%>

<%@ include file="dbConnection.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String question = request.getParameter("question");
    String username = request.getParameter("username"); // Extract username from the URL

    if (question != null && !question.trim().isEmpty()) {
        String query = "INSERT INTO FAQs (Question, DateAsked) VALUES (?, ?)";
        try {
            // Use the connection already provided in dbConnection.jsp
            PreparedStatement stmt = ((Connection) request.getAttribute("dbConnection")).prepareStatement(query);
            stmt.setString(1, question);
            stmt.setDate(2, new java.sql.Date(System.currentTimeMillis())); // Set the current date

            int rows = stmt.executeUpdate();
            if (rows > 0) {
                out.println("<script>alert('Question submitted successfully!'); window.location='faq.jsp?username=" + username + "';</script>");
            } else {
                out.println("<script>alert('Failed to submit question. Please try again.'); window.location='faq.jsp?username=" + username + "';</script>");
            }
        } catch (Exception e) {
            out.println("<p>Error: " + e.getMessage() + "</p>");
        }
    } else {
        response.sendRedirect("faq.jsp?username=" + username); // Redirect to faq.jsp with username
    }
%>