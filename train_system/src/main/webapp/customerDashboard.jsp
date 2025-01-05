<%-- <%@ include file="dbConnection.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Dashboard</title>
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

        .dashboard-container {
            text-align: center;
            background: #ffffff;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
            padding: 40px 30px;
            width: 100%;
            max-width: 550px;
            box-sizing: border-box;
            /* Height will adjust automatically based on the number of buttons */
        }

        h1 {
            font-size: 1.8rem;
            color: #333333;
            margin-bottom: 30px;
        }

        .button {
            display: block;
            margin: 12px auto;
            padding: 12px 20px;
            width: 80%;
            background: linear-gradient(135deg, #6c63ff, #788cff);
            color: white;
            font-size: 1rem;
            font-weight: bold;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: all 0.3s ease-in-out;
            text-decoration: none;
            text-align: center;
        }

        .button:hover {
            background: linear-gradient(135deg, #5a5fdd, #6b73ff);
            transform: scale(1.02);
        }

        button {
            border: none;
        }

        /* Responsive Design */
        @media (max-width: 600px) {
            .dashboard-container {
                padding: 20px 15px;
                max-width: 100%;
            }

            h1 {
                font-size: 1.5rem;
            }

            .button {
                font-size: 0.9rem;
                padding: 10px 15px;
            }
        }
    </style>
</head>
<body>
    <% 
        String username = request.getParameter("username"); 
    %>
    <div class="dashboard-container">
        <h1>Welcome, <%= username %>!</h1>

        <a href="buyTickets.jsp?username=<%= username %>" class="button">Buy Tickets</a>
        <a href="viewBookings.jsp?username=<%= username %>" class="button">View Past Bookings</a>
        <a href="currentBookings.jsp?username=<%= username %>" class="button">View Current Bookings</a>
        <a href="faq.jsp?username=<%= username %>" class="button">FAQ</a>

        <form action="logout.jsp" method="post">
            <button type="submit" class="button">Logout</button>
        </form>
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
    <title>Customer Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100 min-h-screen flex items-center justify-center">
    <% 
        String username = request.getParameter("username"); 
    %>
    <div class="bg-white shadow-md rounded-lg px-6 py-8 max-w-lg w-full text-center">
        <h1 class="text-3xl font-bold text-gray-800 mb-6">Welcome, <%= username %>!</h1>
        
        <!-- Dashboard Links -->
        <div class="space-y-4">
            <a href="buyTickets.jsp?username=<%= username %>" 
               class="block w-full bg-blue-600 text-white py-3 rounded-md hover:bg-blue-700 transition text-lg">
               Buy Tickets
            </a>
            <a href="viewBookings.jsp?username=<%= username %>" 
               class="block w-full bg-blue-600 text-white py-3 rounded-md hover:bg-blue-700 transition text-lg">
               View Past Bookings
            </a>
            <a href="currentBookings.jsp?username=<%= username %>" 
               class="block w-full bg-blue-600 text-white py-3 rounded-md hover:bg-blue-700 transition text-lg">
               View Current Bookings
            </a>
            <a href="faq.jsp?username=<%= username %>" 
               class="block w-full bg-blue-600 text-white py-3 rounded-md hover:bg-blue-700 transition text-lg">
               FAQ
            </a>
        </div>

        <!-- Logout Button -->
        <form action="logout.jsp" method="post" class="mt-4">
            <button type="submit" 
                    class="w-full bg-red-600 text-white py-3 rounded-md hover:bg-red-700 transition text-lg">
                Logout
            </button>
        </form>
    </div>
</body>
</html>
