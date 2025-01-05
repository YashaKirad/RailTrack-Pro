<%-- <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="dbConnection.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Rep Login</title>
    <!-- Add Tailwind CSS via CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50 flex justify-center items-center h-screen">
    <div class="bg-white p-8 rounded-lg shadow-md w-full max-w-sm">
        <h2 class="text-2xl font-semibold text-center text-gray-800 mb-6">Customer Representative Login</h2>
        <form action="customerRepDashboard.jsp" method="post">
            <div class="mb-4">
                <input type="text" name="username" placeholder="Username" class="w-full p-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-indigo-500" required>
            </div>
            <div class="mb-6">
                <input type="password" name="password" placeholder="Password" class="w-full p-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-indigo-500" required>
            </div>
            <button type="submit" class="w-full py-3 bg-gray-800 text-white rounded-lg hover:bg-gray-700 transition">Login</button>
        </form>
        <a href="dashboard.jsp" class="block text-center mt-4 text-indigo-600 hover:underline">Back to Dashboard</a>
    </div>
</body>
</html>
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="dbConnection.jsp" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Rep Login</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>

<body class="bg-gray-100 min-h-screen flex items-center justify-center">
    <div class="bg-white shadow-md rounded-lg px-6 py-8 max-w-md w-full">
        <h2 class="text-3xl font-bold text-center text-gray-800 mb-6">Customer Representative Login</h2>
        
        <!-- Login Form -->
        <form action="customerRepDashboard.jsp" method="post" class="space-y-4">
            <div>
                <input 
                    type="text" 
                    name="username" 
                    placeholder="Username" 
                    class="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500" 
                    required
                >
            </div>
            <div>
                <input 
                    type="password" 
                    name="password" 
                    placeholder="Password" 
                    class="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500" 
                    required
                >
            </div>
            <button 
                type="submit" 
                class="w-full bg-blue-600 text-white py-3 rounded-md hover:bg-blue-700 transition"
            >
                Login
            </button>
        </form>

        <!-- Back to Dashboard Link -->
        <div class="text-center mt-4">
            <a href="dashboard.jsp" class="text-blue-600 hover:underline text-sm">Back to Dashboard</a>
        </div>
    </div>
</body>

</html>
