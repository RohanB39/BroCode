<%@page import="project.ConnectionProvider"%>
<%@page import="java.sql.*"%>
<html>
<head>
<title>E-Cart! Add New Product</title>
<link rel="stylesheet" href="anp.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
	<%
	int id = 1;
	try {
		Connection con = ConnectionProvider.getCon();
		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery("select max(Id) from product");
		while (rs.next()) {
			id = rs.getInt(1);
			id = id + 1;
			session.setAttribute("id", id);
		}
	} catch (Exception e) {

	}
	%>
	<div class="container">
		<h3>E-Cart! Add New Product</h3>
		<form action="addNewProductAction.jsp" method="post">
			<h2>
				Product Id:
				<%
			out.println(id);
			%>
			</h2>
			<input type="hidden" value="<%out.println(id);%>">
			<div class="form-group">
				<label for="name">Product Name</label> <input type="text" id="name"
					name="name" required>
			</div>
			<div class="form-group">
				<label for="category">Enter Category</label>
				<select name="category" id="category">
				<option value="Electronics">Electronics</option>
				<option value="Clothing">Clothing</option>
				<option value="Grocery">Grocery</option>
				</select>
			</div>
			<div class="form-group">
				<label for="price">Enter Price</label> <input type="number"
					id="price" name="price" required>
			</div>
			<div class="form-group">
				<label for="active">Active</label> <select id="active" name="active">
					<option value="yes">Yes</option>
					<option value="no">No</option>
				</select>
			</div>
			<div class="form-group">
				<button type="submit"> Save <i class="far fa-arrow-alt-circle-right"></i></button>
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
		</form>
	</div>
</body>
</html>