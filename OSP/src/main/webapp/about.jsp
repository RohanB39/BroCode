<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="project.ConnectionProvider"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>E-Cart! About</title>
<link rel="stylesheet" href="css/about.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
</head>
<body>
	<header class="navbar">
		<div class="nav-container">
			<div class="logo">
				E-Cart<i>!</i>
			</div>
			<nav>
				<ul>
					<li><a href="home.jsp">Home</a></li>
					<li><a href="about.jsp" style="color: #5001b3;">About</a></li>
					<li><a href="myCart.jsp">My Cart</a></li>
					<li><a href="#">My Orders</a></li>
					<li><a href="#">Change Details</a></li>
					<li><a href="#">Message Us</a></li>
					<li><a href="logOut.jsp">Logout</a></li>
				</ul>
			</nav>
		</div>
	</header>
	<div class="content">
		<div class="left">
			<div class="main-content">
				<h3>new arrivals</h3>
				<h1>just for</h1>
				<h2>you</h2>
			</div>
			<div class="location">
				<i class="fa-solid fa-location-dot"></i>
				<p>
					Wonder City, <br> Katraj, Katraj, Pune 411046
			</div>
		</div>
		<div class="middle">
			<%
			String email = (String) session.getAttribute("email");
			String userName = "Guest";
			if (email != null) {
				Connection con = null;
				PreparedStatement stmt = null;
				ResultSet rs = null;
				try {
					con = ConnectionProvider.getCon();
					String query = "SELECT name FROM users WHERE Email = ?";
					stmt = con.prepareStatement(query);
					stmt.setString(1, email);
					rs = stmt.executeQuery();
					if (rs.next()) {
				userName = rs.getString("name");
					}
				} catch (Exception e) {
					e.printStackTrace();
				} finally {
					if (rs != null)
				try {
					rs.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
					if (stmt != null)
				try {
					stmt.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
					if (con != null)
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
				}
			}
			%>
			<div class="user">
				<p>Welcome </p>
				<b><%=userName%></b>
				<p>to the E-Cart<i>!</i> leading online platform.
			</div>
			
			<div class="white-round">
				<div class="white-circle"></div>
				<img alt="" src="img/about.png">
			</div>
		</div>

		<div class="right" style="display: flex; align-items: center; justify-content: center;">
			<p class="assay" style="line-height: 40px; font-size: 19px; margin-right: 20px; text-align: inherit;">Welcome to E-Cart! Discover a world of convenience and style with our curated collection of products. From everyday essentials to exclusive finds, elevate your shopping experience with quality and affordability. Happy shopping, and thank you for choosing E-Cart! </p>
		</div>
	</div>
</body>
</html>