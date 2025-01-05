<%-- <%@ include file="dbConnection.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Create Account</title>
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
        <h2>Create Account</h2>
        <form action="registerAction.jsp" method="post">
            <input type="text" name="lastName" placeholder="Last Name" class="input-field" required>
            <input type="text" name="firstName" placeholder="First Name" class="input-field" required>
            <input type="email" name="email" placeholder="E-mail Address" class="input-field" required>
            <input type="text" name="username" placeholder="Username" class="input-field" required>
            <input type="password" name="password" placeholder="Password" class="input-field" required>
            <button type="submit" class="button">Register</button>
        </form>
        <a href="customerLogin.jsp" class="link">Back to Login</a>
    </div>
</body>
</html>
--%>
<%@ include file="dbConnection.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Account</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100 min-h-screen flex items-center justify-center">
    <div class="bg-white shadow-md rounded-lg px-6 py-8 max-w-md w-full">
        <h2 class="text-3xl font-bold text-gray-800 mb-6 text-center">Create Account</h2>

        <!-- Registration Form -->
        <form action="registerAction.jsp" method="post" class="space-y-4">
            <div>
                <input 
                    type="text" 
                    name="lastName" 
                    placeholder="Last Name" 
                    class="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
                    required
                >
            </div>
            <div>
                <input 
                    type="text" 
                    name="firstName" 
                    placeholder="First Name" 
                    class="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
                    required
                >
            </div>
            <div>
                <input 
                    type="email" 
                    name="email" 
                    placeholder="E-mail Address" 
                    class="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
                    required
                >
            </div>
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
                class="w-full bg-blue-600 text-white py-2 rounded-md hover:bg-blue-700 transition text-lg"
            >
                Register
            </button>
        </form>

        <!-- Links -->
        <div class="text-center mt-4">
            <a href="customerLogin.jsp" class="text-blue-600 hover:underline text-sm">Back to Login</a>
        </div>
    </div>
</body>
</html>



