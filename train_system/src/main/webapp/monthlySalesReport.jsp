<%-- <%@ include file="dbConnection.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>Sales Reports by Month</title>
    <style>
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
    </style>
</head>
<body>
    <h1>Sales Reports by Month</h1>
    <% 
        try {
            String query = "SELECT MONTHNAME(ReservationDate) AS Month, " +
                           "YEAR(ReservationDate) AS Year, SUM(TotalFare) AS Revenue " +
                           "FROM Reservations GROUP BY Year, Month " +
                           "ORDER BY Year, FIELD(Month, 'January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December')";
            PreparedStatement stmt = ((Connection) request.getAttribute("dbConnection")).prepareStatement(query);
            ResultSet rs = stmt.executeQuery();
    %>
    <table>
        <thead>
            <tr>
                <th>Year</th>
                <th>Month</th>
                <th>Revenue</th>
            </tr>
        </thead>
        <tbody>
            <% while (rs.next()) { %>
            <tr>
                <td><%= rs.getInt("Year") %></td>
                <td><%= rs.getString("Month") %></td>
                <td><%= rs.getBigDecimal("Revenue") %></td>
            </tr>
            <% } %>
        </tbody>
    </table>
     <form action="adminDashboard.jsp" method="post">
            <button type="submit" class="button">Dashboard</button>
        </form>
    <% 
        } catch (Exception e) { 
            out.println("<p>Error: " + e.getMessage() + "</p>");
        } 
    %>
</body>
</html>
--%>





<%-- <%@ include file="dbConnection.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>Sales Reports by Month</title>
    <style>
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
        .form-container {
            text-align: center;
            margin: 20px auto;
        }
        .button {
            padding: 5px 10px;
            background-color: #444;
            color: white;
            border: none;
            cursor: pointer;
        }
        .button:hover {
            background-color: #333;
        }
    </style>
</head>
<body>
    <h1>Sales Reports by Month</h1>
    <div class="form-container">
        <form method="get">
            <label for="month">Select Month:</label>
            <select name="month" id="month" required>
                <option value="01">January</option>
                <option value="02">February</option>
                <option value="03">March</option>
                <option value="04">April</option>
                <option value="05">May</option>
                <option value="06">June</option>
                <option value="07">July</option>
                <option value="08">August</option>
                <option value="09">September</option>
                <option value="10">October</option>
                <option value="11">November</option>
                <option value="12">December</option>
            </select>
            <label for="year">Select Year:</label>
            <input type="number" name="year" id="year" min="2000" max="2100" required>
            <button type="submit" class="button">View Report</button>
        </form>
    </div>

    <% 
        String selectedMonth = request.getParameter("month");
        String selectedYear = request.getParameter("year");

        if (selectedMonth != null && selectedYear != null) {
            try {
                // Query to get reservation details for the selected month and year
                String query = "SELECT ReservationID, ScheduleID, EmailAddress, ReservationDate, TotalFare " +
                               "FROM Reservations " +
                               "WHERE MONTH(ReservationDate) = ? AND YEAR(ReservationDate) = ? " +
                               "ORDER BY ReservationDate ASC";
                PreparedStatement stmt = ((Connection) request.getAttribute("dbConnection")).prepareStatement(query);
                stmt.setString(1, selectedMonth);
                stmt.setString(2, selectedYear);
                ResultSet rs = stmt.executeQuery();

                // Initialize total revenue
                double totalRevenue = 0.0;
    %>
    <h2>Sales Report for <%= new java.text.DateFormatSymbols().getMonths()[Integer.parseInt(selectedMonth) - 1] %> <%= selectedYear %></h2>
    <table>
        <thead>
            <tr>
                <th>Reservation ID</th>
                <th>Schedule ID</th>
                <th>Email Address</th>
                <th>Reservation Date</th>
                <th>Total Fare</th>
            </tr>
        </thead>
        <tbody>
            <% 
                boolean hasData = false;
                while (rs.next()) {
                    hasData = true;
                    totalRevenue += rs.getDouble("TotalFare");
            %>
            <tr>
                <td><%= rs.getInt("ReservationID") %></td>
                <td><%= rs.getInt("ScheduleID") %></td>
                <td><%= rs.getString("EmailAddress") %></td>
                <td><%= rs.getDate("ReservationDate") %></td>
                <td>$<%= rs.getBigDecimal("TotalFare") %></td>
            </tr>
            <% 
                } 
                if (!hasData) {
            %>
            <tr>
                <td colspan="5">No reservations found for this month.</td>
            </tr>
            <% 
                } 
            %>
        </tbody>
        <% if (hasData) { %>
        <tfoot>
            <tr>
                <td colspan="4"><strong>Total Revenue:</strong></td>
                <td><strong>$<%= String.format("%.2f", totalRevenue) %></strong></td>
            </tr>
        </tfoot>
        <% } %>
    </table>
    <% 
            } catch (Exception e) { 
                out.println("<p>Error: " + e.getMessage() + "</p>");
            }
        }
    %>

    <form action="adminDashboard.jsp" method="post" style="text-align: center; margin-top: 20px;">
        <button type="submit" class="button">Dashboard</button>
    </form>
</body>
</html>
--%>






<%@ include file="dbConnection.jsp" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <title>Sales Reports by Month</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>

<body class="bg-gray-100 min-h-screen flex flex-col items-center">
    <!-- Header -->
    <header class="text-center py-8">
        <h1 class="text-3xl font-bold text-gray-800">Sales Reports by Month</h1>
    </header>

    <!-- Form Container -->
    <div class="w-full max-w-4xl px-4">
        <div class="bg-white shadow-md rounded-lg p-6">
            <form method="get" class="space-y-4">
                <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                    <div>
                        <label for="month" class="block text-lg font-medium text-gray-700">Select Month:</label>
                        <select 
                            name="month" 
                            id="month" 
                            class="w-full px-3 py-2 border border-gray-300 rounded-md focus:ring-2 focus:ring-blue-500 focus:outline-none" 
                            required>
                            <option value="01">January</option>
                            <option value="02">February</option>
                            <option value="03">March</option>
                            <option value="04">April</option>
                            <option value="05">May</option>
                            <option value="06">June</option>
                            <option value="07">July</option>
                            <option value="08">August</option>
                            <option value="09">September</option>
                            <option value="10">October</option>
                            <option value="11">November</option>
                            <option value="12">December</option>
                        </select>
                    </div>
                    <div>
                        <label for="year" class="block text-lg font-medium text-gray-700">Select Year:</label>
                        <input 
                            type="number" 
                            name="year" 
                            id="year" 
                            min="2000" 
                            max="2100" 
                            class="w-full px-3 py-2 border border-gray-300 rounded-md focus:ring-2 focus:ring-blue-500 focus:outline-none" 
                            required>
                    </div>
                </div>
                <div class="text-center mt-8">
                <button 
                    type="submit" 
                    class="bg-blue-600 text-white py-3 px-6 rounded-md hover:bg-blue-700 transition">
                    View Report
                </button>
                </div>
            </form>
        </div>
    </div>

    <!-- Results Section -->
    <div class="w-full max-w-6xl px-4 mt-8">
        <%
            String selectedMonth = request.getParameter("month");
            String selectedYear = request.getParameter("year");

            if (selectedMonth != null && selectedYear != null) {
                try {
                    String query = "SELECT ReservationID, ScheduleID, EmailAddress, ReservationDate, TotalFare " +
                                   "FROM Reservations " +
                                   "WHERE MONTH(ReservationDate) = ? AND YEAR(ReservationDate) = ? " +
                                   "ORDER BY ReservationDate ASC";
                    PreparedStatement stmt = ((Connection) request.getAttribute("dbConnection")).prepareStatement(query);
                    stmt.setString(1, selectedMonth);
                    stmt.setString(2, selectedYear);
                    ResultSet rs = stmt.executeQuery();

                    double totalRevenue = 0.0;
        %>
        <h2 class="text-2xl font-semibold text-gray-800 mb-4">Sales Report for <%= new java.text.DateFormatSymbols().getMonths()[Integer.parseInt(selectedMonth) - 1] %> <%= selectedYear %></h2>
        <div class="bg-white shadow-md rounded-lg overflow-hidden">
            <table class="min-w-full table-auto border-collapse">
                <thead class="bg-blue-600 text-white">
                    <tr>
                        <th class="px-4 py-2 text-left">Reservation ID</th>
                        <th class="px-4 py-2 text-left">Schedule ID</th>
                        <th class="px-4 py-2 text-left">Email Address</th>
                        <th class="px-4 py-2 text-left">Reservation Date</th>
                        <th class="px-4 py-2 text-left">Total Fare</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                        boolean hasData = false;
                        while (rs.next()) {
                            hasData = true;
                            totalRevenue += rs.getDouble("TotalFare");
                    %>
                    <tr class="border-b hover:bg-gray-50">
                        <td class="px-4 py-2 text-left"><%= rs.getInt("ReservationID") %></td>
                        <td class="px-4 py-2 text-left"><%= rs.getInt("ScheduleID") %></td>
                        <td class="px-4 py-2 text-left"><%= rs.getString("EmailAddress") %></td>
                        <td class="px-4 py-2 text-left"><%= rs.getDate("ReservationDate") %></td>
                        <td class="px-4 py-2 text-left">$<%= rs.getBigDecimal("TotalFare") %></td>
                    </tr>
                    <% 
                        } 
                        if (!hasData) {
                    %>
                    <tr>
                        <td colspan="5" class="px-4 py-4 text-center text-gray-700">No reservations found for this month.</td>
                    </tr>
                    <% 
                        } 
                    %>
                </tbody>
                <% if (hasData) { %>
                <tfoot class="bg-gray-100">
                    <tr>
                        <td colspan="4" class="px-4 py-2 font-semibold text-right">Total Revenue:</td>
                        <td class="px-4 py-2 font-semibold">$<%= String.format("%.2f", totalRevenue) %></td>
                    </tr>
                </tfoot>
                <% } %>
            </table>
        </div>
        <% 
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

