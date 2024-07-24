<%@ page import="java.sql.*" %>
<%@page import="project.ConnectionProvider"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Update Details</title>
<link rel="stylesheet" href="css/updateDetails.css">
<link rel="stylesheet"
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
<%
Connection con = null;
Statement stmt = null;
String email = request.getParameter("email");
String address = request.getParameter("address");
String city = request.getParameter("city");
String state = request.getParameter("state");
String country = request.getParameter("country");
String mobileNumber = request.getParameter("mobile_number");

try {
    con = ConnectionProvider.getCon();
    stmt = con.createStatement();
    String updateQuery = "UPDATE cart SET Address='" + address + "', City='" + city + "', State='" + state + "', Country='" + country + "', Mobile_Number='" + mobileNumber + "' WHERE Email='" + email + "'";
    int rowsUpdated = stmt.executeUpdate(updateQuery);

    if (rowsUpdated > 0) {
%>
        <div class="message success">
            <i class="fas fa-check-circle"></i>
            <h2>Details updated successfully!</h2>
        </div>
<%
    } else {
%>
        <div class="message error">
            <i class="fas fa-exclamation-circle"></i>
            <h2>Failed to update details.</h2>
        </div>
<%
    }
} catch (Exception e) {
    e.printStackTrace();
} finally {
    if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
    if (con != null) try { con.close(); } catch (SQLException e) { e.printStackTrace(); }
}
%>
<div class="back-link">
    <a href="checkout.jsp?email=<%= email %>"><i class="fas fa-arrow-left"></i> Back to Checkout</a>
</div>
</body>
</html>
