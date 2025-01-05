<%@ include file="dbConnection.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add Customer Representative</title>
</head>
<body>
    <% 
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String ssn = request.getParameter("ssn");

        if (firstName != null && lastName != null && username != null && password != null && ssn != null) {
            try {
                String query = "INSERT INTO CustomerRepresentatives (SSN, FirstName, LastName, Username, Password) VALUES (?, ?, ?, ?, ?)";
                PreparedStatement stmt = ((Connection) request.getAttribute("dbConnection")).prepareStatement(query);
                stmt.setString(1, ssn);
                stmt.setString(2, firstName);
                stmt.setString(3, lastName);
                stmt.setString(4, username);
                stmt.setString(5, password);

                int rows = stmt.executeUpdate();

                if (rows > 0) {
                    out.println("<p>Customer representative added successfully!</p>");
                } else {
                    out.println("<p>Error: Failed to add customer representative. Please try again.</p>");
                }
            } catch (Exception e) {
                out.println("<p>Error: " + e.getMessage() + "</p>");
            }
        } else {
            out.println("<p>Error: All fields are required. Please go back and fill the form properly.</p>");
        }
    %>
    <a href="manageCustomerReps.jsp">Back to Manage Customer Representatives</a>
</body>
</html>
