<%@page import="project.ConnectionProvider"%>
<%@page import="java.sql.*"%>
<%@page import="javax.servlet.http.*,javax.servlet.*"%>
<%@page errorPage="error.jsp"%>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>My Cart</title>
<link rel="stylesheet" href="css/userHome.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<style>
body {
	font-family: 'Poppins', sans-serif;
}

.content {
	margin-top: 60px;
	padding: 20px;
}

.cart-container {
	max-width: 1200px;
	margin: 0 auto;
}

.cart-item {
	display: flex;
	align-items: center;
	justify-content: space-between;
	padding: 15px;
	margin-bottom: 15px;
	border: 1px solid #ddd;
	border-radius: 10px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.cart-item img {
	width: 80px;
	height: 80px;
	border-radius: 10px;
	object-fit: cover;
}

.cart-item-details {
	flex: 1;
	margin-left: 15px;
}

.cart-item-details h3 {
	margin: 0;
	font-size: 1.2em;
}

.cart-item-details p {
	margin: 5px 0;
	color: #555;
}

.cart-actions {
	display: flex;
	align-items: center;
}

.cart-actions button {
	padding: 10px 20px;
	margin-left: 10px;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	font-weight: 500;
}

.btn-checkout {
	background-color: #28a745;
	color: white;
}

.btn-add-address {
	background-color: #ff9800;
	color: white;
}

.user-details {
	margin-top: 20px;
}

.user-details h2 {
	margin: 0;
	font-size: 1.5em;
}
</style>
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
					<li><a href="myCart.jsp" style="color: #5001b3;">My Cart</a></li>
					<li><a href="#">My Orders</a></li>
					<li><a href="#">Change Details</a></li>
					<li><a href="#">Message Us</a></li>
					<li><a href="logOut.jsp">Logout</a></li>
				</ul>
			</nav>
		</div>
	</header>
	<div class="content">
		<div class="cart-container">
			<%
			String email = session.getAttribute("email").toString();
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			boolean addressPresent = false;
			boolean cartNotEmpty = false;

			try {
				con = ConnectionProvider.getCon();
				String addressQuery = "SELECT Address, City, State, Country, Mobile_Number FROM cart WHERE Email = ? AND Address IS NOT NULL LIMIT 1";
				pstmt = con.prepareStatement(addressQuery);
				pstmt.setString(1, email);
				rs = pstmt.executeQuery();

				if (rs.next()) {
					addressPresent = true;
				}

				String cartQuery = "SELECT c.*, p.pName, p.pCategory FROM cart c JOIN product p ON c.Product_Id = p.Id WHERE c.Email = ?";
				pstmt = con.prepareStatement(cartQuery);
				pstmt.setString(1, email);
				rs = pstmt.executeQuery();

				while (rs.next()) {
					cartNotEmpty = true;
			%>
			<div class="cart-item">
				<img src="images/<%=rs.getString("pCategory").toLowerCase()%>.jpg"
					alt="<%=rs.getString("pCategory")%>">
				<div class="cart-item-details">
					<h3><%=rs.getString("pName")%></h3>
					<p>
						Price: Rs.<%=rs.getInt("Price")%></p>
					<p>
						Quantity:
						<%=rs.getInt("Quantity")%></p>
					<p>
						Total: Rs.<%=rs.getInt("Total")%></p>
				</div>
				<div class="cart-actions">
					<form action="myCartAction.jsp" method="post">
						<input type="hidden" name="productId"
							value="<%=rs.getInt("Product_Id")%>">
						<button type="submit" name="action" value="remove"
							class="btn-add-address">Remove</button>
					</form>
				</div>
			</div>
			<%
			}
			} catch (Exception e) {
			e.printStackTrace();
			} finally {
			if (rs != null) {
			try {
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			}
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
			<div class="user-details">
				<h2>
					User:
					<%=email%></h2>
				<%
				if (cartNotEmpty) {
					if (addressPresent) {
				%>
				<form action="myCartAction.jsp" method="post">
					<button type="submit" name="action" value="checkout" class="btn-checkout"><a href="checkout.jsp?email=<%= email %>" style="text-decoration: none; color: white;">Proceed to Checkout</a></button>
				</form>
				<%
				} else {
				%>
				<form action="addAddress.jsp">
					<button type="submit" class="btn-add-address">Add Address</button>
				</form>
				<%
				}
				} else {
				%>
				<p style="font-weight: 700;">Whoops! Your cart is empty. It's
					feeling lonely, why not add some items?</p>
				<%
				}
				%>
			</div>
		</div>
	</div>

</body>
</html>
