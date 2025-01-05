<%-- <%@ include file="dbConnection.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Customer Representatives</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            background-color: #f4f4f9;
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
        .form-container {
            margin: 20px auto;
            width: 50%;
        }
    </style>
</head>
<body>
    <h1>Manage Customer Representatives</h1>
    
    <!-- Display Existing Customer Representatives -->
    <% 
        String query = "SELECT SSN, FirstName, LastName, Username FROM CustomerRepresentatives";
        PreparedStatement stmt = ((Connection) request.getAttribute("dbConnection")).prepareStatement(query);
        ResultSet rs = stmt.executeQuery();
    %>
    <table>
        <thead>
            <tr>
                <th>SSN</th>
                <th>First Name</th>
                <th>Last Name</th>
                <th>Username</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <% while (rs.next()) { %>
            <tr>
                <td><%= rs.getString("SSN") %></td>
                <td><%= rs.getString("FirstName") %></td>
                <td><%= rs.getString("LastName") %></td>
                <td><%= rs.getString("Username") %></td>
                <td>
                    <!-- Edit Button -->
                    <a href="editCustomerRep.jsp?ssn=<%= rs.getString("SSN") %>">
                        <button type="button">Edit</button>
                    </a>
                    <!-- Delete Button -->
                    <form method="post" action="updateCustomerRep.jsp" style="display:inline;">
                        <input type="hidden" name="ssn" value="<%= rs.getString("SSN") %>">
                        <button type="submit" name="action" value="delete">Delete</button>
                    </form>
                </td>
            </tr>
            <% } %>
        </tbody>
    </table>

    <!-- Add New Customer Representative -->
    <div class="form-container">
        <h2>Add New Customer Representative</h2>
        <form method="post" action="addCustomerRep.jsp">
            <label>First Name:</label>
            <input type="text" name="firstName" required><br><br>
            <label>Last Name:</label>
            <input type="text" name="lastName" required><br><br>
            <label>Username:</label>
            <input type="text" name="username" required><br><br>
            <label>Password:</label>
            <input type="password" name="password" required><br><br>
            <label>SSN:</label>
            <input type="text" name="ssn" placeholder="XXX-XX-XXXX" required><br><br>
            <button type="submit">Add Customer Representative</button>
        </form>
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
    <title>Manage Customer Representatives</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>

<body class="bg-gray-100 min-h-screen flex flex-col items-center">
    <!-- Header -->
    <header class="text-center py-8">
        <h1 class="text-3xl font-bold text-gray-800">Manage Customer Representatives</h1>
    </header>

    <!-- Customer Representatives Table -->
    <div class="w-full max-w-6xl px-4">
        <%
            String query = "SELECT SSN, FirstName, LastName, Username FROM CustomerRepresentatives";
            PreparedStatement stmt = ((Connection) request.getAttribute("dbConnection")).prepareStatement(query);
            ResultSet rs = stmt.executeQuery();
        %>
        <div class="bg-white shadow-md rounded-lg overflow-hidden">
    <table class="min-w-full table-auto border-collapse">
        <thead class="bg-blue-600 text-white">
            <tr>
                <th class="px-4 py-2 text-left">SSN</th>
                <th class="px-4 py-2 text-left">First Name</th>
                <th class="px-4 py-2 text-left">Last Name</th>
                <th class="px-4 py-2 text-left">Username</th>
                <th class="px-4 py-2 text-left">Actions</th>
            </tr>
        </thead>
        <tbody>
            <% while (rs.next()) { %>
            <tr class="border-b hover:bg-gray-50">
                <td class="px-4 py-2 text-left"><%= rs.getString("SSN") %></td>
                <td class="px-4 py-2 text-left"><%= rs.getString("FirstName") %></td>
                <td class="px-4 py-2 text-left"><%= rs.getString("LastName") %></td>
                <td class="px-4 py-2 text-left"><%= rs.getString("Username") %></td>
                <td class="px-4 py-2 text-left">
                    <div class="flex space-x-2">
                        <a href="editCustomerRep.jsp?ssn=<%= rs.getString("SSN") %>" class="bg-blue-600 text-white px-3 py-1 rounded-md hover:bg-blue-700 transition">Edit</a>
                        <form method="post" action="updateCustomerRep.jsp">
                            <input type="hidden" name="ssn" value="<%= rs.getString("SSN") %>">
                            <button type="submit" name="action" value="delete" class="bg-red-600 text-white px-3 py-1 rounded-md hover:bg-red-500 transition">Delete</button>
                        </form>
                    </div>
                </td>
            </tr>
            <% } %>
        </tbody>
    </table>
</div>

    </div>

    <!-- Add New Customer Representative Form -->
    <div class="w-full max-w-4xl px-4 mt-8">
        <div class="bg-white shadow-md rounded-lg p-6">
            <h2 class="text-2xl font-semibold text-gray-800 mb-4">Add New Customer Representative</h2>
            <form method="post" action="addCustomerRep.jsp" class="space-y-4">
                <div>
                    <label for="firstName" class="block text-lg font-medium text-gray-700">First Name:</label>
                    <input 
                        type="text" 
                        name="firstName" 
                        id="firstName" 
                        class="w-full px-3 py-2 border border-gray-300 rounded-md focus:ring-2 focus:ring-blue-500 focus:outline-none" 
                        required>
                </div>
                <div>
                    <label for="lastName" class="block text-lg font-medium text-gray-700">Last Name:</label>
                    <input 
                        type="text" 
                        name="lastName" 
                        id="lastName" 
                        class="w-full px-3 py-2 border border-gray-300 rounded-md focus:ring-2 focus:ring-blue-500 focus:outline-none" 
                        required>
                </div>
                <div>
                    <label for="username" class="block text-lg font-medium text-gray-700">Username:</label>
                    <input 
                        type="text" 
                        name="username" 
                        id="username" 
                        class="w-full px-3 py-2 border border-gray-300 rounded-md focus:ring-2 focus:ring-blue-500 focus:outline-none" 
                        required>
                </div>
                <div>
                    <label for="password" class="block text-lg font-medium text-gray-700">Password:</label>
                    <input 
                        type="password" 
                        name="password" 
                        id="password" 
                        class="w-full px-3 py-2 border border-gray-300 rounded-md focus:ring-2 focus:ring-blue-500 focus:outline-none" 
                        required>
                </div>
                <div>
                    <label for="ssn" class="block text-lg font-medium text-gray-700">SSN:</label>
                    <input 
                        type="text" 
                        name="ssn" 
                        id="ssn" 
                        placeholder="XXX-XX-XXXX" 
                        class="w-full px-3 py-2 border border-gray-300 rounded-md focus:ring-2 focus:ring-blue-500 focus:outline-none" 
                        required>
                </div>
                <div class="text-center mt-8">
                <button 
                    type="submit" 
                    class="bg-blue-600 text-white py-3 px-6 rounded-md hover:bg-blue-700 transition">
                    Add Customer Representative
                </button>
                </div>
            </form>
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

