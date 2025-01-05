<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>RailTrack Pro - Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100 min-h-screen flex items-center justify-center relative">
    <!-- Background Image -->
    <div class="absolute inset-0 bg-cover bg-center opacity-20" style="background-image: url('https://upload.wikimedia.org/wikipedia/commons/2/2f/Amtrak_Auto_Train_52_Passing_Through_Guinea_Station%2C_Virginia.jpg')"></div>
    
    <div class="container mx-auto px-4 py-8 max-w-md text-center bg-white shadow-md rounded-lg relative z-10">
        <h1 class="text-4xl font-bold text-blue-800 mb-8">RailTrack Pro</h1>
        <h2 class="text-xl text-gray-600 mb-6">Railway Management System</h2>
        
        <!-- Navigation Tabs -->
        <div class="space-y-4">
            <a href="customerLogin.jsp" class="block w-full bg-blue-600 text-white text-lg py-3 rounded-md hover:bg-blue-700 transition">
                Login as Customer
            </a>
            <a href="customerRepLogin.jsp" class="block w-full bg-blue-600 text-white text-lg py-3 rounded-md hover:bg-blue-700 transition">
                Login as Customer Representative
            </a>
            <a href="adminLogin.jsp" class="block w-full bg-blue-600 text-white text-lg py-3 rounded-md hover:bg-blue-700 transition">
                Login as Admin
            </a>
        </div>

        <!-- Footer -->
        <div class="mt-6 text-gray-500 text-sm">
            &copy; 2024 RailTrack Pro. All Rights Reserved.
        </div>
    </div>
</body>
</html>