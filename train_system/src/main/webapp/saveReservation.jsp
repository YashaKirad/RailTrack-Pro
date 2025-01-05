<%-- <%@ include file="dbConnection.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true" %>
<%
    try {
        // Retrieve form data
        int scheduleID = Integer.parseInt(request.getParameter("scheduleID"));
        double fare = Double.parseDouble(request.getParameter("fare"));
        String tripType = request.getParameter("tripType");
        int adults = Integer.parseInt(request.getParameter("adults"));
        int children = Integer.parseInt(request.getParameter("children"));
        int seniors = Integer.parseInt(request.getParameter("seniors"));
        int disabled = Integer.parseInt(request.getParameter("disabled"));
        String username = request.getParameter("username"); // Retrieve username from form

        // Validate passenger counts
        if (adults < 0 || children < 0 || seniors < 0 || disabled < 0) {
            out.println("<script>alert('Invalid passenger count. Please enter non-negative values.'); window.location='buyTickets.jsp';</script>");
            return;
        }

        // Calculate total passengers and fare
        int totalPassengers = adults + children + seniors + disabled;
        double totalFare = fare * totalPassengers;
        if ("round-trip".equalsIgnoreCase(tripType)) {
            totalFare *= 2; // Double the fare for round trip
        }

        // Fetch EmailAddress from Customer table based on username
        String emailQuery = "SELECT EmailAddress FROM Customer WHERE Username = ?";
        String emailAddress = null;
        try (PreparedStatement emailStmt = ((Connection) request.getAttribute("dbConnection")).prepareStatement(emailQuery)) {
            emailStmt.setString(1, username);
            try (ResultSet rs = emailStmt.executeQuery()) {
                if (rs.next()) {
                    emailAddress = rs.getString("EmailAddress");
                }
            }
        }

        // Check if the email address was found
        if (emailAddress == null) {
            out.println("<script>alert('User not found. Please check your username.'); window.location='buyTickets.jsp';</script>");
            return;
        }

        // Generate a unique ReservationID
        int reservationID = 0;
        boolean isUnique = false;
        while (!isUnique) {
            reservationID = (int) (Math.random() * 900) + 100; // Random 3-digit ID
            String checkQuery = "SELECT COUNT(*) FROM Reservations WHERE ReservationID = ?";
            try (PreparedStatement checkStmt = ((Connection) request.getAttribute("dbConnection")).prepareStatement(checkQuery)) {
                checkStmt.setInt(1, reservationID);
                try (ResultSet rs = checkStmt.executeQuery()) {
                    if (rs.next() && rs.getInt(1) == 0) {
                        isUnique = true;
                    }
                }
            }
        }

        // Insert reservation into the database
        String insertQuery = "INSERT INTO Reservations (ReservationID, ScheduleID, EmailAddress, ReservationDate, TotalFare) VALUES (?, ?, ?, CURRENT_DATE, ?)";
        try (PreparedStatement insertStmt = ((Connection) request.getAttribute("dbConnection")).prepareStatement(insertQuery)) {
            insertStmt.setInt(1, reservationID);
            insertStmt.setInt(2, scheduleID);
            insertStmt.setString(3, emailAddress); // Use the fetched EmailAddress
            insertStmt.setDouble(4, totalFare);

            int rows = insertStmt.executeUpdate();
            if (rows > 0) {
                // Redirect to viewBookings.jsp with username as query parameter
                out.println("<script>alert('Booking successful! Your Reservation ID is " + reservationID + "'); window.location='viewBookings.jsp?username=" + username + "';</script>");
            } else {
                out.println("<script>alert('Booking failed. Please try again.'); window.location='buyTickets.jsp';</script>");
            }
        }
    } catch (NumberFormatException e) {
        out.println("<script>alert('Invalid input. Please check your data.'); window.location='buyTickets.jsp';</script>");
    } catch (Exception e) {
        out.println("<p>Error: " + e.getMessage() + "</p>");
    }
%>
--%>

<%@ include file="dbConnection.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true" %>
<%
    try {
        int scheduleID = Integer.parseInt(request.getParameter("scheduleID"));
        double baseFare = Double.parseDouble(request.getParameter("fare"));
        String tripType = request.getParameter("tripType");
        int adults = Integer.parseInt(request.getParameter("adults"));
        int children = Integer.parseInt(request.getParameter("children"));
        int seniors = Integer.parseInt(request.getParameter("seniors"));
        int disabled = Integer.parseInt(request.getParameter("disabled"));
        String username = request.getParameter("username");

        // Discount percentages
        double adultDiscount = Double.parseDouble(request.getParameter("adultDiscount"));
        double childDiscount = Double.parseDouble(request.getParameter("childDiscount"));
        double seniorDiscount = Double.parseDouble(request.getParameter("seniorDiscount"));
        double disabledDiscount = Double.parseDouble(request.getParameter("disabledDiscount"));

        // Calculate total fare
        double totalFare = (adults * baseFare * (1 - adultDiscount / 100)) +
                           (children * baseFare * (1 - childDiscount / 100)) +
                           (seniors * baseFare * (1 - seniorDiscount / 100)) +
                           (disabled * baseFare * (1 - disabledDiscount / 100));

        if ("round-trip".equalsIgnoreCase(tripType)) {
            totalFare *= 2;
        }

        // Fetch EmailAddress from Customer table
        String emailQuery = "SELECT EmailAddress FROM Customer WHERE Username = ?";
        String emailAddress = null;
        try (PreparedStatement emailStmt = conn.prepareStatement(emailQuery)) {
            emailStmt.setString(1, username);
            try (ResultSet rs = emailStmt.executeQuery()) {
                if (rs.next()) {
                    emailAddress = rs.getString("EmailAddress");
                }
            }
        }

        if (emailAddress == null) {
            out.println("<script>alert('User not found. Please check your username.'); window.location='buyTickets.jsp';</script>");
            return;
        }

        // Generate unique ReservationID
        int reservationID = (int) (Math.random() * 900) + 100;

        // Insert reservation
        String insertQuery = "INSERT INTO Reservations (ReservationID, ScheduleID, EmailAddress, ReservationDate, TotalFare) VALUES (?, ?, ?, CURRENT_DATE, ?)";
        try (PreparedStatement insertStmt = conn.prepareStatement(insertQuery)) {
            insertStmt.setInt(1, reservationID);
            insertStmt.setInt(2, scheduleID);
            insertStmt.setString(3, emailAddress);
            insertStmt.setDouble(4, totalFare);

            int rows = insertStmt.executeUpdate();
            if (rows > 0) {
                out.println("<script>alert('Booking successful! Total Fare: $" + totalFare + "'); window.location='currentBookings.jsp?username=" + username + "';</script>");
            } else {
                out.println("<script>alert('Booking failed. Please try again.'); window.location='buyTickets.jsp';</script>");
            }
        }
    } catch (Exception e) {
        out.println("<p>Error: " + e.getMessage() + "</p>");
    }
%>


