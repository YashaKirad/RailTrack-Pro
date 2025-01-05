<%-- <%@ include file="dbConnection.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit/Delete Train Schedules</title>
    <!-- Add Tailwind CSS via CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 text-gray-800 font-sans">

    <!-- Header -->
    <header class="text-center py-6">
        <h1 class="text-3xl font-semibold text-gray-900">Edit or Delete Train Schedules</h1>
    </header>

    <!-- Train Schedules Table -->
    <% 
        String query = "SELECT ScheduleID, TrainID, OriginID, DestinationID, DepartureDatetime, ArrivalDatetime, Fare FROM TrainSchedule";
        PreparedStatement stmt = ((Connection) request.getAttribute("dbConnection")).prepareStatement(query);
        ResultSet rs = stmt.executeQuery();
    %>

    <form method="post" action="updateTrainSchedule.jsp">
        <div class="overflow-x-auto px-4">
            <table class="min-w-full table-auto bg-white border-collapse border border-gray-300">
                <thead>
                    <tr class="bg-gray-800 text-white">
                        <th class="px-2 py-2 w-16">Sched ID</th>
                        <th class="px-2 py-2 w-16">Train ID</th>
                        <th class="px-2 py-2 w-16">Origin</th>
                        <th class="px-2 py-2 w-16">Dest</th>
                        <th class="px-2 py-2 w-32">Departure</th>
                        <th class="px-2 py-2 w-32">Arrival</th>
                        <th class="px-2 py-2 w-16">Fare</th>
                        <th class="px-2 py-2 w-24">Action</th>
                    </tr>
                </thead>
                <tbody>
                    <% while (rs.next()) { %>
                        <tr class="border-b">
                            <td class="px-2 py-2 text-center"><%= rs.getInt("ScheduleID") %></td>
                            <td class="px-2 py-2"><input type="text" name="trainID_<%= rs.getInt("ScheduleID") %>" value="<%= rs.getInt("TrainID") %>" class="w-full border p-1 rounded-md text-sm" /></td>
                            <td class="px-2 py-2"><input type="text" name="originID_<%= rs.getInt("ScheduleID") %>" value="<%= rs.getInt("OriginID") %>" class="w-full border p-1 rounded-md text-sm" /></td>
                            <td class="px-2 py-2"><input type="text" name="destinationID_<%= rs.getInt("ScheduleID") %>" value="<%= rs.getInt("DestinationID") %>" class="w-full border p-1 rounded-md text-sm" /></td>
                            <td class="px-2 py-2"><input type="datetime-local" name="departure_<%= rs.getInt("ScheduleID") %>" value="<%= rs.getTimestamp("DepartureDatetime") %>" class="w-full border p-1 rounded-md text-sm" /></td>
                            <td class="px-2 py-2"><input type="datetime-local" name="arrival_<%= rs.getInt("ScheduleID") %>" value="<%= rs.getTimestamp("ArrivalDatetime") %>" class="w-full border p-1 rounded-md text-sm" /></td>
                            <td class="px-2 py-2"><input type="number" step="0.01" name="fare_<%= rs.getInt("ScheduleID") %>" value="<%= rs.getBigDecimal("Fare") %>" class="w-full border p-1 rounded-md text-sm" /></td>
                            <td class="px-2 py-2 text-center">
                                <div class="flex flex-col space-y-2">
                                    <button type="submit" name="update" value="<%= rs.getInt("ScheduleID") %>" class="bg-blue-600 text-white py-1 px-2 rounded-md hover:bg-blue-500 text-sm">Update</button>
                                    <button type="submit" name="delete" value="<%= rs.getInt("ScheduleID") %>" class="bg-red-600 text-white py-1 px-2 rounded-md hover:bg-red-500 text-sm">Delete</button>
                                </div>
                            </td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </form>

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
    <title>Edit/Delete Train Schedules</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>

<body class="bg-gray-100 min-h-screen flex flex-col items-center">
    <!-- Header -->
    <header class="text-center py-8">
        <h1 class="text-3xl font-bold text-gray-800">Edit or Delete Train Schedules</h1>
    </header>

    <!-- Train Schedules Table -->
    <%
        String query = "SELECT ScheduleID, TrainID, OriginID, DestinationID, DepartureDatetime, ArrivalDatetime, Fare FROM TrainSchedule";
        PreparedStatement stmt = ((Connection) request.getAttribute("dbConnection")).prepareStatement(query);
        ResultSet rs = stmt.executeQuery();
    %>

    <form method="post" action="updateTrainSchedule.jsp" class="w-full max-w-6xl px-4">
        <div class="overflow-x-auto bg-white shadow-md rounded-lg">
            <table class="min-w-full table-auto border-collapse">
                <thead>
                    <tr class="bg-blue-600 text-white">
                        <th class="px-4 py-2 text-left">Schedule ID</th>
                        <th class="px-4 py-2 text-left">Train ID</th>
                        <th class="px-4 py-2 text-left">Origin ID</th>
                        <th class="px-4 py-2 text-left">Destination ID</th>
                        <th class="px-4 py-2 text-left">Departure</th>
                        <th class="px-4 py-2 text-left">Arrival</th>
                        <th class="px-4 py-2 text-left">Fare</th>
                        <th class="px-4 py-2 text-center">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% while (rs.next()) { %>
                        <tr class="border-b hover:bg-gray-50">
                            <td class="px-4 py-2"><%= rs.getInt("ScheduleID") %></td>
                            <td class="px-4 py-2">
                                <input type="text" name="trainID_<%= rs.getInt("ScheduleID") %>" value="<%= rs.getInt("TrainID") %>" class="w-full border border-gray-300 p-2 rounded-md text-sm focus:ring-2 focus:ring-blue-500" />
                            </td>
                            <td class="px-4 py-2">
                                <input type="text" name="originID_<%= rs.getInt("ScheduleID") %>" value="<%= rs.getInt("OriginID") %>" class="w-full border border-gray-300 p-2 rounded-md text-sm focus:ring-2 focus:ring-blue-500" />
                            </td>
                            <td class="px-4 py-2">
                                <input type="text" name="destinationID_<%= rs.getInt("ScheduleID") %>" value="<%= rs.getInt("DestinationID") %>" class="w-full border border-gray-300 p-2 rounded-md text-sm focus:ring-2 focus:ring-blue-500" />
                            </td>
                            <td class="px-4 py-2">
                                <input type="datetime-local" name="departure_<%= rs.getInt("ScheduleID") %>" value="<%= rs.getTimestamp("DepartureDatetime") %>" class="w-full border border-gray-300 p-2 rounded-md text-sm focus:ring-2 focus:ring-blue-500" />
                            </td>
                            <td class="px-4 py-2">
                                <input type="datetime-local" name="arrival_<%= rs.getInt("ScheduleID") %>" value="<%= rs.getTimestamp("ArrivalDatetime") %>" class="w-full border border-gray-300 p-2 rounded-md text-sm focus:ring-2 focus:ring-blue-500" />
                            </td>
                            <td class="px-4 py-2">
                                <input type="number" step="0.01" name="fare_<%= rs.getInt("ScheduleID") %>" value="<%= rs.getBigDecimal("Fare") %>" class="w-full border border-gray-300 p-2 rounded-md text-sm focus:ring-2 focus:ring-blue-500" />
                            </td>
                            <td class="px-4 py-2 text-center">
                                <div class="flex flex-col space-y-2">
                                    <button type="submit" name="update" value="<%= rs.getInt("ScheduleID") %>" class="bg-blue-600 text-white py-1 px-2 rounded-md hover:bg-blue-700 text-sm transition">
                                        Update
                                    </button>
                                    <button type="submit" name="delete" value="<%= rs.getInt("ScheduleID") %>" class="bg-red-600 text-white py-1 px-2 rounded-md hover:bg-red-700 text-sm transition">
                                        Delete
                                    </button>
                                </div>
                            </td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </form>

    <!-- Back to Dashboard Button -->
    <div class="text-center mt-8 mb-6">
        <form action="customerRepDashboard.jsp" method="post">
            <button type="submit" class="bg-gray-800 text-white py-3 px-6 rounded-md hover:bg-gray-700 transition">
                Back to Dashboard
            </button>
        </form>
    </div>
</body>

</html>
