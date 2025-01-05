<%-- <%@ include file="dbConnection.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Past Bookings</title>
    <!-- Link to Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 font-sans flex justify-center items-center min-h-screen">

    <div class="w-full max-w-6xl p-6 bg-white rounded-lg shadow-lg">
        <h1 class="text-3xl font-bold text-center text-indigo-600 mb-8">Your Past Bookings</h1>

        <table class="min-w-full bg-white border border-gray-200 rounded-lg shadow-md overflow-hidden">
            <thead class="bg-indigo-600 text-white">
                <tr>
                    <th class="px-6 py-3 text-left">Reservation ID</th>
                    <th class="px-6 py-3 text-left">Transit Line</th>
                    <th class="px-6 py-3 text-left">Origin</th>
                    <th class="px-6 py-3 text-left">Destination</th>
                    <th class="px-6 py-3 text-left">Departure DateTime</th>
                    <th class="px-6 py-3 text-left">Arrival DateTime</th>
                    <th class="px-6 py-3 text-left">Reservation Date</th>
                    <th class="px-6 py-3 text-left">Fare</th>
                    <th class="px-6 py-3 text-left">Cancel</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    String username = request.getParameter("username");
                    if (username != null && !username.trim().isEmpty()) {
                        try {
                            String emailQuery = "SELECT EmailAddress FROM Customer WHERE Username = ?";
                            PreparedStatement emailStmt = conn.prepareStatement(emailQuery);
                            emailStmt.setString(1, username);
                            ResultSet emailRs = emailStmt.executeQuery();
                            if (emailRs.next()) {
                                String customerEmail = emailRs.getString("EmailAddress");

                                // Updated query to fetch past bookings based on departure date being in the past
                                String bookingsQuery = "SELECT r.ReservationID, r.ReservationDate, r.TotalFare, " +
                                                       "ts.DepartureDatetime, ts.ArrivalDatetime, t.TransitLine, " +
                                                       "s1.StationName AS Origin, s2.StationName AS Destination " +
                                                       "FROM Reservations r " +
                                                       "JOIN TrainSchedule ts ON r.ScheduleID = ts.ScheduleID " +
                                                       "JOIN Trains t ON ts.TrainID = t.TrainID " +
                                                       "JOIN Stations s1 ON ts.OriginID = s1.StationID " +
                                                       "JOIN Stations s2 ON ts.DestinationID = s2.StationID " +
                                                       "WHERE r.EmailAddress = ? " +
                                                       "AND ts.DepartureDatetime < CURRENT_TIMESTAMP"; // Filter by departure date

                                PreparedStatement bookingsStmt = conn.prepareStatement(bookingsQuery);
                                bookingsStmt.setString(1, customerEmail);

                                ResultSet bookingsRs = bookingsStmt.executeQuery();
                                while (bookingsRs.next()) {
                %>
                <tr class="border-b hover:bg-gray-100">
                    <td class="px-6 py-4 text-sm text-gray-700"><%= bookingsRs.getInt("ReservationID") %></td>
                    <td class="px-6 py-4 text-sm text-gray-700"><%= bookingsRs.getString("TransitLine") %></td>
                    <td class="px-6 py-4 text-sm text-gray-700"><%= bookingsRs.getString("Origin") %></td>
                    <td class="px-6 py-4 text-sm text-gray-700"><%= bookingsRs.getString("Destination") %></td>
                    <td class="px-6 py-4 text-sm text-gray-700"><%= bookingsRs.getTimestamp("DepartureDatetime") %></td>
                    <td class="px-6 py-4 text-sm text-gray-700"><%= bookingsRs.getTimestamp("ArrivalDatetime") %></td>
                    <td class="px-6 py-4 text-sm text-gray-700"><%= bookingsRs.getDate("ReservationDate") %></td>
                    <td class="px-6 py-4 text-sm text-gray-700">$<%= bookingsRs.getBigDecimal("TotalFare") %></td>
                    <td class="px-6 py-4 text-sm">
                        <form action="cancelReservation.jsp" method="post" style="display:inline;">
                            <input type="hidden" name="reservationID" value="<%= bookingsRs.getInt("ReservationID") %>">
                            <input type="hidden" name="username" value="<%= username %>">
                            <button type="submit" class="bg-red-600 hover:bg-red-700 text-white py-2 px-4 rounded-lg">Cancel</button>
                        </form>
                    </td>
                </tr>
                <% 
                                }
                            } else {
                                out.println("<tr><td colspan='9' class='px-6 py-4 text-center text-gray-700'>No past bookings found for this user.</td></tr>");
                            }
                        } catch (Exception e) {
                            out.println("<tr><td colspan='9' class='px-6 py-4 text-center text-gray-700'>Error fetching data. Please try again later.</td></tr>");
                        }
                    } else {
                        out.println("<tr><td colspan='9' class='px-6 py-4 text-center text-gray-700'>Username is required to view past bookings.</td></tr>");
                    }
                %>
            </tbody>
        </table>

        <form action="customerDashboard.jsp" method="post" class="mt-6 text-center">
            <input type="hidden" name="username" value="<%= username %>">
            <button type="submit" class="bg-indigo-600 hover:bg-indigo-700 text-white py-2 px-6 rounded-lg">Go to Dashboard</button>
        </form>
    </div>
    
</body>
</html>
--%>

<%@ include file="dbConnection.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Past Bookings</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>

<body class="bg-gray-100 min-h-screen flex items-center justify-center">
    <div class="bg-white shadow-md rounded-lg px-6 py-8 max-w-6xl w-full">
        <h1 class="text-3xl font-bold text-center text-gray-800 mb-6">Your Past Bookings</h1>

        <!-- Bookings Table -->
        <div class="overflow-x-auto">
            <table class="min-w-full bg-white border-collapse table-auto">
                <thead>
                    <tr class="bg-blue-600 text-white">
                        <th class="px-4 py-2 text-left">Reservation ID</th>
                        <th class="px-4 py-2 text-left">Transit Line</th>
                        <th class="px-4 py-2 text-left">Origin</th>
                        <th class="px-4 py-2 text-left">Destination</th>
                        <th class="px-4 py-2 text-left">Departure DateTime</th>
                        <th class="px-4 py-2 text-left">Arrival DateTime</th>
                        <th class="px-4 py-2 text-left">Reservation Date</th>
                        <th class="px-4 py-2 text-left">Fare</th>
                        <th class="px-4 py-2 text-left">Cancel</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                        String username = request.getParameter("username");
                        if (username != null && !username.trim().isEmpty()) {
                            try {
                                String emailQuery = "SELECT EmailAddress FROM Customer WHERE Username = ?";
                                PreparedStatement emailStmt = conn.prepareStatement(emailQuery);
                                emailStmt.setString(1, username);
                                ResultSet emailRs = emailStmt.executeQuery();
                                if (emailRs.next()) {
                                    String customerEmail = emailRs.getString("EmailAddress");

                                    String bookingsQuery = "SELECT r.ReservationID, r.ReservationDate, r.TotalFare, " +
                                                           "ts.DepartureDatetime, ts.ArrivalDatetime, t.TransitLine, " +
                                                           "s1.StationName AS Origin, s2.StationName AS Destination " +
                                                           "FROM Reservations r " +
                                                           "JOIN TrainSchedule ts ON r.ScheduleID = ts.ScheduleID " +
                                                           "JOIN Trains t ON ts.TrainID = t.TrainID " +
                                                           "JOIN Stations s1 ON ts.OriginID = s1.StationID " +
                                                           "JOIN Stations s2 ON ts.DestinationID = s2.StationID " +
                                                           "WHERE r.EmailAddress = ? " +
                                                           "AND ts.DepartureDatetime < CURRENT_TIMESTAMP";

                                    PreparedStatement bookingsStmt = conn.prepareStatement(bookingsQuery);
                                    bookingsStmt.setString(1, customerEmail);

                                    ResultSet bookingsRs = bookingsStmt.executeQuery();
                                    while (bookingsRs.next()) {
                    %>
                    <tr class="border-b hover:bg-gray-50">
                        <td class="px-4 py-2"><%= bookingsRs.getInt("ReservationID") %></td>
                        <td class="px-4 py-2"><%= bookingsRs.getString("TransitLine") %></td>
                        <td class="px-4 py-2"><%= bookingsRs.getString("Origin") %></td>
                        <td class="px-4 py-2"><%= bookingsRs.getString("Destination") %></td>
                        <td class="px-4 py-2"><%= bookingsRs.getTimestamp("DepartureDatetime") %></td>
                        <td class="px-4 py-2"><%= bookingsRs.getTimestamp("ArrivalDatetime") %></td>
                        <td class="px-4 py-2"><%= bookingsRs.getDate("ReservationDate") %></td>
                        <td class="px-4 py-2">$<%= bookingsRs.getBigDecimal("TotalFare") %></td>
                        <td class="px-4 py-2">
                            <form action="cancelReservation.jsp" method="post" class="inline-block">
                                <input type="hidden" name="reservationID" value="<%= bookingsRs.getInt("ReservationID") %>">
                                <input type="hidden" name="username" value="<%= username %>">
                                <button type="submit" class="bg-red-600 text-white px-4 py-2 rounded-md hover:bg-red-700 transition">
                                    Cancel
                                </button>
                            </form>
                        </td>
                    </tr>
                    <% 
                                    }
                                } else {
                    %>
                    <tr>
                        <td colspan="9" class="text-center py-4 text-gray-500">No past bookings found for this user.</td>
                    </tr>
                    <% 
                                }
                            } catch (Exception e) {
                    %>
                    <tr>
                        <td colspan="9" class="text-center py-4 text-red-500">Error fetching data. Please try again later.</td>
                    </tr>
                    <% 
                            }
                        } else {
                    %>
                    <tr>
                        <td colspan="9" class="text-center py-4 text-gray-500">Username is required to view past bookings.</td>
                    </tr>
                    <% 
                        }
                    %>
                </tbody>
            </table>
        </div>

        <!-- Dashboard Button -->
        <div class="text-center mt-6 mb-6">
    		<form action="customerDashboard.jsp" method="post">
       			 <input type="hidden" name="username" value="<%= username %>">
       			 <button type="submit" class="bg-gray-800 text-white py-3 px-6 rounded-md hover:bg-gray-700 transition">
           			 Go to Dashboard
        		 </button>
    		</form>
		</div>
    </div>
</body>

</html>
