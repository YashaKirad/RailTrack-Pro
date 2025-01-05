<%@ include file="dbConnection.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Edit Customer Representative</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100 min-h-screen flex justify-center items-center">

    <% 
        String ssn = request.getParameter("ssn");
        if (ssn != null) {
            try {
                String query = "SELECT FirstName, LastName, Username FROM CustomerRepresentatives WHERE SSN = ?";
                PreparedStatement stmt = ((Connection) request.getAttribute("dbConnection")).prepareStatement(query);
                stmt.setString(1, ssn);
                ResultSet rs = stmt.executeQuery();

                if (rs.next()) {
    %>
    <div class="w-full max-w-md bg-white rounded-lg shadow-md p-6">
        <h1 class="text-2xl font-bold text-gray-800 mb-4 text-center">Edit Customer Representative</h1>
        <form method="post" action="updateCustomerRep.jsp" class="space-y-4">
            <!-- Hidden SSN Field -->
            <input type="hidden" name="ssn" value="<%= ssn %>">

            <!-- First Name -->
            <div>
                <label for="firstName" class="block text-sm font-medium text-gray-700">First Name:</label>
                <input 
                    type="text" 
                    name="firstName" 
                    id="firstName" 
                    value="<%= rs.getString("FirstName") %>" 
                    required 
                    class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500"
                >
            </div>

            <!-- Last Name -->
            <div>
                <label for="lastName" class="block text-sm font-medium text-gray-700">Last Name:</label>
                <input 
                    type="text" 
                    name="lastName" 
                    id="lastName" 
                    value="<%= rs.getString("LastName") %>" 
                    required 
                    class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500"
                >
            </div>

            <!-- Username -->
            <div>
                <label for="username" class="block text-sm font-medium text-gray-700">Username:</label>
                <input 
                    type="text" 
                    name="username" 
                    id="username" 
                    value="<%= rs.getString("Username") %>" 
                    required 
                    class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500"
                >
            </div>

            <!-- Password -->
            <div>
                <label for="password" class="block text-sm font-medium text-gray-700">Password:</label>
                <input 
                    type="password" 
                    name="password" 
                    id="password" 
                    placeholder="Enter new password" 
                    required 
                    class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500"
                >
            </div>

            <!-- Submit Button -->
            <div>
                <button 
                    type="submit" 
                    name="action" 
                    value="edit" 
                    class="w-full bg-blue-600 text-white py-2 rounded-md hover:bg-blue-700 transition"
                >
                    Update
                </button>
            </div>
        </form>
    </div>
    <% 
                } else {
                    out.println("<p class='text-red-600'>Error: Representative not found.</p>");
                }
            } catch (Exception e) {
                out.println("<p class='text-red-600'>Error: " + e.getMessage() + "</p>");
            }
        } else {
            out.println("<p class='text-red-600'>Error: No SSN provided.</p>");
        }
    %>
</body>
</html>