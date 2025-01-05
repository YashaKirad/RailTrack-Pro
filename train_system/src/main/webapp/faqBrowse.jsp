<%-- <%@ include file="dbConnection.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Browse FAQs</title>
    <!-- Add Tailwind CSS via CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 text-gray-800 font-sans">

    <!-- Header -->
    <header class="text-center py-6">
        <h1 class="text-3xl font-semibold text-gray-900">Frequently Asked Questions</h1>
    </header>

    <!-- FAQs Table -->
    <% 
        String query = "SELECT FAQID, Question, Answer, DateAsked FROM FAQs";
        PreparedStatement stmt = ((Connection) request.getAttribute("dbConnection")).prepareStatement(query);
        ResultSet rs = stmt.executeQuery();
    %>

    <div class="overflow-x-auto px-4">
        <table class="min-w-full table-auto bg-white border-collapse border border-gray-300">
            <thead>
                <tr class="bg-gray-800 text-white">
                    <th class="px-4 py-2">Date Asked</th>
                    <th class="px-4 py-2">Question</th>
                    <th class="px-4 py-2">Answer</th>
                </tr>
            </thead>
            <tbody>
                <% while (rs.next()) { %>
                    <tr class="border-b">
                        <td class="px-4 py-2"><%= rs.getDate("DateAsked") %></td>
                        <td class="px-4 py-2"><%= rs.getString("Question") %></td>
                        <td class="px-4 py-2"><%= rs.getString("Answer") != null ? rs.getString("Answer") : "Awaiting Response" %></td>
                    </tr>
                <% } %>
            </tbody>
        </table>
    </div>

    <!-- Back to Dashboard Button -->
    <div class="text-center mt-6">
        <form action="customerRepDashboard.jsp" method="post">
            <button type="submit" class="bg-gray-800 text-white py-3 px-6 rounded-md hover:bg-gray-700 transition">Back to Dashboard</button>
        </form>
    </div>

</body>
</html>
--%>

<%@ include file="dbConnection.jsp" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Browse FAQs</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>

<body class="bg-gray-100 min-h-screen flex flex-col items-center">
    <!-- Header -->
    <header class="text-center py-8">
        <h1 class="text-3xl font-bold text-gray-800">Frequently Asked Questions</h1>
    </header>

    <!-- FAQs Table -->
    <%
        String query = "SELECT FAQID, Question, Answer, DateAsked FROM FAQs";
        PreparedStatement stmt = ((Connection) request.getAttribute("dbConnection")).prepareStatement(query);
        ResultSet rs = stmt.executeQuery();
    %>
    <div class="w-full max-w-6xl px-4">
        <div class="overflow-x-auto bg-white shadow-md rounded-lg">
            <table class="min-w-full table-auto border-collapse">
                <thead>
                    <tr class="bg-blue-600 text-white">
                        <th class="px-4 py-2 text-left">Date Asked</th>
                        <th class="px-4 py-2 text-left">Question</th>
                        <th class="px-4 py-2 text-left">Answer</th>
                    </tr>
                </thead>
                <tbody>
                    <% while (rs.next()) { %>
                        <tr class="border-b hover:bg-gray-50">
                            <td class="px-4 py-2"><%= rs.getDate("DateAsked") %></td>
                            <td class="px-4 py-2 text-gray-700"><%= rs.getString("Question") %></td>
                            <td class="px-4 py-2 text-gray-700"><%= rs.getString("Answer") != null ? rs.getString("Answer") : "Awaiting Response" %></td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>

        <!-- Back to Dashboard Button -->
        <div class="text-center mt-6 mb-6">
            <form action="customerRepDashboard.jsp" method="post">
                <button type="submit" class="bg-gray-800 text-white py-3 px-6 rounded-md hover:bg-gray-700 transition">
                    Back to Dashboard
                </button>
            </form>
        </div>
</body>

</html>

