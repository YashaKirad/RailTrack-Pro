<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ include file="dbConnection.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customers by Transit Line</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <script>
        function validateForm() {
            const transitLine = document.getElementById('transitLine').value;
            const date = document.getElementById('date').value;
            const resultsContainer = document.getElementById('results-container');
            const noResultsMessage = document.getElementById('no-results');
            const resultsTable = document.getElementById('results-table');

            if (!transitLine || !date) {
                alert('Please select both a transit line and a date.');
                return false;
            }

            // Hide/show elements based on results
            const rows = resultsTable.querySelectorAll('tbody tr');
            if (rows.length === 0) {
                noResultsMessage.classList.remove('hidden');
                resultsTable.classList.add('hidden');
            } else {
                noResultsMessage.classList.add('hidden');
                resultsTable.classList.remove('hidden');
            }

            return true;
        }
    </script>
</head>
<body class="bg-gray-100 min-h-screen">
    <div class="container mx-auto px-4 py-8 max-w-4xl">
        <h1 class="text-3xl font-bold text-center mb-8 text-gray-800">View Customers by Transit Line</h1>

        <!-- Search Form -->
        <div class="bg-white shadow-md rounded-lg p-6 mb-6">
            <form method="get" onsubmit="return validateForm()">
                <div class="grid md:grid-cols-3 gap-4">
                    <div>
                        <label for="transitLine" class="block text-sm font-medium text-gray-700 mb-2">Transit Line</label>
                        <select 
                            name="transitLine" 
                            id="transitLine" 
                            class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
                            required
                        >
                            <% 
                                // Fetch transit line details
                                String transitQuery = "SELECT DISTINCT TransitLine FROM Trains";
                                PreparedStatement transitStmt = ((Connection) request.getAttribute("dbConnection")).prepareStatement(transitQuery);
                                ResultSet transitRs = transitStmt.executeQuery();
                                while (transitRs.next()) { 
                            %>
                            <option value="<%= transitRs.getString("TransitLine") %>">
                                <%= transitRs.getString("TransitLine") %>
                            </option>
                            <% } %>
                        </select>
                    </div>
                    <div>
                        <label for="date" class="block text-sm font-medium text-gray-700 mb-2">Select Date</label>
                        <input 
                            type="date" 
                            name="date" 
                            id="date" 
                            class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
                            required
                        >
                    </div>
                    <div class="flex items-end">
                        <button 
                            type="submit" 
                            class="w-full bg-blue-600 text-white py-2 rounded-md hover:bg-blue-700 transition-colors"
                        >
                            View Customers
                        </button>
                    </div>
                </div>
            </form>
        </div>

        <!-- Results Container -->
        <div id="results-container" class="bg-white shadow-md rounded-lg overflow-hidden">
            <% 
                String transitLine = request.getParameter("transitLine");
                String date = request.getParameter("date");

                if (transitLine != null && date != null) {
                    String query = "SELECT c.FirstName, c.LastName, c.EmailAddress, r.ReservationID, ts.DepartureDatetime, ts.ArrivalDatetime " +
                                   "FROM Reservations r " +
                                   "JOIN TrainSchedule ts ON r.ScheduleID = ts.ScheduleID " +
                                   "JOIN Trains t ON ts.TrainID = t.TrainID " +
                                   "JOIN Customer c ON r.EmailAddress = c.EmailAddress " +
                                   "WHERE t.TransitLine = ? AND DATE(ts.DepartureDatetime) = ?";
                    try {
                        PreparedStatement stmt = ((Connection) request.getAttribute("dbConnection")).prepareStatement(query);
                        stmt.setString(1, transitLine);
                        stmt.setString(2, date);
                        ResultSet rs = stmt.executeQuery();

                        if (!rs.isBeforeFirst()) {
            %>
            <div id="no-results" class="text-center p-8 text-gray-500">
                <svg xmlns="http://www.w3.org/2000/svg" class="mx-auto mb-4 text-gray-300 w-12 h-12" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9.172 16.172a4 4 0 015.656 0M9 10h.01M15 10h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
                </svg>
                <p>No customers found for transit line: <b><%= transitLine %></b> on <b><%= date %></b>.</p>
            </div>
            <% 
                        } else { 
            %>
            <table id="results-table" class="w-full">
                <thead>
                    <tr class="bg-blue-600 text-white">
                        <th class="px-4 py-2">First Name</th>
                        <th class="px-4 py-2">Last Name</th>
                        <th class="px-4 py-2">Email</th>
                        <th class="px-4 py-2">Reservation ID</th>
                        <th class="px-4 py-2">Departure</th>
                        <th class="px-4 py-2">Arrival</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                        java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                        while (rs.next()) { 
                    %>
                    <tr class="border-b hover:bg-gray-50">
                        <td class="px-4 py-2"><%= rs.getString("FirstName") %></td>
                        <td class="px-4 py-2"><%= rs.getString("LastName") %></td>
                        <td class="px-4 py-2"><%= rs.getString("EmailAddress") %></td>
                        <td class="px-4 py-2"><%= rs.getInt("ReservationID") %></td>
                        <td class="px-4 py-2"><%= sdf.format(rs.getTimestamp("DepartureDatetime")) %></td>
                        <td class="px-4 py-2"><%= sdf.format(rs.getTimestamp("ArrivalDatetime")) %></td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
            <% 
                        }
                    } catch (Exception e) {
            %>
            <div class="text-center p-8 text-red-500">
                <p>Error: <%= e.getMessage() %></p>
            </div>
            <% 
                    }
                }
            %>
        </div>

        <!-- Back to Dashboard Button -->
        <div class="text-center mt-6 mb-6">
            <form action="customerRepDashboard.jsp" method="post">
                <button type="submit" class="bg-gray-800 text-white py-3 px-6 rounded-md hover:bg-gray-700 transition">
                    Back to Dashboard
                </button>
            </form>
        </div>
    </div>
</body>
</html>

