<%-- <%@ include file="dbConnection.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>FAQ</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            background-color: #f4f4f9;
        }
        .form-container, .results-container {
            margin: 20px auto;
            width: 80%;
        }
        table {
            width: 100%;
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
        .input-field {
            margin: 10px 0;
            padding: 10px;
            width: 80%;
        }
        .button {
            padding: 10px 20px;
            margin: 10px;
            background-color: #444;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <h1>Frequently Asked Questions</h1>
    <!-- Search Bar -->
    <div class="form-container">
        <form method="get">
            <input type="text" name="keyword" placeholder="Search by keyword" class="input-field">
            <button type="submit" class="button">Search</button>
        </form>
    </div>

    <!-- FAQ Results -->
    <div class="results-container">
        <%
            String keyword = request.getParameter("keyword");
            String query = "SELECT FAQID, Question, Answer, DateAsked FROM FAQs";

            if (keyword != null && !keyword.trim().isEmpty()) {
                query += " WHERE Question LIKE ?";
            }

            // Use the already included connection from dbConnection.jsp
            PreparedStatement stmt = ((Connection) request.getAttribute("dbConnection")).prepareStatement(query);

            if (keyword != null && !keyword.trim().isEmpty()) {
                stmt.setString(1, "%" + keyword + "%");
            }

            ResultSet rs = stmt.executeQuery();
        %>
        <table>
            <thead>
                <tr>
                    <th>Date Asked</th>
                    <th>Question</th>
                    <th>Answer</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    while (rs.next()) { 
                %>
                <tr>
                    <td><%= rs.getDate("DateAsked") %></td>
                    <td><%= rs.getString("Question") %></td>
                    <td><%= rs.getString("Answer") != null ? rs.getString("Answer") : "Awaiting Response" %></td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>

    <!-- Add New Question -->
    <div class="form-container">
        <form method="post" action="addQuestion.jsp">
            <textarea name="question" class="input-field" placeholder="Ask your question here..." required></textarea>
            <button type="submit" class="button">Submit</button>
        </form>
        <form action="customerDashboard.jsp" method="post">
            <button type="submit" class="button">Dashboard</button>
        </form>
    </div>
</body>
</html>
--%>






<%-- <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ include file="dbConnection.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>FAQ</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <script>
        function toggleAnswer(elementId) {
            const answerElement = document.getElementById(elementId);
            const chevronElement = document.getElementById('chevron-' + elementId);
            
            answerElement.classList.toggle('hidden');
            chevronElement.classList.toggle('rotate-180');
        }

        function filterFAQs() {
            const searchInput = document.getElementById('search-input').value.toLowerCase();
            const faqRows = document.querySelectorAll('.faq-row');
            let visibleCount = 0;

            faqRows.forEach(row => {
                const question = row.getAttribute('data-question').toLowerCase();
                
                if (question.includes(searchInput)) {
                    row.classList.remove('hidden');
                    visibleCount++;
                } else {
                    row.classList.add('hidden');
                }
            });

            const noResultsElement = document.getElementById('no-results');
            if (visibleCount === 0) {
                noResultsElement.classList.remove('hidden');
            } else {
                noResultsElement.classList.add('hidden');
            }
        }
    </script>
</head>
<body class="bg-gray-100 min-h-screen">
    <%
        String username = request.getParameter("username");
    %>
    <div class="container mx-auto px-4 py-8 max-w-4xl">
        <h1 class="text-3xl font-bold text-center mb-8 text-gray-800">Frequently Asked Questions</h1>

        <!-- Search Bar -->
        <div class="mb-6">
            <div class="relative">
                <input 
                    type="text" 
                    id="search-input"
                    placeholder="Search FAQs..." 
                    onkeyup="filterFAQs()"
                    class="w-full pl-10 pr-4 py-2 rounded-lg border border-gray-300 focus:outline-none focus:ring-2 focus:ring-blue-500"
                />
                <svg xmlns="http://www.w3.org/2000/svg" class="absolute left-3 top-1/2 -translate-y-1/2 text-gray-400 w-5 h-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
                </svg>
            </div>
        </div>

        <%
            String keyword = request.getParameter("keyword");
            String query = "SELECT FAQID, Question, Answer, DateAsked FROM FAQs";
            if (keyword != null && !keyword.trim().isEmpty()) {
                query += " WHERE Question LIKE ?";
            }
            PreparedStatement stmt = ((Connection) request.getAttribute("dbConnection")).prepareStatement(query);
            if (keyword != null && !keyword.trim().isEmpty()) {
                stmt.setString(1, "%" + keyword + "%");
            }
            ResultSet rs = stmt.executeQuery();
            int index = 0;
        %>

        <div id="no-results" class="hidden text-center p-8 text-gray-500">
            <svg xmlns="http://www.w3.org/2000/svg" class="mx-auto mb-4 text-gray-300 w-12 h-12" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9.172 16.172a4 4 0 015.656 0M9 10h.01M15 10h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
            </svg>
            <p>No FAQs found matching your search</p>
        </div>

        <div class="bg-white shadow-md rounded-lg overflow-hidden">
            <% 
                while (rs.next()) { 
                    String faqId = "faq-" + (++index);
                    String question = rs.getString("Question");
                    String answer = rs.getString("Answer");
                    java.sql.Date dateAsked = rs.getDate("DateAsked");
            %>
                <div class="faq-row border-b border-gray-200 hover:bg-gray-50 transition-colors" 
                     data-question="<%= question.replaceAll("\"", "&quot;") %>"
                     id="<%= faqId + "-container" %>">
                    <div 
                        onclick="toggleAnswer('<%= faqId %>')" 
                        class="flex items-center justify-between p-4 cursor-pointer"
                    >
                        <div class="flex items-center space-x-4">
                            <div class="text-sm text-gray-500 w-24">
                                <%= new java.text.SimpleDateFormat("MM/dd/yyyy").format(dateAsked) %>
                            </div>
                            <div class="flex-grow">
                                <h3 class="text-base font-semibold text-gray-800 truncate max-w-md">
                                    <%= question %>
                                </h3>
                            </div>
                        </div>
                        <svg id="chevron-<%= faqId %>" xmlns="http://www.w3.org/2000/svg" class="text-gray-500 w-6 h-6 transform transition-transform" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7" />
                        </svg>
                    </div>
                    
                    <div id="<%= faqId %>" class="hidden p-4 bg-gray-50 text-gray-700">
                        <%= answer != null ? answer : "Awaiting Response" %>
                    </div>
                </div>
            <% } %>
        </div>

        <!-- Add New Question -->
        <div class="mt-6 flex justify-center space-x-4">
            <form method="post" action="addQuestion.jsp"     onsubmit="this.action += '?username=<%= username %>'" 
             class="w-full max-w-md">
                <textarea name="question" class="w-full p-3 border rounded-lg mb-4" placeholder="Ask your question here..." required></textarea>
                <div class="flex space-x-4">
                    <button type="submit" class="flex-grow bg-blue-600 text-white py-2 rounded-lg hover:bg-blue-700 transition-colors">
                        Submit Question
                    </button>
                    <button 
                        onclick="window.location.href='customerDashboard.jsp?username=<%= username %>'" 
                        type="button" 
                        class="flex-grow bg-gray-500 text-white py-2 rounded-lg hover:bg-gray-600 transition-colors"
                    >
                        Dashboard
                    </button>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
--%>




<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ include file="dbConnection.jsp" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <title>FAQ</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <script>
        function toggleAnswer(elementId) {
            const answerElement = document.getElementById(elementId);
            const chevronElement = document.getElementById('chevron-' + elementId);

            answerElement.classList.toggle('hidden');
            chevronElement.classList.toggle('rotate-180');
        }

        function filterFAQs() {
            const searchInput = document.getElementById('search-input').value.toLowerCase();
            const faqRows = document.querySelectorAll('.faq-row');
            let visibleCount = 0;

            faqRows.forEach(row => {
                const question = row.getAttribute('data-question').toLowerCase();

                if (question.includes(searchInput)) {
                    row.classList.remove('hidden');
                    visibleCount++;
                } else {
                    row.classList.add('hidden');
                }
            });

            const noResultsElement = document.getElementById('no-results');
            noResultsElement.classList.toggle('hidden', visibleCount !== 0);
        }
    </script>
</head>

<body class="bg-gray-100 min-h-screen flex items-center justify-center">
    <%
        String username = request.getParameter("username");
    %>
    <div class="bg-white shadow-md rounded-lg px-6 py-8 max-w-4xl w-full">
        <h1 class="text-3xl font-bold text-center text-gray-800 mb-8">Frequently Asked Questions</h1>

        <!-- Search Bar -->
        <div class="mb-6">
            <div class="relative">
                <input 
                    type="text" 
                    id="search-input"
                    placeholder="Search FAQs..." 
                    onkeyup="filterFAQs()"
                    class="w-full pl-10 pr-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
                />
                <svg xmlns="http://www.w3.org/2000/svg" class="absolute left-3 top-1/2 -translate-y-1/2 text-gray-400 w-5 h-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
                </svg>
            </div>
        </div>

        <%
            String query = "SELECT FAQID, Question, Answer, DateAsked FROM FAQs";
            PreparedStatement stmt = ((Connection) request.getAttribute("dbConnection")).prepareStatement(query);
            ResultSet rs = stmt.executeQuery();
            int index = 0;
        %>

        <!-- No Results Message -->
        <div id="no-results" class="hidden text-center p-8 text-gray-500">
            <svg xmlns="http://www.w3.org/2000/svg" class="mx-auto mb-4 text-gray-300 w-12 h-12" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9.172 16.172a4 4 0 015.656 0M9 10h.01M15 10h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
            </svg>
            <p>No FAQs found matching your search</p>
        </div>

        <!-- FAQ List -->
        <div class="bg-white shadow-md rounded-lg overflow-hidden">
            <% 
                while (rs.next()) { 
                    String faqId = "faq-" + (++index);
                    String question = rs.getString("Question");
                    String answer = rs.getString("Answer");
                    java.sql.Date dateAsked = rs.getDate("DateAsked");
            %>
            <div class="faq-row border-b border-gray-200 hover:bg-gray-50 transition-colors" 
                 data-question="<%= question.replaceAll("\"", "&quot;") %>"
                 id="<%= faqId + "-container" %>">
                <div 
                    onclick="toggleAnswer('<%= faqId %>')" 
                    class="flex items-center justify-between p-4 cursor-pointer"
                >
                    <div class="flex items-center space-x-4">
                        <div class="text-sm text-gray-500 w-24">
                            <%= new java.text.SimpleDateFormat("MM/dd/yyyy").format(dateAsked) %>
                        </div>
                        <div class="flex-grow">
                            <h3 class="text-base font-semibold text-gray-800 truncate max-w-md">
                                <%= question %>
                            </h3>
                        </div>
                    </div>
                    <svg id="chevron-<%= faqId %>" xmlns="http://www.w3.org/2000/svg" class="text-gray-500 w-6 h-6 transform transition-transform" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7" />
                    </svg>
                </div>

                <div id="<%= faqId %>" class="hidden p-4 bg-gray-50 text-gray-700">
                    <%= answer != null ? answer : "Awaiting Response" %>
                </div>
            </div>
            <% } %>
        </div>

        <!-- Add New Question -->
        <div class="mt-6 flex justify-center">
<form method="post" action="addQuestion.jsp?username=<%= username %>" class="w-full max-w-lg">
    <textarea name="question" class="w-full p-3 border border-gray-300 rounded-lg mb-4 focus:ring-2 focus:ring-blue-500" placeholder="Ask your question here..." required></textarea>
    <div class="flex space-x-4">
        <button type="submit" class="flex-grow bg-blue-600 text-white py-2 rounded-lg hover:bg-blue-700 transition">
            Submit Question
        </button>
        <button 
            onclick="window.location.href='customerDashboard.jsp?username=<%= username %>'" 
            type="button" 
            class="bg-gray-800 text-white py-3 px-6 rounded-md hover:bg-gray-700 transition"
        >
            Dashboard
        </button>
    </div>
</form>

        </div>
    </div>
</body>

</html>