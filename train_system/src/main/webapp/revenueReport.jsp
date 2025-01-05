<%-- <%@ include file="dbConnection.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>Revenue Report</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            background-color: #f4f4f9;
        }
        .form-container {
            margin: 20px auto;
            width: 50%;
        }
        table {
            width: 80%;
            margin: 20px auto;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid #ccc;
            padding: 10px;
            text-align: center;
        }
        th {
            background-color: #444;
            color: white;
        }
        .input-field {
            margin: 10px 0;
            padding: 10px;
            width: 80%;
        }
        .button {
            padding: 10px 20px;
            margin: 10px;
            background-color: #444;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <h1>Revenue Report</h1>
    <div class="form-container">
        <form method="get">
            <label for="filterType">Filter By:</label>
            <select name="filterType" id="filterType" class="input-field" required>
                <option value="transitLine">Transit Line</option>
                <option value="customerName">Customer Name</option>
            </select>
            <label for="filterValue">Enter Value:</label>
            <input type="text" name="filterValue" id="filterValue" class="input-field" placeholder="Enter Transit Line or Customer Name" required>
            <button type="submit" class="button">Search</button>
        </form>
    </div>
    <div class="results-container">
        <% 
            String filterType = request.getParameter("filterType");
            String filterValue = request.getParameter("filterValue");

            if (filterType != null && filterValue != null) {
                String query = "";
                if (filterType.equals("transitLine")) {
                    query = "SELECT t.TransitLine, SUM(r.TotalFare) AS Revenue " +
                            "FROM Reservations r " +
                            "JOIN TrainSchedule ts ON r.ScheduleID = ts.ScheduleID " +
                            "JOIN Trains t ON ts.TrainID = t.TrainID " +
                            "WHERE t.TransitLine = ? " +
                            "GROUP BY t.TransitLine";
                } else if (filterType.equals("customerName")) {
                    query = "SELECT CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName, SUM(r.TotalFare) AS Revenue " +
                            "FROM Reservations r " +
                            "JOIN Customer c ON r.EmailAddress = c.EmailAddress " +
                            "WHERE CONCAT(c.FirstName, ' ', c.LastName) LIKE ? " +
                            "GROUP BY c.EmailAddress";
                }

                try {
                    PreparedStatement stmt = ((Connection) request.getAttribute("dbConnection")).prepareStatement(query);
                    stmt.setString(1, filterType.equals("transitLine") ? filterValue : "%" + filterValue + "%");
                    ResultSet rs = stmt.executeQuery();

                    if (!rs.isBeforeFirst()) {
                        out.println("<p>No revenue found for the specified filter.</p>");
                    } else {
        %>
        <table>
            <thead>
                <tr>
                    <% if (filterType.equals("transitLine")) { %>
                    <th>Transit Line</th>
                    <% } else { %>
                    <th>Customer Name</th>
                    <% } %>
                    <th>Revenue</th>
                </tr>
            </thead>
            <tbody>
                <% while (rs.next()) { %>
                <tr>
                    <% if (filterType.equals("transitLine")) { %>
                    <td><%= rs.getString("TransitLine") %></td>
                    <% } else { %>
                    <td><%= rs.getString("CustomerName") %></td>
                    <% } %>
                    <td><%= rs.getBigDecimal("Revenue") %></td>
                </tr>
                <% } %>
            </tbody>
        </table>
        <% 
                    }
                } catch (Exception e) {
                    out.println("<p>Error: " + e.getMessage() + "</p>");
                }
            }
        %>
    </div>
     <form action="adminDashboard.jsp" method="post">
            <button type="submit" class="button">Dashboard</button>
        </form>
</body>
</html>
--%>







<%-- <%@ include file="dbConnection.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>Revenue Report</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            background-color: #f4f4f9;
        }
        .form-container {
            margin: 20px auto;
            width: 50%;
        }
        table {
            width: 80%;
            margin: 20px auto;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid #ccc;
            padding: 10px;
            text-align: center;
        }
        th {
            background-color: #444;
            color: white;
        }
        .input-field {
            margin: 10px 0;
            padding: 10px;
            width: 80%;
        }
        .button {
            padding: 10px 20px;
            margin: 10px;
            background-color: #444;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <h1>Revenue Report</h1>
    <div class="form-container">
        <form method="get">
            <label for="filterType">Filter By:</label>
            <select name="filterType" id="filterType" class="input-field" required>
                <option value="transitLine">Transit Line</option>
                <option value="customerName">Customer Name</option>
            </select>
            <label for="filterValue">Enter Value:</label>
            <input type="text" name="filterValue" id="filterValue" class="input-field" placeholder="Enter Transit Line or Customer Name" required>
            <button type="submit" class="button">Search</button>
        </form>
    </div>
    <div class="results-container">
        <% 
            String filterType = request.getParameter("filterType");
            String filterValue = request.getParameter("filterValue");

            if (filterType != null && filterValue != null) {
                String query = "";
                if (filterType.equals("transitLine")) {
                    query = "SELECT r.ReservationID, r.ScheduleID, r.EmailAddress, r.ReservationDate, r.TotalFare, " +
                            "t.TransitLine, ts.DepartureDatetime, ts.ArrivalDatetime " +
                            "FROM Reservations r " +
                            "JOIN TrainSchedule ts ON r.ScheduleID = ts.ScheduleID " +
                            "JOIN Trains t ON ts.TrainID = t.TrainID " +
                            "WHERE t.TransitLine = ? " +
                            "ORDER BY r.ReservationDate ASC";
                } else if (filterType.equals("customerName")) {
                    query = "SELECT r.ReservationID, r.ScheduleID, r.EmailAddress, r.ReservationDate, r.TotalFare, " +
                            "t.TransitLine, ts.DepartureDatetime, ts.ArrivalDatetime " +
                            "FROM Reservations r " +
                            "JOIN TrainSchedule ts ON r.ScheduleID = ts.ScheduleID " +
                            "JOIN Trains t ON ts.TrainID = t.TrainID " +
                            "JOIN Customer c ON r.EmailAddress = c.EmailAddress " +
                            "WHERE CONCAT(c.FirstName, ' ', c.LastName) LIKE ? " +
                            "ORDER BY r.ReservationDate ASC";
                }

                try {
                    PreparedStatement stmt = ((Connection) request.getAttribute("dbConnection")).prepareStatement(query);
                    stmt.setString(1, filterType.equals("transitLine") ? filterValue : "%" + filterValue + "%");
                    ResultSet rs = stmt.executeQuery();

                    double totalRevenue = 0.0;

                    if (!rs.isBeforeFirst()) {
                        out.println("<p>No reservations found for the specified filter.</p>");
                    } else {
        %>
        <table>
            <thead>
                <tr>
                    <th>Reservation ID</th>
                    <th>Schedule ID</th>
                    <th>Email Address</th>
                    <th>Reservation Date</th>
                    <th>Transit Line</th>
                    <th>Departure Datetime</th>
                    <th>Arrival Datetime</th>
                    <th>Total Fare</th>
                </tr>
            </thead>
            <tbody>
                <% while (rs.next()) { 
                    totalRevenue += rs.getDouble("TotalFare");
                %>
                <tr>
                    <td><%= rs.getInt("ReservationID") %></td>
                    <td><%= rs.getInt("ScheduleID") %></td>
                    <td><%= rs.getString("EmailAddress") %></td>
                    <td><%= rs.getDate("ReservationDate") %></td>
                    <td><%= rs.getString("TransitLine") %></td>
                    <td><%= rs.getTimestamp("DepartureDatetime") %></td>
                    <td><%= rs.getTimestamp("ArrivalDatetime") %></td>
                    <td>$<%= rs.getBigDecimal("TotalFare") %></td>
                </tr>
                <% } %>
            </tbody>
            <tfoot>
                <tr>
                    <td colspan="7"><strong>Total Revenue:</strong></td>
                    <td><strong>$<%= String.format("%.2f", totalRevenue) %></strong></td>
                </tr>
            </tfoot>
        </table>
        <% 
                    }
                } catch (Exception e) {
                    out.println("<p>Error: " + e.getMessage() + "</p>");
                }
            }
        %>
    </div>
    <form action="adminDashboard.jsp" method="post">
        <button type="submit" class="button">Dashboard</button>
    </form>
</body>
</html>
--%>





<%@ include file="dbConnection.jsp" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <title>Revenue Report</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>

<body class="bg-gray-100 min-h-screen flex flex-col items-center">
    <!-- Header -->
    <header class="text-center py-8">
        <h1 class="text-3xl font-bold text-gray-800">Revenue Report</h1>
    </header>

    <!-- Form Container -->
    <div class="w-full max-w-4xl px-4">
        <div class="bg-white shadow-md rounded-lg p-6">
            <form method="get" class="space-y-4">
                <div>
                    <label for="filterType" class="block text-lg font-medium text-gray-700">Filter By:</label>
                    <select 
                        name="filterType" 
                        id="filterType" 
                        class="w-full px-3 py-2 border border-gray-300 rounded-md focus:ring-2 focus:ring-blue-500 focus:outline-none" 
                        required>
                        <option value="transitLine">Transit Line</option>
                        <option value="customerName">Customer Name</option>
                    </select>
                </div>
                <div>
                    <label for="filterValue" class="block text-lg font-medium text-gray-700">Enter Value:</label>
                    <input 
                        type="text" 
                        name="filterValue" 
                        id="filterValue" 
                        class="w-full px-3 py-2 border border-gray-300 rounded-md focus:ring-2 focus:ring-blue-500 focus:outline-none" 
                        placeholder="Enter Transit Line or Customer Name" 
                        required>
                </div>
                <div class="text-center mt-8">
                <button 
                    type="submit" 
                    class="bg-blue-600 text-white py-3 px-6 rounded-md hover:bg-blue-700 transition">
                    Search
                </button>
                </div>
            </form>
        </div>
    </div>

    <!-- Results Section -->
    <div class="w-full max-w-6xl px-4 mt-8">
        <% 
            String filterType = request.getParameter("filterType");
            String filterValue = request.getParameter("filterValue");

            if (filterType != null && filterValue != null) {
                String query = "";
                if (filterType.equals("transitLine")) {
                    query = "SELECT r.ReservationID, r.ScheduleID, r.EmailAddress, r.ReservationDate, r.TotalFare, " +
                            "t.TransitLine, ts.DepartureDatetime, ts.ArrivalDatetime " +
                            "FROM Reservations r " +
                            "JOIN TrainSchedule ts ON r.ScheduleID = ts.ScheduleID " +
                            "JOIN Trains t ON ts.TrainID = t.TrainID " +
                            "WHERE t.TransitLine = ? " +
                            "ORDER BY r.ReservationDate ASC";
                } else if (filterType.equals("customerName")) {
                    query = "SELECT r.ReservationID, r.ScheduleID, r.EmailAddress, r.ReservationDate, r.TotalFare, " +
                            "t.TransitLine, ts.DepartureDatetime, ts.ArrivalDatetime " +
                            "FROM Reservations r " +
                            "JOIN TrainSchedule ts ON r.ScheduleID = ts.ScheduleID " +
                            "JOIN Trains t ON ts.TrainID = t.TrainID " +
                            "JOIN Customer c ON r.EmailAddress = c.EmailAddress " +
                            "WHERE CONCAT(c.FirstName, ' ', c.LastName) LIKE ? " +
                            "ORDER BY r.ReservationDate ASC";
                }

                try {
                    PreparedStatement stmt = ((Connection) request.getAttribute("dbConnection")).prepareStatement(query);
                    stmt.setString(1, filterType.equals("transitLine") ? filterValue : "%" + filterValue + "%");
                    ResultSet rs = stmt.executeQuery();

                    double totalRevenue = 0.0;

                    if (!rs.isBeforeFirst()) {
                        out.println("<p class='text-lg text-gray-700'>No reservations found for the specified filter.</p>");
                    } else {
        %>
        <div class="bg-white shadow-md rounded-lg overflow-hidden">
            <table class="min-w-full table-auto border-collapse">
                <thead class="bg-blue-600 text-white">
                    <tr>
                        <th class="px-4 py-2">Reservation ID</th>
                        <th class="px-4 py-2">Schedule ID</th>
                        <th class="px-4 py-2">Email Address</th>
                        <th class="px-4 py-2">Reservation Date</th>
                        <th class="px-4 py-2">Transit Line</th>
                        <th class="px-4 py-2">Departure Datetime</th>
                        <th class="px-4 py-2">Arrival Datetime</th>
                        <th class="px-4 py-2">Total Fare</th>
                    </tr>
                </thead>
                <tbody>
                    <% while (rs.next()) { 
                        totalRevenue += rs.getDouble("TotalFare");
                    %>
                    <tr class="border-b hover:bg-gray-50">
                        <td class="px-4 py-2"><%= rs.getInt("ReservationID") %></td>
                        <td class="px-4 py-2"><%= rs.getInt("ScheduleID") %></td>
                        <td class="px-4 py-2"><%= rs.getString("EmailAddress") %></td>
                        <td class="px-4 py-2"><%= rs.getDate("ReservationDate") %></td>
                        <td class="px-4 py-2"><%= rs.getString("TransitLine") %></td>
                        <td class="px-4 py-2"><%= rs.getTimestamp("DepartureDatetime") %></td>
                        <td class="px-4 py-2"><%= rs.getTimestamp("ArrivalDatetime") %></td>
                        <td class="px-4 py-2">$<%= rs.getBigDecimal("TotalFare") %></td>
                    </tr>
                    <% } %>
                </tbody>
                <tfoot class="bg-gray-100">
                    <tr>
                        <td colspan="7" class="px-4 py-2 font-semibold text-right">Total Revenue:</td>
                        <td class="px-4 py-2 font-semibold">$<%= String.format("%.2f", totalRevenue) %></td>
                    </tr>
                </tfoot>
            </table>
        </div>
        <% 
                    }
                } catch (Exception e) {
                    out.println("<p class='text-red-600'>Error: " + e.getMessage() + "</p>");
                }
            }
        %>
    </div>

    <!-- Back to Dashboard Button -->
    <div class="text-center mt-8 mb-6">
        <form action="adminDashboard.jsp" method="post">
            <button 
                type="submit" 
                class="bg-gray-800 text-white py-3 px-6 rounded-md hover:bg-gray-700 transition">
                Back to Dashboard
            </button>
        </form>
    </div>
</body>

</html>









