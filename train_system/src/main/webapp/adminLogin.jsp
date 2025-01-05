<%-- <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="dbConnection.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Login</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            text-align: center;
            padding-top: 50px;
        }
        .form-container {
            display: inline-block;
            padding: 20px;
            border: 1px solid #ccc;
            background-color: #fff;
            border-radius: 5px;
        }
        .input-field {
            margin: 10px 0;
            display: block;
            width: 100%;
            padding: 10px;
        }
        .button {
            padding: 10px 20px;
            background-color: #444;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .button:hover {
            background-color: #555;
        }
        .link {
            margin-top: 10px;
            display: block;
            text-decoration: none;
            color: #007BFF;
        }
        .link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h2>Admin Login</h2>
        <form action="adminDashboard.jsp" method="post">
            <input type="text" name="username" placeholder="Username" class="input-field" required>
            <input type="password" name="password" placeholder="Password" class="input-field" required>
            <button type="submit" class="button">Login</button>
        </form>
        <a href="dashboard.jsp" class="link">Back to Dashboard</a>
       
    </div>
</body>
</html>
--%>


<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="dbConnection.jsp" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <title>Admin Login</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>

<body class="bg-gray-100 min-h-screen flex justify-center items-center">
    <div class="bg-white p-8 rounded-lg shadow-md w-full max-w-sm">
        <h2 class="text-2xl font-bold text-center text-gray-800 mb-6">Admin Login</h2>
        <form action="adminDashboard.jsp" method="post" class="space-y-4">
            <div>
                <input 
                    type="text" 
                    name="username" 
                    placeholder="Username" 
                    class="w-full p-3 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500" 
                    required>
            </div>
            <div>
                <input 
                    type="password" 
                    name="password" 
                    placeholder="Password" 
                    class="w-full p-3 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500" 
                    required>
            </div>
            <button 
                type="submit" 
                class="w-full bg-blue-600 text-white py-3 rounded-md hover:bg-blue-700 transition">
                Login
            </button>
        </form>
        <a 
            href="dashboard.jsp" 
            class="block text-center mt-4 text-blue-600 hover:underline">
            Back to Dashboard
        </a>
    </div>
</body>

</html>
