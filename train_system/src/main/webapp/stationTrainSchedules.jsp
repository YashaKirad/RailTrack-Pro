<%-- <%@ include file="dbConnection.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Train Schedules by Station</title>
    <!-- Add Tailwind CSS via CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 text-gray-800 font-sans">

    <!-- Header -->
    <header class="text-center py-6">
        <h1 class="text-3xl font-semibold text-gray-900">View Train Schedules for a Station</h1>
    </header>

    <!-- Search Form -->
    <div class="max-w-4xl mx-auto p-6 bg-white shadow-md rounded-lg">
        <form method="get">
            <div class="mb-4">
                <label for="stationID" class="block text-lg font-medium text-gray-700">Select Station:</label>
                <select name="stationID" id="stationID" class="input-field w-full p-3 border border-gray-300 rounded-md" required>
                    <% 
                        // Fetch station details
                        String stationQuery = "SELECT StationID, StationName FROM Stations";
                        PreparedStatement stationStmt = ((Connection) request.getAttribute("dbConnection")).prepareStatement(stationQuery);
                        ResultSet stationRs = stationStmt.executeQuery();
                        while (stationRs.next()) { 
                    %>
                    <option value="<%= stationRs.getInt("StationID") %>">
                        <%= stationRs.getString("StationName") %>
                    </option>
                    <% } %>
                </select>
            </div>
            <div class="mb-4">
                <label for="role" class="block text-lg font-medium text-gray-700">Show schedules where the station is:</label>
                <select name="role" id="role" class="input-field w-full p-3 border border-gray-300 rounded-md" required>
                    <option value="origin">Origin</option>
                    <option value="destination">Destination</option>
                </select>
            </div>
            <button type="submit" class="w-full bg-gray-800 text-white py-3 px-6 rounded-md hover:bg-gray-700 transition">View Schedules</button>
        </form>
    </div>

    <!-- Results -->
    <div class="max-w-4xl mx-auto mt-6 px-4">
        <% 
            String stationID = request.getParameter("stationID");
            String role = request.getParameter("role");

            if (stationID != null && role != null) {
                String query = "SELECT ts.ScheduleID, ts.TrainID, s1.StationName AS Origin, s2.StationName AS Destination, ts.DepartureDatetime, ts.ArrivalDatetime, ts.Fare " +
                               "FROM TrainSchedule ts " +
                               "JOIN Stations s1 ON ts.OriginID = s1.StationID " +
                               "JOIN Stations s2 ON ts.DestinationID = s2.StationID " +
                               "WHERE ts." + (role.equals("origin") ? "OriginID" : "DestinationID") + " = ?";
                try {
                    PreparedStatement stmt = ((Connection) request.getAttribute("dbConnection")).prepareStatement(query);
                    stmt.setInt(1, Integer.parseInt(stationID));
                    ResultSet rs = stmt.executeQuery();

                    if (!rs.isBeforeFirst()) {
                        out.println("<p class='text-lg text-gray-700'>No schedules found for the selected station as " + role + ".</p>");
                    } else {
        %>
        <table class="min-w-full table-auto bg-white shadow-md rounded-lg mt-6">
            <thead class="bg-gray-800 text-white">
                <tr>
                    <th class="px-6 py-3 text-left">Schedule ID</th>
                    <th class="px-6 py-3 text-left">Train ID</th>
                    <th class="px-6 py-3 text-left">Origin</th>
                    <th class="px-6 py-3 text-left">Destination</th>
                    <th class="px-6 py-3 text-left">Departure</th>
                    <th class="px-6 py-3 text-left">Arrival</th>
                    <th class="px-6 py-3 text-left">Fare</th>
                </tr>
            </thead>
            <tbody>
                <% while (rs.next()) { %>
                <tr class="border-b">
                    <td class="px-6 py-4"><%= rs.getInt("ScheduleID") %></td>
                    <td class="px-6 py-4"><%= rs.getInt("TrainID") %></td>
                    <td class="px-6 py-4"><%= rs.getString("Origin") %></td>
                    <td class="px-6 py-4"><%= rs.getString("Destination") %></td>
                    <td class="px-6 py-4"><%= rs.getTimestamp("DepartureDatetime") %></td>
                    <td class="px-6 py-4"><%= rs.getTimestamp("ArrivalDatetime") %></td>
                    <td class="px-6 py-4"><%= rs.getBigDecimal("Fare") %></td>
                </tr>
                <% } %>
            </tbody>
        </table>
        <% 
                    }
                } catch (Exception e) {
                    out.println("<p class='text-lg text-red-600'>Error: " + e.getMessage() + "</p>");
                }
            }
        %>
    </div>

    <!-- Back to Dashboard Button -->
    <div class="text-center mt-6">
        <form action="customerRepDashboard.jsp" method="post">
            <button type="submit" class="bg-gray-800 text-white py-3 px-6 rounded-md hover:bg-gray-700 transition">Back to Dashboard</button>
        </form>
    </div>

</body>
</html>
--%>


<%@ include file="dbConnection.jsp" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Train Schedules by Station</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>

<body class="bg-gray-100 min-h-screen flex flex-col items-center">

    <!-- Header -->
    <header class="text-center py-8">
        <h1 class="text-3xl font-bold text-gray-800">View Train Schedules for a Station</h1>
    </header>

    <!-- Search Form -->
    <div class="w-full max-w-4xl px-4">
        <div class="bg-white shadow-md rounded-lg p-6">
            <form method="get" class="space-y-4">
                <div>
                    <label for="stationID" class="block text-lg font-medium text-gray-700">Select Station:</label>
                    <select 
                        name="stationID" 
                        id="stationID" 
                        class="w-full p-3 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500" 
                        required>
                        <% 
                            String stationQuery = "SELECT StationID, StationName FROM Stations";
                            PreparedStatement stationStmt = ((Connection) request.getAttribute("dbConnection")).prepareStatement(stationQuery);
                            ResultSet stationRs = stationStmt.executeQuery();
                            while (stationRs.next()) { 
                        %>
                        <option value="<%= stationRs.getInt("StationID") %>">
                            <%= stationRs.getString("StationName") %>
                        </option>
                        <% } %>
                    </select>
                </div>
                <div>
                    <label for="role" class="block text-lg font-medium text-gray-700">Show schedules where the station is:</label>
                    <select 
                        name="role" 
                        id="role" 
                        class="w-full p-3 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500" 
                        required>
                        <option value="origin">Origin</option>
                        <option value="destination">Destination</option>
                    </select>
                </div>
                <button 
                    type="submit" 
                    class="w-full bg-blue-600 text-white py-3 rounded-md hover:bg-blue-700 transition">
                    View Schedules
                </button>
            </form>
        </div>
    </div>

    <!-- Results Section -->
    <div class="w-full max-w-4xl px-4 mt-6">
        <%
            String stationID = request.getParameter("stationID");
            String role = request.getParameter("role");

            if (stationID != null && role != null) {
                String query = "SELECT ts.ScheduleID, ts.TrainID, s1.StationName AS Origin, s2.StationName AS Destination, ts.DepartureDatetime, ts.ArrivalDatetime, ts.Fare " +
                               "FROM TrainSchedule ts " +
                               "JOIN Stations s1 ON ts.OriginID = s1.StationID " +
                               "JOIN Stations s2 ON ts.DestinationID = s2.StationID " +
                               "WHERE ts." + (role.equals("origin") ? "OriginID" : "DestinationID") + " = ?";
                try {
                    PreparedStatement stmt = ((Connection) request.getAttribute("dbConnection")).prepareStatement(query);
                    stmt.setInt(1, Integer.parseInt(stationID));
                    ResultSet rs = stmt.executeQuery();

                    if (!rs.isBeforeFirst()) {
                        out.println("<p class='text-lg text-gray-700'>No schedules found for the selected station as " + role + ".</p>");
                    } else {
        %>
        <div class="bg-white shadow-md rounded-lg overflow-hidden">
            <table class="min-w-full table-auto border-collapse">
                <thead class="bg-blue-600 text-white">
                    <tr>
                        <th class="px-6 py-3 text-left">Schedule ID</th>
                        <th class="px-6 py-3 text-left">Train ID</th>
                        <th class="px-6 py-3 text-left">Origin</th>
                        <th class="px-6 py-3 text-left">Destination</th>
                        <th class="px-6 py-3 text-left">Departure</th>
                        <th class="px-6 py-3 text-left">Arrival</th>
                        <th class="px-6 py-3 text-left">Fare</th>
                    </tr>
                </thead>
                <tbody>
                    <% while (rs.next()) { %>
                    <tr class="border-b hover:bg-gray-50">
                        <td class="px-6 py-4"><%= rs.getInt("ScheduleID") %></td>
                        <td class="px-6 py-4"><%= rs.getInt("TrainID") %></td>
                        <td class="px-6 py-4"><%= rs.getString("Origin") %></td>
                        <td class="px-6 py-4"><%= rs.getString("Destination") %></td>
                        <td class="px-6 py-4"><%= rs.getTimestamp("DepartureDatetime") %></td>
                        <td class="px-6 py-4"><%= rs.getTimestamp("ArrivalDatetime") %></td>
                        <td class="px-6 py-4"><%= rs.getBigDecimal("Fare") %></td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
        <% 
                    }
                } catch (Exception e) {
                    out.println("<p class='text-lg text-red-600'>Error: " + e.getMessage() + "</p>");
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
</body>

</html>

