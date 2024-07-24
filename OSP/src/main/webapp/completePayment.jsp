<%@page import="project.ConnectionProvider"%>
<%@ page import="java.sql.*, java.util.*, java.util.UUID"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Payment Completed</title>
<link rel="stylesheet" href="css/payment-completed.css">
<link rel="stylesheet"
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
    <div class="payment-completed-container">
        <%
        Connection con = null;
        Statement stmt = null;

        String email = request.getParameter("email");
        String orderDate = request.getParameter("order_date");
        String deliveryDate = request.getParameter("delivery_date");
        String paymentMethod = request.getParameter("payment_method");

        String transactionId = UUID.randomUUID().toString();
        String status = "Completed";

        try {
            con = ConnectionProvider.getCon();
            stmt = con.createStatement();
            String updateQuery = "UPDATE cart SET OrderDate='" + orderDate + "', DeliveryDate='" + deliveryDate + "', PaymentMethod='" + paymentMethod + "', TransactionId='" + transactionId + "', Status='" + status + "' WHERE Email='" + email + "'";
            int rowsUpdated = stmt.executeUpdate(updateQuery);

            if (rowsUpdated > 0) {
        %>
        <div class="success-message">
            <i class="fas fa-check-circle"></i>
            <h2>Payment completed successfully!</h2>
            <p>Transaction ID: <%= transactionId %></p>
        </div>
        <%
            } else {
        %>
        <div class="error-message">
            <i class="fas fa-exclamation-circle"></i>
            <h2>Failed to complete payment.</h2>
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
        <a href="checkout.jsp?email=<%= email %>" class="back-btn">Back to Checkout</a>
    </div>
</body>
</html>
