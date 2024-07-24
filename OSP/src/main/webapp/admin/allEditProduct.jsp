<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="project.ConnectionProvider" %>
<%@page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>E-Cart Edit Products</title>
<link rel="stylesheet" href="aep.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
	<div class="header">
		All Products & Edit Products <i class='fab fa-elementor'></i>
	</div>
	
	<%
	String msg = request.getParameter("msg");
	if ("done".equals(msg)) {
	%>
	<div class="success-message">Product Added Successfully!</div>
	<%
	}
	%>

	<%
	if ("invalid".equals(msg)) {
	%>
	<div class="error-message">Some thing went wrong! Try Again!</div>
	<%
	}
	%>
	
	<div class="container">
		<table>
			<thead>
				<tr>
					<th scope="col">ID</th>
					<th scope="col">Name</th>
					<th scope="col">Category</th>
					<th scope="col"><i class="fa fa-inr"></i> Price</th>
					<th>Status</th>
					<th scope="col">Edit <i class='fas fa-pen-fancy'></i></th>
				</tr>
			</thead>
			<tbody>
			<%
			try{
				Connection con = ConnectionProvider.getCon();
				Statement st = con.createStatement();
				ResultSet rs = st.executeQuery("select * from product");
				while(rs.next()){
			%>
				<tr>
					<td><%= rs.getString(1) %></td>
					<td><%= rs.getString(2) %></td>
					<td><%= rs.getString(3) %></td>
					<td><i class="fa fa-inr"></i><%= rs.getString(4) %></td>
					<td><%= rs.getString(5) %></td>
					<td><a href="editProduct.jsp?id=<%= rs.getString(1) %>">Edit <i class='fas fa-pen-fancy'></i></a></td>
				</tr>
				<%
				}
			}catch(Exception e){
				System.out.println(e);
			}
				%>
			</tbody>
		</table>
	</div>
</body>
</html>
