<%@page import="project.ConnectionProvider" %>
<%@page import="java.sql.*" %>
<%@page import="javax.servlet.http.*,javax.servlet.*" %>
<%@page errorPage="error.jsp" %>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Add Address Action</title>
</head>
<body>
<%
String email = session.getAttribute("email").toString();
String address = request.getParameter("address");
String city = request.getParameter("city");
String state = request.getParameter("state");
String country = request.getParameter("country");
String mobile = request.getParameter("mobile");

Connection con = null;
PreparedStatement pstmt = null;

try {
    con = ConnectionProvider.getCon();
    String query = "UPDATE cart SET Address=?, City=?, State=?, Country=?, Mobile_Number=? WHERE Email=? AND Address IS NULL";
    pstmt = con.prepareStatement(query);
    pstmt.setString(1, address);
    pstmt.setString(2, city);
    pstmt.setString(3, state);
    pstmt.setString(4, country);
    pstmt.setString(5, mobile);
    pstmt.setString(6, email);
    pstmt.executeUpdate();
    response.sendRedirect("myCart.jsp?msg=addressAdded");
} catch (Exception e) {
    e.printStackTrace();
    response.sendRedirect("myCart.jsp?msg=error");
} finally {
    if (pstmt != null) {
        try {
            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    if (con != null) {
        try {
            con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
%>
</body>
</html>
