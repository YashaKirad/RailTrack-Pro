<%@ include file="dbConnection.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String action = request.getParameter("update") != null ? "update" : "delete";
    int scheduleID = Integer.parseInt(request.getParameter(action));

    try {
        // Use the connection already set up in dbConnection.jsp
        PreparedStatement stmt;

        if ("update".equals(action)) {
            // Prepare the update query
            String trainID = request.getParameter("trainID_" + scheduleID);
            String originID = request.getParameter("originID_" + scheduleID);
            String destinationID = request.getParameter("destinationID_" + scheduleID);
            String departure = request.getParameter("departure_" + scheduleID);
            String arrival = request.getParameter("arrival_" + scheduleID);
            String fare = request.getParameter("fare_" + scheduleID);

            String query = "UPDATE TrainSchedule SET TrainID = ?, OriginID = ?, DestinationID = ?, DepartureDatetime = ?, ArrivalDatetime = ?, Fare = ? WHERE ScheduleID = ?";
            stmt = ((Connection) request.getAttribute("dbConnection")).prepareStatement(query);
            stmt.setInt(1, Integer.parseInt(trainID));
            stmt.setInt(2, Integer.parseInt(originID));
            stmt.setInt(3, Integer.parseInt(destinationID));
            stmt.setString(4, departure);
            stmt.setString(5, arrival);
            stmt.setBigDecimal(6, new java.math.BigDecimal(fare));
            stmt.setInt(7, scheduleID);

            int rows = stmt.executeUpdate();
            if (rows > 0) {
                out.println("<script>alert('Train schedule updated successfully!'); window.location='editDeleteTrainSchedules.jsp';</script>");
            } else {
                out.println("<script>alert('Failed to update train schedule. Please try again.'); window.location='editDeleteTrainSchedules.jsp';</script>");
            }
        } else if ("delete".equals(action)) {
            // Prepare the delete query
            String query = "DELETE FROM TrainSchedule WHERE ScheduleID = ?";
            stmt = ((Connection) request.getAttribute("dbConnection")).prepareStatement(query);
            stmt.setInt(1, scheduleID);

            int rows = stmt.executeUpdate();
            if (rows > 0) {
                out.println("<script>alert('Train schedule deleted successfully!'); window.location='editDeleteTrainSchedules.jsp';</script>");
            } else {
                out.println("<script>alert('Failed to delete train schedule. Please try again.'); window.location='editDeleteTrainSchedules.jsp';</script>");
            }
        }
    } catch (Exception e) {
        out.println("<p>Error: " + e.getMessage() + "</p>");
    }
%>
