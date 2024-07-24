<%@page import="project.ConnectionProvider"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<title>E-Cart! Admin Dashboard</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<link rel="stylesheet" href="adminHome.css">
</head>
<body>
	<div class="dashboard-container">
		<div class="sidebar" id="sidebar">
			<div class="sidebar-header">
				<h2>
					E-Cart<i>!</i>
				</h2>
				<button class="sidebar-toggle" id="sidebar-toggle"
					onclick="toggleSidebar()">
					<i class="fa fa-arrow-left" id="toggle-icon"></i>
				</button>
			</div>
			<a href="#">Dashboard</a> <a href="addNewProduct.jsp">Add New
				Product</a> <a href="allEditProduct.jsp">All Products & Edit
				Products</a> <a href="#">Messages Received</a> <a href="#">Orders
				Received</a> <a href="#">Cancel Orders</a> <a href="#">Delivered
				Orders</a> <a href="usersTotal.jsp">User Information</a> <a
				href="../logOut.jsp">Logout</a>
		</div>
		<div class="content" id="content">
			<div class="owner">
				<p>
					Hello <span> <%
 out.println(session.getAttribute("email"));
 %>
					</span>
				</p>
				<i class="fa-regular fa-bell"></i> <i class="fa-solid fa-user"></i>
			</div>
			<div class="cards">
				<div class="reservations card">
					<h3>Electronics</h3>
					<%
					try {
						Connection con = ConnectionProvider.getCon();
						PreparedStatement ps = con.prepareStatement(
						"SELECT COUNT(*) AS total_products, SUM(CASE WHEN pActive = 'yes' THEN 1 ELSE 0 END) AS active_products FROM product WHERE pCategory = 'electronics'");
						ResultSet rs = ps.executeQuery();
						int totalProducts = 0;
						int activeProducts = 0;
						if (rs.next()) {
							totalProducts = rs.getInt("total_products");
							activeProducts = rs.getInt("active_products");
						}
					%>
					<p>
						Total Electronics Products: <b> <%=totalProducts%></b>
					</p>
					<p>
						Total Avialable Products: <b> <%=activeProducts%></b>
					</p>
					<p style="color: red;">
						Out Of Stock Products: <b> <%=totalProducts - activeProducts%></b>
					</p>
					<%
					rs.close();
					ps.close();
					con.close();
					} catch (Exception e) {
					e.printStackTrace();
					}
					%>
				</div>
				<div class="guests card">
					<h3>Clothing</h3>
					<%
					try {
						Connection con = ConnectionProvider.getCon();
						PreparedStatement ps = con.prepareStatement(
						"SELECT COUNT(*) AS total_products, SUM(CASE WHEN pActive = 'yes' THEN 1 ELSE 0 END) AS active_products FROM product WHERE pCategory = 'clothing'");
						ResultSet rs = ps.executeQuery();
						int totalProducts = 0;
						int activeProducts = 0;
						if (rs.next()) {
							totalProducts = rs.getInt("total_products");
							activeProducts = rs.getInt("active_products");
						}
					%>
					<p>
						Total Clothing Products: <b> <%=totalProducts%></b>
					</p>
					<p>
						Total Avialable Products: <b> <%=activeProducts%></b>
					</p>
					<p style="color: red;">
						Out Of Stock Products: <b> <%=totalProducts - activeProducts%></b>
					</p>
					<%
					rs.close();
					ps.close();
					con.close();
					} catch (Exception e) {
					e.printStackTrace();
					}
					%>
				</div>
				<div class="next-seven-days card">
					<h3>Grocery Products</h3>
					<%
					try {
						Connection con = ConnectionProvider.getCon();
						PreparedStatement ps = con.prepareStatement(
						"SELECT COUNT(*) AS total_products, SUM(CASE WHEN pActive = 'yes' THEN 1 ELSE 0 END) AS active_products FROM product WHERE pCategory = 'grocery'");
						ResultSet rs = ps.executeQuery();
						int totalProducts = 0;
						int activeProducts = 0;
						if (rs.next()) {
							totalProducts = rs.getInt("total_products");
							activeProducts = rs.getInt("active_products");
						}
					%>
					<p>
						Total Grocery Products: <b> <%=totalProducts%></b>
					</p>
					<p>
						Total Avialable Products: <b> <%=activeProducts%></b>
					</p>
					<p style="color: red;">
						Out Of Stock Products: <b> <%=totalProducts - activeProducts%></b>
					</p>
					<%
					rs.close();
					ps.close();
					con.close();
					} catch (Exception e) {
					e.printStackTrace();
					}
					%>
				</div>
			</div>
			<div class="analytics">
				<div class="chart card">
					<h3>Overall Sales</h3>
					<canvas id="salesChart"></canvas>
				</div>
				<div class="quick-details card">
					<h3>Quick Details</h3>
					<%
					try {
						Connection con = ConnectionProvider.getCon();
						PreparedStatement ps = con.prepareStatement(
						"SELECT COUNT(*) AS total_products, SUM(CASE WHEN pActive = 'yes' THEN 1 ELSE 0 END) AS active_products, COUNT(CASE WHEN Id >= (SELECT MAX(Id) FROM product WHERE pActive = 'yes' AND Id >= (SELECT MAX(Id) FROM product WHERE Id >= (SELECT MAX(Id) FROM product) - 24)) THEN 2 END) AS new_products FROM product;");
						ResultSet rs = ps.executeQuery();
						int totalProducts = 0;
						int activeProducts = 0;
						int newProducts = 0;
						if (rs.next()) {
							totalProducts = rs.getInt("total_products");
							activeProducts = rs.getInt("active_products");
							newProducts = rs.getInt("new_products");
						}
						int inActiveProducts = totalProducts - activeProducts;
						PreparedStatement psCount = con.prepareStatement("SELECT COUNT(*) AS total_users FROM users");
						ResultSet rsCount = psCount.executeQuery();
						int totalUsers = 0;
						if (rsCount.next()) {
							totalUsers = rsCount.getInt("total_users");
						}
					%>
					<p>
						<b><%=totalUsers%></b> Total Customers
					</p>
					<p style="color: green;">
						<b><%=newProducts%></b> New Products (Last 24 Hours)
					</p>
					<p style="color: green;">
						<b><%=totalProducts%></b> Total Products
					</p>
					<p>400 Orders (Awaiting Process)</p>
					<p>120 Orders (On Hold)</p>
					<p>480 Orders (Low in Stock)</p>
					<p style="color: red;"><%=inActiveProducts%>
						Items (Out of Stock)
					</p>
					<%
					rs.close();
					ps.close();
					con.close();
					} catch (Exception e) {
					e.printStackTrace();
					}
					%>
				</div>
			</div>

			<div class="analytics">
				<div class="quick-details card">
					<h3>Total Expences</h3>
					<%
					try {
						Connection con = ConnectionProvider.getCon();
						PreparedStatement ps = con.prepareStatement(
						"SELECT " + "    SUM(CASE WHEN pCategory = 'electronics' THEN pPrice ELSE 0 END) AS electronics_price, "
								+ "    SUM(CASE WHEN pCategory = 'clothing' THEN pPrice ELSE 0 END) AS clothing_price, "
								+ "    SUM(CASE WHEN pCategory = 'grocery' THEN pPrice ELSE 0 END) AS grocery_price, "
								+ "    SUM(pPrice) AS total_price " + "FROM " + "    product " + "WHERE " + "    pActive = 'yes'");
						ResultSet rs = ps.executeQuery();

						int sumOfElectronics = 0;
						int sumOfClothing = 0;
						int sumOfGrocery = 0;
						int sumOfTotal = 0;
						if (rs.next()) {
							sumOfElectronics = rs.getInt("electronics_price");
							sumOfClothing = rs.getInt("clothing_price");
							sumOfGrocery = rs.getInt("grocery_price");
							sumOfTotal = rs.getInt("total_price");
						}
					%>
					<p style="color: red;">
						<b><%=sumOfTotal%></b> &#x20B9; Cost Of Total Products
					</p>
					<p>
						<b><%=sumOfElectronics%></b> &#x20B9; Cost Of Electronics Product
					</p>
					<p>
						<b><%=sumOfClothing%></b> &#x20B9; Cost Of Clothing Product
					</p>
					<p>
						<b><%=sumOfGrocery%></b> &#x20B9; Cost Of Grocary Product
					</p>
					<%
					rs.close();
					ps.close();
					con.close();
					} catch (Exception e) {
					e.printStackTrace();
					}
					%>
				</div>
			</div>



		</div>
	</div>

	<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
	<script>
	 var ctx = document.getElementById('salesChart').getContext('2d');
     var salesChart = new Chart(ctx, {
         type: 'bar',
         data: {
             labels: [],
             datasets: [{
                 label: 'Pune',
                 data: [],
                 backgroundColor: 'rgba(54, 162, 235, 0.2)',
                 borderColor: 'rgba(54, 162, 235, 1)',
                 borderWidth: 1
             }, {
                 label: 'Mumbai',
                 data: [],
                 backgroundColor: 'rgba(255, 206, 86, 0.2)',
                 borderColor: 'rgba(255, 206, 86, 1)',
                 borderWidth: 1
             }, {
                 label: 'Banglore',
                 data: [],
                 backgroundColor: 'rgba(75, 192, 192, 0.2)',
                 borderColor: 'rgba(75, 192, 192, 1)',
                 borderWidth: 1
             }]
         },
         options: {
             scales: {
                 y: {
                     beginAtZero: true
                 }
             }
         }
     });

     function getCurrentDateTime() {
         var now = new Date();
         return now.toLocaleString();
     }

     function getRandomSales() {
         return Math.floor(Math.random() * 20000);
     }

     setInterval(() => {
         var currentDateTime = getCurrentDateTime();
         salesChart.data.labels.push(currentDateTime); 
         
         if (salesChart.data.labels.length > 3) {  
             salesChart.data.labels.shift();
             salesChart.data.datasets.forEach(dataset => dataset.data.shift());
         }
         
         salesChart.data.datasets.forEach(dataset => {
             dataset.data.push(getRandomSales());
         });
         salesChart.update();
     }, 5000);

		function toggleSidebar() {
			var sidebar = document.getElementById('sidebar');
			var content = document.getElementById('content');
			var toggleIcon = document.getElementById('toggle-icon');

			sidebar.classList.toggle('collapsed');
			content.classList.toggle('expanded');

			if (sidebar.classList.contains('collapsed')) {
				toggleIcon.classList.remove('fa-arrow-left');
				toggleIcon.classList.add('fa-arrow-right');
			} else {
				toggleIcon.classList.remove('fa-arrow-right');
				toggleIcon.classList.add('fa-arrow-left');
			}
		}
	</script>
</body>
</html>
