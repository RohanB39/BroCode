<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="project.ConnectionProvider"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>E-Cart Edit Product</title>
<link rel="stylesheet" href="anp.css">
</head>
<body>
	<%
	String id = request.getParameter("id");
	try {
		Connection con = ConnectionProvider.getCon();
		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery("select * from product where Id='" + id + "'");
		while (rs.next()) {
	%>

	<div class="container">
		<h3>E-Cart! Edit Product</h3>
		<form action="editProductAction.jsp" method="post">
			<h2>
				Product Id:
				<%
			out.println(id);
			%>
			</h2>
			<input type="hidden" value="<%out.println(id);%>">
			<div class="form-group">
				<label for="name">Product Name</label> <input type="text" id="name"
					name="name" value="<%out.println(rs.getString(2));%>" required>
			</div>
			<div class="form-group">
				<label for="category">Enter Category</label> <select name="category"
					id="category">
					<option value="electronics">Electronics</option>
					<option value="clothing">Clothing</option>
					<option value="grocery">Grocery</option>
				</select>
			</div>
			<div class="form-group">
				<label for="price">Enter Price</label> <input type="number" id="name"
					name="price" value="<%out.println(rs.getString(4));%>" required>
			</div>
			<div class="form-group">
				<label for="active">Active</label> <select id="active" name="active">
					<option value="yes">Yes</option>
					<option value="no">No</option>
				</select>
			</div>
			<div class="form-group">
				<button type="submit">
					Save <i class="far fa-arrow-alt-circle-right"></i>
				</button>
				<h2>
					<a class="back" href="allEditProduct.jsp"><i
						class='fas fa-arrow-circle-left'> Back</i></a>
				</h2>

			</div>
			<%
			String msg = request.getParameter("msg");
			if ("done".equals(msg)) {
			%>
			<div class="success-message">Action Done Successfully!</div>
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
		</form>

		<%
		}
		} catch (Exception e) {
		e.printStackTrace();
		}
		%>
	</div>

</body>
<br>
<br>
<br>
</html>