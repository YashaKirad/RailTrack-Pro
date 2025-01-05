<%-- <%@ include file="dbConnection.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reply to FAQs</title>
    <!-- Add Tailwind CSS via CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 text-gray-800 font-sans">

    <!-- Header -->
    <header class="text-center py-6">
        <h1 class="text-3xl font-semibold text-gray-900">Reply to Customer Questions</h1>
    </header>

    <!-- FAQs Table and Form -->
    <% 
        // Fetch unanswered questions
        String query = "SELECT FAQID, Question, DateAsked FROM FAQs WHERE Answer IS NULL";
        PreparedStatement stmt = ((Connection) request.getAttribute("dbConnection")).prepareStatement(query);
        ResultSet rs = stmt.executeQuery();
    %>

    <div class="max-w-4xl mx-auto px-4 py-6">
        <% if (!rs.isBeforeFirst()) { %>
            <p class="text-lg text-gray-700">No unanswered questions at the moment.</p>
        <% } else { %>
            <form method="post" action="submitFAQReply.jsp">
                <table class="min-w-full table-auto bg-white border-collapse border border-gray-300">
                    <thead>
                        <tr class="bg-gray-800 text-white">
                            <th class="px-4 py-2">FAQ ID</th>
                            <th class="px-4 py-2">Question</th>
                            <th class="px-4 py-2">Date Asked</th>
                            <th class="px-4 py-2">Reply</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% while (rs.next()) { %>
                            <tr class="border-b">
                                <td class="px-4 py-2"><%= rs.getInt("FAQID") %></td>
                                <td class="px-4 py-2"><%= rs.getString("Question") %></td>
                                <td class="px-4 py-2"><%= rs.getDate("DateAsked") %></td>
                                <td class="px-4 py-2">
                                    <textarea name="answer_<%= rs.getInt("FAQID") %>" rows="3" class="w-full p-2 border border-gray-300 rounded-md"></textarea>
                                    <input type="hidden" name="faqID_<%= rs.getInt("FAQID") %>" value="<%= rs.getInt("FAQID") %>">
                                </td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
                <button type="submit" class="bg-gray-800 text-white py-3 px-6 rounded-md mt-4 hover:bg-gray-700 transition">Submit Replies</button>
            </form>
        <% } %>
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
    <title>Reply to FAQs</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>

<body class="bg-gray-100 min-h-screen flex flex-col items-center">
    <!-- Header -->
    <header class="text-center py-8">
        <h1 class="text-3xl font-bold text-gray-800">Reply to Customer Questions</h1>
    </header>

    <!-- FAQs Table and Reply Form -->
    <%
        String query = "SELECT FAQID, Question, DateAsked FROM FAQs WHERE Answer IS NULL";
        PreparedStatement stmt = ((Connection) request.getAttribute("dbConnection")).prepareStatement(query);
        ResultSet rs = stmt.executeQuery();
    %>
    <div class="w-full max-w-6xl px-4">
        <% if (!rs.isBeforeFirst()) { %>
            <div class="bg-white shadow-md rounded-lg p-6">
                <p class="text-lg text-gray-700 text-center">No unanswered questions at the moment.</p>
            </div>
        <% } else { %>
            <form method="post" action="submitFAQReply.jsp" class="bg-white shadow-md rounded-lg p-6">
                <div class="overflow-x-auto">
                    <table class="min-w-full table-auto border-collapse">
                        <thead>
                            <tr class="bg-blue-600 text-white">
                                <th class="px-4 py-2 text-left">FAQ ID</th>
                                <th class="px-4 py-2 text-left">Question</th>
                                <th class="px-4 py-2 text-left">Date Asked</th>
                                <th class="px-4 py-2 text-left">Reply</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% while (rs.next()) { %>
                                <tr class="border-b hover:bg-gray-50">
                                    <td class="px-4 py-2"><%= rs.getInt("FAQID") %></td>
                                    <td class="px-4 py-2 text-gray-700"><%= rs.getString("Question") %></td>
                                    <td class="px-4 py-2 text-gray-500"><%= rs.getDate("DateAsked") %></td>
                                    <td class="px-4 py-2">
                                        <textarea 
                                            name="answer_<%= rs.getInt("FAQID") %>" 
                                            rows="3" 
                                            class="w-full border border-gray-300 rounded-md p-2 focus:ring-2 focus:ring-blue-500"
                                            placeholder="Enter your reply here..."
                                            
                                        ></textarea>
                                        <input type="hidden" name="faqID_<%= rs.getInt("FAQID") %>" value="<%= rs.getInt("FAQID") %>">
                                    </td>
                                </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
                <div class="text-center mt-6">
    <button 
        type="submit" 
        class="bg-blue-600 text-white py-3 px-6 rounded-md hover:bg-blue-700 transition inline-block">
        Submit Replies
    </button>
</div>
            </form>
        <% } %>
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

