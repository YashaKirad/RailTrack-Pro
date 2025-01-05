<%-- <%@ include file="dbConnection.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>Best Metrics Report</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            background-color: #f4f4f9;
        }
        .container {
            width: 80%;
            margin: 20px auto;
        }
        table {
            width: 100%;
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
        .section-title {
            margin-top: 20px;
            font-size: 1.5em;
            text-align: left;
        }
    </style>
</head>
<body>
    <h1>Best Metrics Report</h1>
    <div class="container">
        <!-- Best Customer -->
        <div>
            <h2 class="section-title">Best Customer</h2>
            <% 
                try {
                    String bestCustomerQuery = "SELECT CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName, SUM(r.TotalFare) AS TotalSpent " +
                                               "FROM Reservations r " +
                                               "JOIN Customer c ON r.EmailAddress = c.EmailAddress " +
                                               "GROUP BY c.EmailAddress " +
                                               "ORDER BY TotalSpent DESC LIMIT 1";
                    PreparedStatement stmt = ((Connection) request.getAttribute("dbConnection")).prepareStatement(bestCustomerQuery);
                    ResultSet rs = stmt.executeQuery();

                    if (!rs.isBeforeFirst()) {
                        out.println("<p>No customers found.</p>");
                    } else {
                        while (rs.next()) {
            %>
            <table>
                <thead>
                    <tr>
                        <th>Customer Name</th>
                        <th>Total Spent</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><%= rs.getString("CustomerName") %></td>
                        <td><%= rs.getBigDecimal("TotalSpent") %></td>
                    </tr>
                </tbody>
            </table>
            <% 
                        }
                    }
                } catch (Exception e) {
                    out.println("<p>Error: " + e.getMessage() + "</p>");
                }
            %>
        </div>

        <!-- Top 5 Most Active Transit Lines -->
        <div>
            <h2 class="section-title">Top 5 Most Active Transit Lines</h2>
            <% 
                try {
                    String topTransitLinesQuery = "SELECT t.TransitLine, COUNT(r.ReservationID) AS ReservationCount " +
                                                  "FROM Reservations r " +
                                                  "JOIN TrainSchedule ts ON r.ScheduleID = ts.ScheduleID " +
                                                  "JOIN Trains t ON ts.TrainID = t.TrainID " +
                                                  "GROUP BY t.TransitLine " +
                                                  "ORDER BY ReservationCount DESC LIMIT 5";
                    PreparedStatement stmt = ((Connection) request.getAttribute("dbConnection")).prepareStatement(topTransitLinesQuery);
                    ResultSet rs = stmt.executeQuery();

                    if (!rs.isBeforeFirst()) {
                        out.println("<p>No transit lines found.</p>");
                    } else {
            %>
            <table>
                <thead>
                    <tr>
                        <th>Transit Line</th>
                        <th>Reservation Count</th>
                    </tr>
                </thead>
                <tbody>
                    <% while (rs.next()) { %>
                    <tr>
                        <td><%= rs.getString("TransitLine") %></td>
                        <td><%= rs.getInt("ReservationCount") %></td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
            <% 
                    }
                } catch (Exception e) {
                    out.println("<p>Error: " + e.getMessage() + "</p>");
                }
            %>
        </div>
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
    <title>Best Metrics Report</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>

<body class="bg-gray-100 min-h-screen flex flex-col items-center">
    <!-- Header -->
    <header class="text-center py-8">
        <h1 class="text-3xl font-bold text-gray-800">Best Metrics Report</h1>
    </header>

    <!-- Container -->
    <div class="w-full max-w-6xl px-4 space-y-8">
        <!-- Best Customer Section -->
        <div class="bg-white shadow-md rounded-lg p-6">
            <h2 class="text-2xl font-semibold text-gray-800 mb-4">Best Customer</h2>
            <% 
                try {
                    String bestCustomerQuery = "SELECT CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName, SUM(r.TotalFare) AS TotalSpent " +
                                               "FROM Reservations r " +
                                               "JOIN Customer c ON r.EmailAddress = c.EmailAddress " +
                                               "GROUP BY c.EmailAddress " +
                                               "ORDER BY TotalSpent DESC LIMIT 1";
                    PreparedStatement stmt = ((Connection) request.getAttribute("dbConnection")).prepareStatement(bestCustomerQuery);
                    ResultSet rs = stmt.executeQuery();

                    if (!rs.isBeforeFirst()) {
            %>
            <p class="text-gray-700">No customers found.</p>
            <% 
                    } else {
                        while (rs.next()) {
            %>
            <table class="min-w-full table-auto border-collapse bg-white shadow rounded-lg">
                <thead class="bg-blue-600 text-white">
                    <tr>
                        <th class="px-4 py-2 text-left">Customer Name</th>
                        <th class="px-4 py-2 text-left">Total Spent</th>
                    </tr>
                </thead>
                <tbody>
                    <tr class="border-b hover:bg-gray-50">
                        <td class="px-4 py-2 text-left"><%= rs.getString("CustomerName") %></td>
                        <td class="px-4 py-2 text-left">$<%= rs.getBigDecimal("TotalSpent") %></td>
                    </tr>
                </tbody>
            </table>
            <% 
                        }
                    }
                } catch (Exception e) {
                    out.println("<p class='text-red-600'>Error: " + e.getMessage() + "</p>");
                }
            %>
        </div>

        <!-- Top 5 Most Active Transit Lines Section -->
        <div class="bg-white shadow-md rounded-lg p-6">
            <h2 class="text-2xl font-semibold text-gray-800 mb-4">Top 5 Most Active Transit Lines</h2>
            <% 
                try {
                    String topTransitLinesQuery = "SELECT t.TransitLine, COUNT(r.ReservationID) AS ReservationCount " +
                                                  "FROM Reservations r " +
                                                  "JOIN TrainSchedule ts ON r.ScheduleID = ts.ScheduleID " +
                                                  "JOIN Trains t ON ts.TrainID = t.TrainID " +
                                                  "GROUP BY t.TransitLine " +
                                                  "ORDER BY ReservationCount DESC LIMIT 5";
                    PreparedStatement stmt = ((Connection) request.getAttribute("dbConnection")).prepareStatement(topTransitLinesQuery);
                    ResultSet rs = stmt.executeQuery();

                    if (!rs.isBeforeFirst()) {
            %>
            <p class="text-gray-700">No transit lines found.</p>
            <% 
                    } else {
            %>
            <table class="min-w-full table-auto border-collapse bg-white shadow rounded-lg">
                <thead class="bg-blue-600 text-white">
                    <tr>
                        <th class="px-4 py-2 text-left">Transit Line</th>
                        <th class="px-4 py-2 text-left">Reservation Count</th>
                    </tr>
                </thead>
                <tbody>
                    <% while (rs.next()) { %>
                    <tr class="border-b hover:bg-gray-50">
                        <td class="px-4 py-2 text-left"><%= rs.getString("TransitLine") %></td>
                        <td class="px-4 py-2 text-left"><%= rs.getInt("ReservationCount") %></td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
            <% 
                    }
                } catch (Exception e) {
                    out.println("<p class='text-red-600'>Error: " + e.getMessage() + "</p>");
                }
            %>
        </div>
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

