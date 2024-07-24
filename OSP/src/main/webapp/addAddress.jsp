<%@page import="project.ConnectionProvider" %>
<%@page import="java.sql.*" %>
<%@page import="javax.servlet.http.*,javax.servlet.*" %>
<%@page errorPage="error.jsp" %>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Add Address</title>
<link rel="stylesheet" href="css/userHome.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<style>
    body {
        font-family: 'Poppins', sans-serif;
    }
    .content {
        margin-top: 60px;
        padding: 20px;
    }
    .form-container {
        max-width: 600px;
        margin: 0 auto;
        padding: 20px;
        border: 1px solid #ddd;
        border-radius: 10px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        background-color: #fff;
    }
    .form-container h2 {
        text-align: center;
        margin-bottom: 20px;
    }
    .form-container label {
        display: block;
        margin-bottom: 5px;
        font-weight: bold;
    }
    .form-container input {
        width: 100%;
        padding: 10px;
        margin-bottom: 15px;
        border: 1px solid #ddd;
        border-radius: 5px;
        box-sizing: border-box;
    }
    .form-container button {
        width: 100%;
        padding: 10px;
        background-color: #28a745;
        color: white;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        font-weight: 500;
    }
    .form-container button:hover {
        background-color: #218838;
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
                    <li><a href="#">About</a></li>
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
        <div class="form-container">
            <h2>Add Address</h2>
            <form action="addAddressAction.jsp" method="post">
                <label for="address">Address:</label>
                <input type="text" id="address" name="address" required>

                <label for="city">City:</label>
                <input type="text" id="city" name="city" required>

                <label for="state">State:</label>
                <input type="text" id="state" name="state" required>

                <label for="country">Country:</label>
                <input type="text" id="country" name="country" required>

                <label for="mobile">Mobile Number:</label>
                <input type="text" id="mobile" name="mobile" required>

                <button type="submit">Submit</button>
            </form>
        </div>
    </div>
</body>
</html>
