<%@ include file="dbConnection.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Admin Accounts</title>
</head>
<body>
    <h1>Manage Admin Accounts</h1>
    <% 
        String query = "SELECT AdminID, Username FROM Admin";
        PreparedStatement stmt = ((Connection) request.getAttribute("dbConnection")).prepareStatement(query);
        ResultSet rs = stmt.executeQuery();
    %>
    <form method="post" action="updateAdmin.jsp">
        <table>
            <thead>
                <tr>
                    <th>Admin ID</th>
                    <th>Username</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <% while (rs.next()) { %>
                <tr>
                    <td><%= rs.getInt("AdminID") %></td>
                    <td><%= rs.getString("Username") %></td>
                    <td>
                        <button type="submit" name="edit" value="<%= rs.getInt("AdminID") %>">Edit</button>
                        <button type="submit" name="delete" value="<%= rs.getInt("AdminID") %>">Delete</button>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </form>
    <h2>Add New Admin</h2>
    <form method="post" action="addAdmin.jsp">
        <input type="text" name="username" placeholder="Username" required>
        <input type="password" name="password" placeholder="Password" required>
        <button type="submit">Add Admin</button>
    </form>
</body>
</html>
