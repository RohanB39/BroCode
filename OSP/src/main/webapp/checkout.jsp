<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="project.ConnectionProvider"%>
<%@ page import="java.sql.*, java.util.*, java.text.SimpleDateFormat" %>
<%@page errorPage="error.jsp"%>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>E-Cart Checkout</title>
<link rel="stylesheet" href="css/checkout.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
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
					<li><a href="about.jsp">About</a></li>
					<li><a href="checkout.jsp" style="color: #5001b3;">Checkout</a></li>
					<li><a href="myCart.jsp">My Cart</a></li>
					<li><a href="#">My Orders</a></li>
					<li><a href="#">Change Details</a></li>
					<li><a href="#">Message Us</a></li>
					<li><a href="logOut.jsp">Logout</a></li>
				</ul>
			</nav>
		</div>
	</header>

<%
	Connection con = null;
	Statement stmt = null;
	ResultSet rs = null;
	String userEmail = request.getParameter("email");

	if (userEmail == null || userEmail.isEmpty()) {
		userEmail = "default@example.com"; // Replace with actual default or logic to get the user email
	}

	String address = "", city = "", state = "", country = "", mobileNumber = "";
	List<Map<String, String>> products = new ArrayList<>();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	String orderDate = "";
	String deliveryDate = "";

	try {
		con = ConnectionProvider.getCon();
		stmt = con.createStatement();
		String userDetailsQuery = "SELECT * FROM cart WHERE Email='" + userEmail + "'";
		rs = stmt.executeQuery(userDetailsQuery);

		while (rs.next()) {
			Map<String, String> product = new HashMap<>();
			product.put("Product_Id", rs.getString("Product_Id"));
			product.put("Quantity", rs.getString("Quantity"));
			product.put("Price", rs.getString("Price"));
			product.put("Total", rs.getString("Total"));
			products.add(product);

			address = rs.getString("Address");
			city = rs.getString("City");
			state = rs.getString("State");
			country = rs.getString("Country");
			mobileNumber = rs.getString("Mobile_Number");
		}

		orderDate = sdf.format(new Date());
		Calendar c = Calendar.getInstance();
		c.setTime(new Date());
		c.add(Calendar.DATE, 4);
		deliveryDate = sdf.format(c.getTime());
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
		if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
		if (con != null) try { con.close(); } catch (SQLException e) { e.printStackTrace(); }
	}
%>

	<h1>Checkout Page</h1>
	<p style=" margin-left: 25px; font-weight: 600;">User Email: <%= userEmail %></p>
	<div class="container" style="display: grid; grid-template-columns: 1fr 2fr 1fr; gap: 20px; padding: 20px;">
		
		<div class="products">
			<h3>Selected Products</h3>
			<%
			for (Map<String, String> product : products) {
			%>
			<div class="product-item">
				<p><strong>Product ID:</strong> <%= product.get("Product_Id") %></p>
				<p><strong>Quantity:</strong> <%= product.get("Quantity") %></p>
				<p><strong>Price:</strong> <%= product.get("Price") %></p>
				<p><strong>Total:</strong> <%= product.get("Total") %></p>
			</div>
			<%
			}
			%>
		</div>

		<!-- Second Column: Address Form -->
		<div class="shipping-details">
			<h3>Shipping Details</h3>
			<form action="updateDetails.jsp" method="POST">
				<input type="hidden" name="email" value="<%= userEmail %>">
				<input class="form-control" type="text" name="address" value="<%= address %>" placeholder="Address" required>
				<input class="form-control" type="text" name="city" value="<%= city %>" placeholder="City" required>
				<input class="form-control" type="text" name="state" value="<%= state %>" placeholder="State" required>
				<input class="form-control" type="text" name="country" value="<%= country %>" placeholder="Country" required>
				<input class="form-control" type="text" name="mobile_number" value="<%= mobileNumber %>" placeholder="Mobile Number" required>
				<button type="submit" class="btn">Update Details</button>
			</form>
		</div>

		<div class="order-details">
			<h3>Order Details</h3>
			<p><strong>Order Date:</strong> <%= orderDate %></p>
			<p><strong>Delivery Date:</strong> <%= deliveryDate %></p>
			<form action="payment.jsp" method="POST">
				<input type="hidden" name="email" value="<%= userEmail %>">
				<input type="hidden" name="order_date" value="<%= orderDate %>">
				<input type="hidden" name="delivery_date" value="<%= deliveryDate %>">
				<label for="payment_method">Payment Method:</label>
				<select class="form-control" name="payment_method" id="payment_method">
					<option value="Credit Card">Credit Card</option>
					<option value="Debit Card">Debit Card</option>
					<option value="PhonePe">PhonePe</option>
					<option value="Net Banking">Net Banking</option>
				</select>
				<button type="submit" class="btn">Proceed to Payment</button>
			</form>
		</div>
	</div>
</body>
</html>
