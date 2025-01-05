<%@ include file="dbConnection.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Buy Tickets</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100 font-sans">
    <header class="py-6">
        <h1 class="text-3xl font-bold text-center text-gray-800">Search for Train Schedules</h1>
    </header>

    <div class="container mx-auto px-4">
        <!-- Search Form -->
        <div class="bg-white p-6 rounded-lg shadow-md mb-8">
            <form method="get" class="space-y-4">
                <div>
                    <label for="origin" class="block text-lg font-semibold text-gray-700">Origin:</label>
                    <input type="text" name="origin" id="origin" required class="w-full p-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                </div>
                <div>
                    <label for="destination" class="block text-lg font-semibold text-gray-700">Destination:</label>
                    <input type="text" name="destination" id="destination" required class="w-full p-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                </div>
                <div>
                    <label for="travelDate" class="block text-lg font-semibold text-gray-700">Date of Travel:</label>
                    <input type="date" name="travelDate" id="travelDate" required class="w-full p-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                </div>
                <div>
                    <label for="sortBy" class="block text-lg font-semibold text-gray-700">Sort By:</label>
                    <select name="sortBy" id="sortBy" class="w-full p-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                        <option value="departure">Departure Time</option>
                        <option value="arrival">Arrival Time</option>
                        <option value="fare">Fare</option>
                    </select>
                </div>
                <input type="hidden" name="username" value="<%= request.getParameter("username") %>">
                <div class="text-center mt-8">
                    <button type="submit" class="bg-blue-600 text-white py-3 px-6 rounded-md hover:bg-blue-700 transition">Search</button>
                </div>
            </form>
        </div>

        <!-- Results Section -->
        <div class="bg-white p-6 rounded-lg shadow-md">
            <% 
                String origin = request.getParameter("origin");
                String destination = request.getParameter("destination");
                String travelDate = request.getParameter("travelDate");
                String sortBy = request.getParameter("sortBy");
                String username = request.getParameter("username");
                String showStopsFor = request.getParameter("showStopsFor");

                if (origin != null && destination != null && travelDate != null) {
                    String orderBy = "ts.DepartureDatetime";

                    if ("arrival".equals(sortBy)) {
                        orderBy = "ts.ArrivalDatetime";
                    } else if ("fare".equals(sortBy)) {
                        orderBy = "ts.Fare";
                    }

                    String query = "SELECT ts.ScheduleID, t.TransitLine, ts.DepartureDatetime, ts.ArrivalDatetime, ts.Fare " +
                                   "FROM TrainSchedule ts " +
                                   "JOIN Stations s1 ON ts.OriginID = s1.StationID " +
                                   "JOIN Stations s2 ON ts.DestinationID = s2.StationID " +
                                   "JOIN Trains t ON ts.TrainID = t.TrainID " +
                                   "WHERE s1.StationName = ? AND s2.StationName = ? AND DATE(ts.DepartureDatetime) = ? " +
                                   "ORDER BY " + orderBy;

                    PreparedStatement stmt = conn.prepareStatement(query);
                    stmt.setString(1, origin);
                    stmt.setString(2, destination);
                    stmt.setString(3, travelDate);

                    ResultSet rs = stmt.executeQuery();

                    if (rs.isBeforeFirst()) {
            %>
            <h2 class="text-2xl font-semibold text-gray-800 mb-4">Available Schedules</h2>
            <table class="w-full table-auto border-collapse">
                <thead class="bg-blue-600 text-white">
                    <tr>
                        <th class="px-4 py-2 text-left">Schedule ID</th>
                        <th class="px-4 py-2 text-left">Transit Line</th>
                        <th class="px-4 py-2 text-left">Departure</th>
                        <th class="px-4 py-2 text-left">Arrival</th>
                        <th class="px-4 py-2 text-left">Fare</th>
                        <th class="px-4 py-2 text-left">Action</th>
                    </tr>
                </thead>
                <tbody>
                    <% while (rs.next()) { 
                        int scheduleID = rs.getInt("ScheduleID");
                        String transitLine = rs.getString("TransitLine");
                        boolean isCurrentStopsRow = showStopsFor != null && showStopsFor.equals(String.valueOf(scheduleID));
                    %>
                    <tr class="border-b hover:bg-gray-50">
                        <td class="px-4 py-2"><%= scheduleID %></td>
                        <td class="px-4 py-2"><%= transitLine %></td>
                        <td class="px-4 py-2"><%= rs.getTimestamp("DepartureDatetime") %></td>
                        <td class="px-4 py-2"><%= rs.getTimestamp("ArrivalDatetime") %></td>
                        <td class="px-4 py-2"><%= rs.getBigDecimal("Fare") %></td>
                        <td class="px-4 py-2 space-x-2">
                            <form action="ticketOptions.jsp" method="post" class="inline">
                                <input type="hidden" name="scheduleID" value="<%= scheduleID %>">
                                <input type="hidden" name="fare" value="<%= rs.getBigDecimal("Fare") %>">
                                <input type="hidden" name="username" value="<%= username %>">
                                <button type="submit" class="bg-blue-600 text-white px-4 py-2 rounded-lg hover:bg-blue-700 transition">Buy Tickets</button>
                            </form>
                            <form method="get" class="inline">
                                <input type="hidden" name="origin" value="<%= origin %>">
                                <input type="hidden" name="destination" value="<%= destination %>">
                                <input type="hidden" name="travelDate" value="<%= travelDate %>">
                                <input type="hidden" name="sortBy" value="<%= sortBy %>">
                                <input type="hidden" name="username" value="<%= username %>">
                                <input type="hidden" name="showStopsFor" value="<%= scheduleID %>">
                                <button type="submit" class="bg-yellow-500 text-white px-4 py-2 rounded-lg hover:bg-yellow-600 transition">See Stops</button>
                            </form>
                        </td>
                    </tr>
                    <% if (isCurrentStopsRow) {
                    	String stopsQuery = "SELECT s.StationName, st.StopOrder " +
                                "FROM Stops st " +
                                "JOIN Stations s ON st.StationID = s.StationID " +
                                "WHERE st.TransitLine = ? " +
                                "ORDER BY st.StopOrder";

                    PreparedStatement stopsStmt = conn.prepareStatement(stopsQuery);
                    stopsStmt.setString(1, transitLine);
                    ResultSet stopsRs = stopsStmt.executeQuery();
                    %>
                    <tr class="bg-gray-50">
                        <td colspan="6" class="px-4 py-6">
                            <div class="bg-white rounded-lg border border-gray-200 shadow-sm overflow-hidden">
                                <div class="px-6 py-4 bg-blue-50 border-b border-gray-200">
                                    <h3 class="text-xl font-semibold text-gray-800">Route Stops for <%= transitLine %></h3>
                                </div>
                                <div class="p-6 max-h-96 overflow-y-auto">
                                    <div class="relative">
                                        <div class="absolute left-5 top-0 bottom-0 w-0.5 bg-blue-200"></div>
                                        <ul class="relative space-y-6">
                                            <% 
                                            int stopCount = 0;
                                            while (stopsRs.next()) { 
                                                stopCount++;
                                                String stationName = stopsRs.getString("StationName");
                                                boolean isUserOrigin = stationName.equals(origin);
                                                boolean isUserDestination = stationName.equals(destination);
                                            %>
                                            <li class="flex items-center relative">
                                                <div class="z-10 flex items-center justify-center">
                                                    <div class="<%= 
                                                        isUserOrigin ? "bg-green-500" : 
                                                        isUserDestination ? "bg-red-500" : 
                                                        "bg-blue-500" %> w-5 h-5 rounded-full absolute left-4 transform -translate-x-1/2"></div>
                                                </div>
                                                <div class="pl-12 w-full">
                                                    <div class="<%= 
                                                        isUserOrigin ? "border-green-300 bg-green-50" : 
                                                        isUserDestination ? "border-red-300 bg-red-50" : 
                                                        "border-gray-200 bg-white" %> border rounded-lg p-4 shadow-sm">
                                                        <div class="flex justify-between items-center">
                                                            <h4 class="text-lg font-medium <%= 
                                                                isUserOrigin ? "text-green-800" : 
                                                                isUserDestination ? "text-red-800" : 
                                                                "text-gray-800" %>"><%= stationName %></h4>
                                                            <% if (isUserOrigin) { %>
                                                                <span class="px-2 py-1 bg-green-100 text-green-800 text-xs rounded-full">Your Origin</span>
                                                            <% } else if (isUserDestination) { %>
                                                                <span class="px-2 py-1 bg-red-100 text-red-800 text-xs rounded-full">Your Destination</span>
                                                            <% } %>
                                                        </div>
                                                    </div>
                                                </div>
                                            </li>
                                            <% } %>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <% 
                        }
                    } 
                    %>
                </tbody>
            </table>
            <% 
                    } else { 
            %>
            <p class="text-center text-gray-500 mt-4">No schedules found for the given criteria.</p>
            <% 
                    }
                }
            %>
        </div>
    </div>
</body>
</html>