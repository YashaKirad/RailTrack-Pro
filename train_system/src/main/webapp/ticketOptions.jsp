<%-- <%@ include file="dbConnection.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ticket Options</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        function validateForm() {
            let fields = ["adults", "children", "seniors", "disabled"];
            let isValid = true;

            for (let field of fields) {
                let value = document.forms["ticketForm"][field].value;
                if (value < 0) {
                    alert("Number of " + field + " cannot be negative!");
                    isValid = false;
                    break;
                }
            }

            return isValid;
        }
    </script>
</head>

<body class="bg-gray-100 font-sans">
    <div class="container mx-auto p-6">
        <h1 class="text-3xl font-bold text-center text-gray-800 mb-6">Choose Ticket Options</h1>

        <!-- Ticket Options Form -->
        <div class="max-w-lg mx-auto bg-white p-6 rounded-lg shadow-lg">
            <form name="ticketForm" method="post" action="saveReservation.jsp" onsubmit="return validateForm()">
                
                <!-- Trip Type -->
                <div class="mb-4">
                    <label for="tripType" class="block text-lg font-medium text-gray-700">Trip Type:</label>
                    <select name="tripType" id="tripType" class="mt-1 block w-full p-2 border border-gray-300 rounded-md shadow-sm">
                        <option value="one-way">One Way</option>
                        <option value="round-trip">Round Trip</option>
                    </select>
                </div>
                
                <!-- Number of Adults -->
                <div class="mb-4">
                    <label for="adults" class="block text-lg font-medium text-gray-700">Number of Adults:</label>
                    <input type="number" name="adults" id="adults" class="mt-1 block w-full p-2 border border-gray-300 rounded-md shadow-sm" value="0" min="0" required>
                </div>

                <!-- Number of Children -->
                <div class="mb-4">
                    <label for="children" class="block text-lg font-medium text-gray-700">Number of Children:</label>
                    <input type="number" name="children" id="children" class="mt-1 block w-full p-2 border border-gray-300 rounded-md shadow-sm" value="0" min="0" required>
                </div>

                <!-- Number of Seniors -->
                <div class="mb-4">
                    <label for="seniors" class="block text-lg font-medium text-gray-700">Number of Seniors:</label>
                    <input type="number" name="seniors" id="seniors" class="mt-1 block w-full p-2 border border-gray-300 rounded-md shadow-sm" value="0" min="0" required>
                </div>

                <!-- Number of Disabled -->
                <div class="mb-6">
                    <label for="disabled" class="block text-lg font-medium text-gray-700">Number of Disabled:</label>
                    <input type="number" name="disabled" id="disabled" class="mt-1 block w-full p-2 border border-gray-300 rounded-md shadow-sm" value="0" min="0" required>
                </div>

                <!-- Hidden Fields -->
                <input type="hidden" name="scheduleID" value="<%= request.getParameter("scheduleID") %>">
                <input type="hidden" name="fare" value="<%= request.getParameter("fare") %>">
                <input type="hidden" name="adultDiscount" value="0">
                <input type="hidden" name="childDiscount" value="25">
                <input type="hidden" name="seniorDiscount" value="35">
                <input type="hidden" name="disabledDiscount" value="50">
                <input type="hidden" name="username" value="<%= request.getParameter("username") %>">

                <!-- Submit Button -->
                <button type="submit" class="w-full bg-gray-800 text-white py-2 rounded-md hover:bg-gray-700 transition duration-300">Confirm Reservation</button>
            </form>

            <!-- Dashboard Button -->
            <form action="customerDashboard.jsp" method="get" class="mt-4">
                <input type="hidden" name="username" value="<%= request.getParameter("username") %>">
                <button type="submit" class="w-full bg-gray-300 text-gray-800 py-2 rounded-md hover:bg-gray-400 transition duration-300">Dashboard</button>
            </form>
        </div>
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
    <title>Ticket Options</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <script>
        function validateForm() {
            let fields = ["adults", "children", "seniors", "disabled"];
            let isValid = true;

            for (let field of fields) {
                let value = document.forms["ticketForm"][field].value;
                if (value < 0) {
                    alert("Number of " + field + " cannot be negative!");
                    isValid = false;
                    break;
                }
            }

            return isValid;
        }
    </script>
</head>

<body class="bg-gray-100 min-h-screen flex items-center justify-center">
    <div class="bg-white shadow-md rounded-lg px-6 py-8 max-w-lg w-full">
        <h1 class="text-3xl font-bold text-center text-gray-800 mb-6">Choose Ticket Options</h1>

        <!-- Ticket Options Form -->
        <form name="ticketForm" method="post" action="saveReservation.jsp" onsubmit="return validateForm()" class="space-y-4">
            <!-- Trip Type -->
            <div>
                <label for="tripType" class="block text-lg font-medium text-gray-700">Trip Type:</label>
                <select name="tripType" id="tripType" class="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
                    <option value="one-way">One Way</option>
                    <option value="round-trip">Round Trip</option>
                </select>
            </div>

            <!-- Number of Adults -->
            <div>
                <label for="adults" class="block text-lg font-medium text-gray-700">Number of Adults:</label>
                <input type="number" name="adults" id="adults" class="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500" value="0" min="0" required>
            </div>

            <!-- Number of Children -->
            <div>
                <label for="children" class="block text-lg font-medium text-gray-700">Number of Children:</label>
                <input type="number" name="children" id="children" class="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500" value="0" min="0" required>
            </div>

            <!-- Number of Seniors -->
            <div>
                <label for="seniors" class="block text-lg font-medium text-gray-700">Number of Seniors:</label>
                <input type="number" name="seniors" id="seniors" class="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500" value="0" min="0" required>
            </div>

            <!-- Number of Disabled -->
            <div>
                <label for="disabled" class="block text-lg font-medium text-gray-700">Number of Disabled:</label>
                <input type="number" name="disabled" id="disabled" class="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500" value="0" min="0" required>
            </div>

            <!-- Hidden Fields -->
            <input type="hidden" name="scheduleID" value="<%= request.getParameter("scheduleID") %>">
            <input type="hidden" name="fare" value="<%= request.getParameter("fare") %>">
            <input type="hidden" name="adultDiscount" value="0">
            <input type="hidden" name="childDiscount" value="25">
            <input type="hidden" name="seniorDiscount" value="35">
            <input type="hidden" name="disabledDiscount" value="50">
            <input type="hidden" name="username" value="<%= request.getParameter("username") %>">

            <!-- Submit Button -->
            <button type="submit" class="w-full bg-blue-600 text-white py-3 rounded-md hover:bg-blue-700 transition duration-300">
                Confirm Reservation
            </button>
        </form>

        <!-- Dashboard Button -->
        <form action="customerDashboard.jsp" method="get" class="mt-4">
            <input type="hidden" name="username" value="<%= request.getParameter("username") %>">
            <button type="submit" class="w-full bg-gray-800 text-white py-3 px-6 rounded-md hover:bg-gray-700 transition">
                Back to Dashboard
            </button>
        </form>
    </div>
</body>

</html>

