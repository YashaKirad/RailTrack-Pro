<%@ include file="dbConnection.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>Update Customer Representative</title>
</head>
<body>
    <% 
        String action = request.getParameter("action");
        String ssn = request.getParameter("ssn");

        if (action != null && ssn != null) {
            if (action.equals("edit")) {
                String firstName = request.getParameter("firstName");
                String lastName = request.getParameter("lastName");
                String username = request.getParameter("username");
                String password = request.getParameter("password");

                if (firstName != null && lastName != null && username != null && password != null) {
                    try {
                        String query = "UPDATE CustomerRepresentatives SET FirstName = ?, LastName = ?, Username = ?, Password = ? WHERE SSN = ?";
                        PreparedStatement stmt = ((Connection) request.getAttribute("dbConnection")).prepareStatement(query);
                        stmt.setString(1, firstName);
                        stmt.setString(2, lastName);
                        stmt.setString(3, username);
                        stmt.setString(4, password);
                        stmt.setString(5, ssn);

                        int rows = stmt.executeUpdate();
                        if (rows > 0) {
                            out.println("<p>Customer representative updated successfully!</p>");
                        } else {
                            out.println("<p>Error: Failed to update customer representative.</p>");
                        }
                    } catch (Exception e) {
                        out.println("<p>Error: " + e.getMessage() + "</p>");
                    }
                } else {
                    out.println("<p>Error: All fields are required for updating.</p>");
                }
            } else if (action.equals("delete")) {
                try {
                    String query = "DELETE FROM CustomerRepresentatives WHERE SSN = ?";
                    PreparedStatement stmt = ((Connection) request.getAttribute("dbConnection")).prepareStatement(query);
                    stmt.setString(1, ssn);

                    int rows = stmt.executeUpdate();
                    if (rows > 0) {
                        out.println("<p>Customer representative deleted successfully!</p>");
                    } else {
                        out.println("<p>Error: Failed to delete customer representative. Ensure the SSN exists.</p>");
                    }
                } catch (Exception e) {
                    out.println("<p>Error: " + e.getMessage() + "</p>");
                }
            }
        } else {
            out.println("<p>Error: Missing required parameters.</p>");
        }
    %>
    <a href="manageCustomerReps.jsp">Back to Manage Customer Representatives</a>
</body>
</html>
