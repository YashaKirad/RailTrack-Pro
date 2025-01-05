<%-- <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="dbConnection.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Login</title>
    <style>
        /* General Styles */
        body {
            font-family: 'Roboto', Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f0f2f5;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        /* Login Form Container */
        .form-container {
            background: #ffffff;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
            padding: 30px;
            text-align: center;
            max-width: 400px;
            width: 100%;
        }

        h2 {
            color: #333333;
            margin-bottom: 20px;
        }

        .input-field {
            margin: 15px 0;
            padding: 10px 15px;
            width: 100%;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 1rem;
        }

        .input-field:focus {
            outline: none;
            border-color: #6c63ff;
            box-shadow: 0 0 5px rgba(108, 99, 255, 0.3);
        }

        .button {
            margin-top: 20px;
            padding: 12px 20px;
            width: 100%;
            background: linear-gradient(135deg, #6c63ff, #788cff);
            color: white;
            font-size: 1rem;
            font-weight: bold;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: all 0.3s ease-in-out;
        }

        .button:hover {
            background: linear-gradient(135deg, #5a5fdd, #6b73ff);
            transform: scale(1.02);
        }

        .link {
            margin-top: 15px;
            font-size: 0.9rem;
            color: #6c63ff;
            text-decoration: none;
        }

        .link:hover {
            text-decoration: underline;
        }

        /* Responsive Design */
        @media (max-width: 500px) {
            .form-container {
                padding: 20px;
            }

            h2 {
                font-size: 1.5rem;
            }

            .input-field, .button {
                font-size: 0.9rem;
            }
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h2>Customer Login</h2>
        <form action="customerDashboard.jsp" method="post">
            <input type="text" name="username" placeholder="Enter your username" class="input-field" required>
            <input type="password" name="password" placeholder="Enter your password" class="input-field" required>
            <button type="submit" class="button">Login</button>
        </form>
        <a href="register.jsp" class="link">Create Account</a>
        <a href="dashboard.jsp" class="link">Back to Dashboard</a>
    </div>
</body>
</html>--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="dbConnection.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Login</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100 min-h-screen flex items-center justify-center">
    <div class="bg-white shadow-md rounded-lg px-6 py-8 max-w-md w-full">
        <h2 class="text-3xl font-bold text-gray-800 mb-6 text-center">Customer Login</h2>
        
        <!-- Login Form -->
        <form action="customerDashboard.jsp" method="post" class="space-y-4">
            <div>
                <input 
                    type="text" 
                    name="username" 
                    placeholder="Enter your username" 
                    class="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
                    required
                >
            </div>
            <div>
                <input 
                    type="password" 
                    name="password" 
                    placeholder="Enter your password" 
                    class="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
                    required
                >
            </div>
            <button 
                type="submit" 
                class="w-full bg-blue-600 text-white py-2 rounded-md hover:bg-blue-700 transition text-lg"
            >
                Login
            </button>
        </form>

        <!-- Links -->
        <div class="text-center mt-4 space-y-2">
            <a href="register.jsp" class="text-blue-600 hover:underline text-sm">Create Account</a>
            <br>
            <a href="dashboard.jsp" class="text-blue-600 hover:underline text-sm">Back to Dashboard</a>
        </div>
    </div>
</body>
</html>
