<%-- <%@ include file="dbConnection.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Current Bookings</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>

<body class="bg-gray-100 font-sans">
    <div class="container mx-auto p-6">
        <h1 class="text-4xl font-bold text-center text-gray-800 mb-6">Your Current Bookings</h1>
        
        <div class="bg-white shadow-lg rounded-lg overflow-hidden">
            <table class="min-w-full bg-white table-auto">
                <thead>
                    <tr class="bg-gray-800 text-white">
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
                        boolean hasBookings = false; // Flag to check if there are bookings
                        if (username != null && !username.trim().isEmpty()) {
                            try {
                                String emailQuery = "SELECT EmailAddress FROM Customer WHERE Username = ?";
                                PreparedStatement emailStmt = conn.prepareStatement(emailQuery);
                                emailStmt.setString(1, username);
                                ResultSet emailRs = emailStmt.executeQuery();
                                if (emailRs.next()) {
                                    String customerEmail = emailRs.getString("EmailAddress");

                                    // Updated query to fetch current bookings based on departure date being in the future
                                    String bookingsQuery = "SELECT r.ReservationID, r.ReservationDate, r.TotalFare, " +
                                                           "ts.DepartureDatetime, ts.ArrivalDatetime, t.TransitLine, " +
                                                           "s1.StationName AS Origin, s2.StationName AS Destination " +
                                                           "FROM Reservations r " +
                                                           "JOIN TrainSchedule ts ON r.ScheduleID = ts.ScheduleID " +
                                                           "JOIN Trains t ON ts.TrainID = t.TrainID " +
                                                           "JOIN Stations s1 ON ts.OriginID = s1.StationID " +
                                                           "JOIN Stations s2 ON ts.DestinationID = s2.StationID " +
                                                           "WHERE r.EmailAddress = ? " +
                                                           "AND ts.DepartureDatetime >= CURRENT_TIMESTAMP"; // Filter by upcoming bookings

                                    PreparedStatement bookingsStmt = conn.prepareStatement(bookingsQuery);
                                    bookingsStmt.setString(1, customerEmail);

                                    ResultSet bookingsRs = bookingsStmt.executeQuery();
                                    while (bookingsRs.next()) {
                                        hasBookings = true; // Set flag to true if bookings exist
                    %>
                    <tr class="border-b hover:bg-gray-100">
                        <td class="px-6 py-4"><%= bookingsRs.getInt("ReservationID") %></td>
                        <td class="px-6 py-4"><%= bookingsRs.getString("TransitLine") %></td>
                        <td class="px-6 py-4"><%= bookingsRs.getString("Origin") %></td>
                        <td class="px-6 py-4"><%= bookingsRs.getString("Destination") %></td>
                        <td class="px-6 py-4"><%= bookingsRs.getTimestamp("DepartureDatetime") %></td>
                        <td class="px-6 py-4"><%= bookingsRs.getTimestamp("ArrivalDatetime") %></td>
                        <td class="px-6 py-4"><%= bookingsRs.getDate("ReservationDate") %></td>
                        <td class="px-6 py-4">$<%= bookingsRs.getBigDecimal("TotalFare") %></td>
                        <td class="px-6 py-4">
                            <form action="cancelReservation.jsp" method="post" class="inline-block">
                                <input type="hidden" name="reservationID" value="<%= bookingsRs.getInt("ReservationID") %>">
                                <input type="hidden" name="username" value="<%= username %>">
                                <button type="submit" class="bg-red-500 text-white px-4 py-2 rounded-lg hover:bg-red-600 transition duration-300">Cancel</button>
                            </form>
                        </td>
                    </tr>
                    <% 
                                    }
                                    if (!hasBookings) {
                                        out.println("<tr><td colspan='9' class='text-center py-4'>No current bookings found for this user.</td></tr>");
                                    }
                                } else {
                                    out.println("<tr><td colspan='9' class='text-center py-4'>No current bookings found for this user.</td></tr>");
                                }
                            } catch (Exception e) {
                                out.println("<tr><td colspan='9' class='text-center py-4'>Error fetching data. Please try again later.</td></tr>");
                            }
                        } else {
                            out.println("<tr><td colspan='9' class='text-center py-4'>Username is required to view current bookings.</td></tr>");
                        }
                    %>
                </tbody>
            </table>

            <!-- Dashboard Button -->
            <div class="text-center mt-6">
                <form action="customerDashboard.jsp" method="post">
                    <input type="hidden" name="username" value="<%= username %>">
                    <button type="submit" class="bg-gray-300 text-gray-800 px-6 py-2 rounded-lg hover:bg-gray-400 transition duration-300">Go to Dashboard</button>
                </form>
            </div>
        </div>
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
    <title>Current Bookings</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>

<body class="bg-gray-100 min-h-screen flex items-center justify-center">
    <div class="bg-white shadow-md rounded-lg px-6 py-8 max-w-5xl w-full">
        <h1 class="text-3xl font-bold text-center text-gray-800 mb-6">Your Current Bookings</h1>

        <!-- Table Section -->
        <div class="overflow-x-auto">
            <table class="w-full table-auto border-collapse">
                <thead>
                    <tr class="bg-blue-600 text-white">
                        <th class="px-4 py-2 text-left">Reservation ID</th>
                        <th class="px-4 py-2 text-left">Transit Line</th>
                        <th class="px-4 py-2 text-left">Origin</th>
                        <th class="px-4 py-2 text-left">Destination</th>
                        <th class="px-4 py-2 text-left">Departure</th>
                        <th class="px-4 py-2 text-left">Arrival</th>
                        <th class="px-4 py-2 text-left">Reservation Date</th>
                        <th class="px-4 py-2 text-left">Fare</th>
                        <th class="px-4 py-2 text-left">Cancel</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                        String username = request.getParameter("username");
                        boolean hasBookings = false;
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
                                                           "AND ts.DepartureDatetime >= CURRENT_TIMESTAMP";

                                    PreparedStatement bookingsStmt = conn.prepareStatement(bookingsQuery);
                                    bookingsStmt.setString(1, customerEmail);

                                    ResultSet bookingsRs = bookingsStmt.executeQuery();
                                    while (bookingsRs.next()) {
                                        hasBookings = true;
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
                                    if (!hasBookings) {
                    %>
                    <tr>
                        <td colspan="9" class="text-center py-4 text-gray-500">No current bookings found for this user.</td>
                    </tr>
                    <% 
                                    }
                                } else {
                    %>
                    <tr>
                        <td colspan="9" class="text-center py-4 text-gray-500">No current bookings found for this user.</td>
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
                        <td colspan="9" class="text-center py-4 text-gray-500">Username is required to view current bookings.</td>
                    </tr>
                    <% 
                        }
                    %>
                </tbody>
            </table>
        </div>

        <!-- Dashboard Button -->
        <div class="text-center mt-6">
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
