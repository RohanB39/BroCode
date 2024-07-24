<%@page import="project.ConnectionProvider"%>
<%@page import="java.sql.*"%>
<%@page errorPage="error.jsp"%>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>E-Cart</title>
<link rel="stylesheet" href="css/userHome.css">
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
					<li><a href="home.jsp" style="color: #5001b3;">Home</a></li>
					<li><a href="about.jsp">About</a></li>
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
		<div class="search" style="width: 50%; margin-left: 80px;">
			<div class="search-bar" style="display: flex; width: 100%;">
				<input type="text" id="searchInput"
					placeholder="Search products by name or category"
					style="flex: 1; padding: 8px; border: 1px solid #ccc; border-radius: 4px 0 0 4px; outline: none;">
				<button onclick="searchProducts()"
					style="padding: 8px 16px; background-color: #28a745; color: white; border: none; border-radius: 0 4px 4px 0; cursor: pointer;">Search</button>
			</div>
			<div id="searchResults"></div>
		</div>
		<div class="small-header">
			<%
			String email = session.getAttribute("email").toString();
			%>
			<li><a href="#"><i class="fas fa-user"></i>Welcome <span>
						<%
						out.println(email);
						%>
				</span></a></li>
		</div>
	</div>


	<div class="Productss"
		style="display: flex; flex-wrap: wrap; justify-content: center; margin: 20px;">
		<%
		Connection con = null;
		Statement stmt = null;
		ResultSet rs = null;

		try {
			con = ConnectionProvider.getCon();
			stmt = con.createStatement();
			rs = stmt.executeQuery("SELECT Id, pName, pPrice, pCategory, pActive FROM product");

			while (rs.next()) {
				int pid = rs.getInt("Id");
				String Pname = rs.getString("pName");
				String pPrice = rs.getString("pPrice");
				String category = rs.getString("pCategory");
				String pActive = rs.getString("pActive");
				String imagePath = "";

				switch (category) {
			case "Electronics" :
				imagePath = "images/electronics.jpg";
				break;
			case "clothing" :
				imagePath = "images/clothing.jpg";
				break;
			case "grocery" :
				imagePath = "images/grocery.jpg";
				break;
				}
		%>
		<div class="card"
			style="border: 1px solid #ddd; border-radius: 10px; padding: 15px; margin: 15px; width: 200px; display: inline-block; vertical-align: top; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); transition: transform 0.2s;">
			<img src="<%=imagePath%>" alt="<%=category%>"
				style="width: 100%; height: 150px; object-fit: cover; border-radius: 10px;">
			<div class="card-body" style="text-align: center;">
				<h3 style="margin: 10px 0; font-size: 1.2em;"><%=Pname%></h3>
				<p style="color: #555;">
					Price: Rs.<%=pPrice%></p>
				<%
				if ("yes".equalsIgnoreCase(pActive)) {
				%>
				<button class="add-to-cart"
					style="background-color: #28a745; color: white; padding: 10px 20px; border: none; border-radius: 5px; cursor: pointer;">
					<a href="addToCartAction.jsp?id=<%=pid%>"
						style="color: white; text-decoration: none; font-family: 'Poppins', sans-serif; font-weight: 500;">Add
						To Cart</a>
				</button>
				<%
				} else {
				%>
				<p style="color: red; font-weight: bold;">Out of Stock</p>
				<%
				}
				%>
				<%
				String msg = request.getParameter("msg");
				String addedProductId = request.getParameter("productId");
				if (addedProductId != null && pid == Integer.parseInt(addedProductId)) {
					if ("added".equals(msg)) {
				%>
				<p style="color: green;">Product Added Successfully</p>
				<%
				}
				}
				%>
				
				<% 
				if (addedProductId != null && pid == Integer.parseInt(addedProductId)) {
					if ("exist".equals(msg)) {
				%>
				<p style="color: blue;">Quantity Increased</p>
				<%
				}
				}
				%>
				
				<%
				if ("invalid".equals(msg)) {
				%>
				<p style="color: red;">Something Went Wrong Please Try Again</p>
				<%
				}
				%>
			</div>
		</div>
		<%
		}
		} catch (Exception e) {
		e.printStackTrace(); // Print stack trace for debugging
		} finally {
		// Close ResultSet, Statement, and Connection in the finally block
		if (rs != null) {
		try {
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		}
		if (stmt != null) {
		try {
			stmt.close();
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
	</div>
	<script>
    let lastScrollTop = 0;
    const navbar = document.querySelector('.navbar');

    window.addEventListener('scroll', () => {
        let scrollTop = window.pageYOffset || document.documentElement.scrollTop;

        if (scrollTop > window.innerHeight * 0.2) {
            if (scrollTop > lastScrollTop) {
                navbar.style.transform = 'translateY(-100%)';
            } else {
                navbar.style.transform = 'translateY(0)';
            }
        }

        lastScrollTop = scrollTop;
    });

    function searchProducts() {
        var searchQuery = document.getElementById("searchInput").value;
        var xhr = new XMLHttpRequest();
        xhr.open("GET", "search.jsp?query=" + searchQuery, true);
        xhr.onreadystatechange = function() {
            if (xhr.readyState == 4 && xhr.status == 200) {
                document.getElementById("searchResults").innerHTML = xhr.responseText;
            }
        };
        xhr.send();
    }

    function addToCart(productId) {
        alert("Product added to cart: " + productId);
    }
</script>
</body>
</html>