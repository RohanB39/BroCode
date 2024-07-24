<%@page import="project.ConnectionProvider"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<title>E-Cart Users</title>
<link rel="stylesheet"
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet"
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<link rel="stylesheet"
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<link rel="stylesheet" href="usersT.css">
</head>
<body>
    <div class="dashboard-container">
        <div class="content" id="content">
            <div class="owner">
                <p>
                    Hello <span> <% out.println(session.getAttribute("email")); %>
                    </span>
                </p>
                <p class="blue">E-Cart<i>!</i></p>
            </div>
            <div class="quick-details card" style="background-color: #f8d7da;">
                <h3>Customers Details</h3>
                <%
                int totalUsers = 0;
                try {
                    Connection con = ConnectionProvider.getCon();
                    PreparedStatement psCount = con.prepareStatement("SELECT COUNT(*) AS total_users FROM users");
                    ResultSet rsCount = psCount.executeQuery();
                    if (rsCount.next()) {
                        totalUsers = rsCount.getInt("total_users");
                    }
                    PreparedStatement ps = con.prepareStatement("SELECT name, email, MobileNumber FROM users");
                    ResultSet rs = ps.executeQuery();
                %>
                <p style="color: green;">Total Customers(<b><%= totalUsers %></b>)</p>
                <table>
                    <thead>
                        <tr>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Mobile</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                        while (rs.next()) {
                            String name = rs.getString("name");
                            String email = rs.getString("email");
                            String mobile = rs.getString("MobileNumber");
                        %>
                        <tr>
                            <td><%= name %></td>
                            <td><%= email %></td>
                            <td><%= mobile %></td>
                        </tr>
                        <%
                        }
                        %>
                    </tbody>
                </table>
                <%
                    rs.close();
                    ps.close();
                    rsCount.close();
                    psCount.close();
                    con.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
                %>
            </div>
        </div>
    </div>
</body>
</html>
