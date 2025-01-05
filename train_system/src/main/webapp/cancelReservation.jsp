<%@ include file="dbConnection.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    try {
        // Retrieve reservation ID and username from the request
        int reservationID = Integer.parseInt(request.getParameter("reservationID"));
        String username = request.getParameter("username");

        // Delete the reservation from the database
        String deleteQuery = "DELETE FROM Reservations WHERE ReservationID = ?";
        PreparedStatement deleteStmt = conn.prepareStatement(deleteQuery);
        deleteStmt.setInt(1, reservationID);

        int rowsAffected = deleteStmt.executeUpdate();
        if (rowsAffected > 0) {
            // Successfully deleted the reservation
            out.println("<script>alert('Reservation canceled successfully.'); window.location='currentBookings.jsp?username=" + username + "';</script>");
        } else {
            // Failed to delete the reservation
            out.println("<script>alert('Failed to cancel reservation. Please try again later.'); window.location='viewBookings.jsp?username=" + username + "';</script>");
        }

        deleteStmt.close();
    } catch (Exception e) {
        out.println("<script>alert('Error occurred: " + e.getMessage() + "'); window.location='viewBookings.jsp';</script>");
    }
%>
