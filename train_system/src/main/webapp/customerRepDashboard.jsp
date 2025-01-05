<%-- <%@ include file="dbConnection.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Representative Dashboard</title>
    <!-- Add Tailwind CSS via CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 text-gray-800 font-sans">

    <!-- Dashboard Title -->
    <header class="text-center py-6">
        <h1 class="text-3xl font-semibold text-gray-900">Customer Representative Dashboard</h1>
    </header>

    <!-- Dashboard Content -->
    <div class="container mx-auto p-4 space-y-4">

        <!-- Action Buttons -->
        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4">
            <a href="editDeleteTrainSchedules.jsp" class="block bg-gray-800 text-white text-center py-3 rounded-lg hover:bg-gray-700 transition">Edit/Delete Train Schedules</a>
            <a href="faqBrowse.jsp" class="block bg-gray-800 text-white text-center py-3 rounded-lg hover:bg-gray-700 transition">Browse Questions & Answers</a>
            <a href="faqSearch.jsp" class="block bg-gray-800 text-white text-center py-3 rounded-lg hover:bg-gray-700 transition">Search Questions</a>
            <a href="faqReply.jsp" class="block bg-gray-800 text-white text-center py-3 rounded-lg hover:bg-gray-700 transition">Reply to Questions</a>
            <a href="stationTrainSchedules.jsp" class="block bg-gray-800 text-white text-center py-3 rounded-lg hover:bg-gray-700 transition">Train Schedules for Station</a>
            <a href="transitLineCustomers.jsp" class="block bg-gray-800 text-white text-center py-3 rounded-lg hover:bg-gray-700 transition">Customers on Transit Line</a>
        </div>

        <!-- Logout Button -->
        <form action="logout.jsp" method="post" class="text-center mt-6">
            <button type="submit" class="bg-red-600 text-white py-3 px-6 rounded-lg hover:bg-red-500 transition">Logout</button>
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
    <title>Customer Representative Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>

<body class="bg-gray-100 min-h-screen flex flex-col items-center">

    <!-- Dashboard Header -->
    <header class="text-center py-8">
        <h1 class="text-3xl font-bold text-gray-800">Customer Representative Dashboard</h1>
    </header>

    <!-- Dashboard Content -->
    <div class="container mx-auto px-4">
        <!-- Action Buttons -->
        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
            <a href="editDeleteTrainSchedules.jsp" 
               class="block bg-blue-600 text-white text-center py-4 rounded-lg hover:bg-blue-700 transition">
                Edit/Delete Train Schedules
            </a>
            <a href="faqBrowse.jsp" 
               class="block bg-blue-600 text-white text-center py-4 rounded-lg hover:bg-blue-700 transition">
                Browse Questions & Answers
            </a>
            <a href="faqSearch.jsp" 
               class="block bg-blue-600 text-white text-center py-4 rounded-lg hover:bg-blue-700 transition">
                Search Questions
            </a>
            <a href="faqReply.jsp" 
               class="block bg-blue-600 text-white text-center py-4 rounded-lg hover:bg-blue-700 transition">
                Reply to Questions
            </a>
            <a href="stationTrainSchedules.jsp" 
               class="block bg-blue-600 text-white text-center py-4 rounded-lg hover:bg-blue-700 transition">
                Train Schedules for Station
            </a>
            <a href="transitLineCustomers.jsp" 
               class="block bg-blue-600 text-white text-center py-4 rounded-lg hover:bg-blue-700 transition">
                Customers on Transit Line
            </a>
        </div>

        <!-- Logout Button -->
        <div class="text-center mt-8">
            <form action="logout.jsp" method="post">
                <button type="submit" 
                        class="bg-red-600 text-white py-3 px-6 rounded-lg hover:bg-red-700 transition">
                    Logout
                </button>
            </form>
        </div>
    </div>
</body>

</html>
