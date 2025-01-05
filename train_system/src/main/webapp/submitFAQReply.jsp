<%@ include file="dbConnection.jsp" %>
<%@ page import="java.util.Enumeration" %> <!-- Import Enumeration -->
<!DOCTYPE html>
<html>
<head>
    <title>Submit FAQ Replies</title>
</head>
<body>
    <h1>Submit FAQ Replies</h1>
    <% 
        try {
            // Start a transaction
            ((Connection) request.getAttribute("dbConnection")).setAutoCommit(false);

            // Iterate through all submitted replies
            Enumeration<String> parameterNames = request.getParameterNames();
            while (parameterNames.hasMoreElements()) {
                String paramName = parameterNames.nextElement();
                
                // Only process parameters that start with "answer_"
                if (paramName.startsWith("answer_")) {
                    String answer = request.getParameter(paramName);

                    // Process only non-empty replies
                    if (answer != null && !answer.trim().isEmpty()) {
                        // Extract FAQ ID from the parameter name
                        String faqIDParam = "faqID_" + paramName.split("_")[1];
                        int faqID = Integer.parseInt(request.getParameter(faqIDParam));

                        // Update the FAQ with the provided answer
                        String query = "UPDATE FAQs SET Answer = ?, DateAnswered = NOW() WHERE FAQID = ?";
                        PreparedStatement stmt = ((Connection) request.getAttribute("dbConnection")).prepareStatement(query);
                        stmt.setString(1, answer);
                        stmt.setInt(2, faqID);
                        stmt.executeUpdate();
                    }
                }
            }

            // Commit the transaction
            ((Connection) request.getAttribute("dbConnection")).commit();
            out.println("<script>alert('Replies submitted successfully!'); window.location='faqReply.jsp';</script>");
        } catch (Exception e) {
            try {
                ((Connection) request.getAttribute("dbConnection")).rollback(); // Rollback transaction on error
            } catch (Exception rollbackEx) {
                out.println("<p>Error during rollback: " + rollbackEx.getMessage() + "</p>");
            }
            out.println("<p>Error: " + e.getMessage() + "</p>");
        }
    %>
</body>
</html>