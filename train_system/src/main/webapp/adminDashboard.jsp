<%-- <%@ include file="dbConnection.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            background-color: #f4f4f9;
        }
        .container {
            margin: 20px auto;
            width: 50%;
        }
        .button {
            display: block;
            margin: 15px auto;
            padding: 15px 30px;
            background-color: #444;
            color: white;
            text-decoration: none;
            border-radius: 5px;
        }
        .button:hover {
            background-color: #555;
        }
    </style>
</head>
<body>
    <h1>Admin Dashboard</h1>
    <div class="container">
        
        <a href="manageCustomerReps.jsp" class="button">Manage Customer Representatives</a>
        <a href="monthlySalesReport.jsp" class="button">Sales Reports by Month</a>
        <a href="reservationsReport.jsp" class="button">Reservations Report</a>
        <a href="revenueReport.jsp" class="button">Revenue Report</a>
        <a href="bestMetricsReport.jsp" class="button">Best Metrics</a>
     	<form action="logout.jsp" method="post">
            <button type="submit" class="button">Logout</button>
        </form>
    </div>
</body>
</html>
--%>



<%@ include file="dbConnection.jsp" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <title>Admin Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>

<body class="bg-gray-100 min-h-screen flex flex-col items-center">
    <!-- Header -->
    <header class="text-center py-8">
        <h1 class="text-3xl font-bold text-gray-800">Admin Dashboard</h1>
    </header>

    <!-- Action Buttons -->
    <div class="w-full max-w-4xl px-4 grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4">
        <a 
            href="manageCustomerReps.jsp" 
            class="block bg-blue-600 text-white py-3 rounded-md text-center hover:bg-blue-700 transition">
            Manage Customer Representatives
        </a>
        <a 
            href="monthlySalesReport.jsp" 
            class="block bg-blue-600 text-white py-3 rounded-md text-center hover:bg-blue-700 transition">
            Sales Reports by Month
        </a>
        <a 
            href="reservationsReport.jsp" 
            class="block bg-blue-600 text-white py-3 rounded-md text-center hover:bg-blue-700 transition">
            Reservations Report
        </a>
        <a 
            href="revenueReport.jsp" 
            class="block bg-blue-600 text-white py-3 rounded-md text-center hover:bg-blue-700 transition">
            Revenue Report
        </a>
        <a 
            href="bestMetricsReport.jsp" 
            class="block bg-blue-600 text-white py-3 rounded-md text-center hover:bg-blue-700 transition">
            Best Metrics
        </a>
    </div>

    <!-- Logout Button -->
    <div class="text-center mt-8">
        <form action="logout.jsp" method="post">
            <button 
                type="submit" 
                class="bg-red-600 text-white py-3 px-6 rounded-md hover:bg-red-500 transition">
                Logout
            </button>
        </form>
    </div>
</body>

</html>
