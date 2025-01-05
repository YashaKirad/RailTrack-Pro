<%-- <%@ page import="java.math.BigDecimal" %>
<%@ include file="dbConnection.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Calculate Fare</title>
</head>
<body>
    <% 
        String username = request.getParameter("username");
        int scheduleID = Integer.parseInt(request.getParameter("scheduleID"));
        BigDecimal baseFare = new BigDecimal(request.getParameter("baseFare"));

        int adults = Integer.parseInt(request.getParameter("adults"));
        int children = Integer.parseInt(request.getParameter("children"));
        int seniors = Integer.parseInt(request.getParameter("seniors"));
        int disabled = Integer.parseInt(request.getParameter("disabled"));
        String tripType = request.getParameter("tripType");

        // Fetch discounts
        BigDecimal childDiscount = new BigDecimal("0.25");
        BigDecimal seniorDiscount = new BigDecimal("0.35");
        BigDecimal disabledDiscount = new BigDecimal("0.50");

        // Calculate fare
        BigDecimal adultFare = baseFare.multiply(new BigDecimal(adults));
        BigDecimal childFare = baseFare.multiply(new BigDecimal(children)).multiply(BigDecimal.ONE.subtract(childDiscount));
        BigDecimal seniorFare = baseFare.multiply(new BigDecimal(seniors)).multiply(BigDecimal.ONE.subtract(seniorDiscount));
        BigDecimal disabledFare = baseFare.multiply(new BigDecimal(disabled)).multiply(BigDecimal.ONE.subtract(disabledDiscount));

        BigDecimal totalFare = adultFare.add(childFare).add(seniorFare).add(disabledFare);

        // Double fare if trip type is "Two Way"
        if ("Two Way".equalsIgnoreCase(tripType)) {
            totalFare = totalFare.multiply(new BigDecimal("2"));
        }

        // Save reservation
        String insertQuery = "INSERT INTO Reservations (EmailAddress, ScheduleID, ReservationDate, TotalFare, DiscountID) " +
                             "VALUES (?, ?, CURDATE(), ?, NULL)";
        PreparedStatement stmt = conn.prepareStatement(insertQuery);
        stmt.setString(1, username);
        stmt.setInt(2, scheduleID);
        stmt.setBigDecimal(3, totalFare);

        int rowsInserted = stmt.executeUpdate();

        if (rowsInserted > 0) {
            out.println("<h1>Booking Successful!</h1>");
            out.println("<p>Total Fare: " + totalFare + "</p>");
        } else {
            out.println("<h1>Booking Failed. Please try again.</h1>");
        }

        stmt.close();
    %>
    <form action="viewBookings.jsp" method="get">
        <input type="hidden" name="username" value="<%= username %>">
        <button type="submit">View Bookings</button>
    </form>
</body>
</html>
--%>

<%@ page import="java.math.BigDecimal" %>
<%@ include file="dbConnection.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Calculate Fare</title>
</head>
<body>
    <% 
        try {
            String username = request.getParameter("username");
            int scheduleID = Integer.parseInt(request.getParameter("scheduleID"));
            BigDecimal baseFare = new BigDecimal(request.getParameter("baseFare"));

            int adults = Integer.parseInt(request.getParameter("adults"));
            int children = Integer.parseInt(request.getParameter("children"));
            int seniors = Integer.parseInt(request.getParameter("seniors"));
            int disabled = Integer.parseInt(request.getParameter("disabled"));
            String tripType = request.getParameter("tripType");

            BigDecimal childDiscount = new BigDecimal("0.25");
            BigDecimal seniorDiscount = new BigDecimal("0.35");
            BigDecimal disabledDiscount = new BigDecimal("0.50");

            BigDecimal adultFare = baseFare.multiply(new BigDecimal(adults));
            BigDecimal childFare = baseFare.multiply(new BigDecimal(children)).multiply(BigDecimal.ONE.subtract(childDiscount));
            BigDecimal seniorFare = baseFare.multiply(new BigDecimal(seniors)).multiply(BigDecimal.ONE.subtract(seniorDiscount));
            BigDecimal disabledFare = baseFare.multiply(new BigDecimal(disabled)).multiply(BigDecimal.ONE.subtract(disabledDiscount));

            BigDecimal totalFare = adultFare.add(childFare).add(seniorFare).add(disabledFare);

            if ("Two Way".equalsIgnoreCase(tripType)) {
                totalFare = totalFare.multiply(new BigDecimal("2"));
            }

            String query = "INSERT INTO Reservations (EmailAddress, ScheduleID, ReservationDate, TotalFare) " +
                           "VALUES (?, ?, CURDATE(), ?)";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, username);
            stmt.setInt(2, scheduleID);
            stmt.setBigDecimal(3, totalFare);

            int rowsInserted = stmt.executeUpdate();

            if (rowsInserted > 0) {
                out.println("<h1>Booking Successful!</h1>");
                out.println("<p>Total Fare: $" + totalFare + "</p>");
            } else {
                out.println("<h1>Booking Failed. Please try again.</h1>");
            }

            stmt.close();
        } catch (Exception e) {
            out.println("<h1>Error calculating fare: " + e.getMessage() + "</h1>");
        }
    %>
    <form action="viewBookings.jsp" method="get">
        <input type="hidden" name="username" value="<%= request.getParameter("username") %>">
        <button type="submit">View Bookings</button>
    </form>
</body>
</html>

