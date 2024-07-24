<%@ page import="java.util.*, java.sql.*, java.text.SimpleDateFormat"%>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Payment</title>
<link rel="stylesheet" href="css/payment.css">
<link rel="stylesheet"
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
    <div class="payment-container">
        <%
        String email = request.getParameter("email");
        String orderDate = request.getParameter("order_date");
        String deliveryDate = request.getParameter("delivery_date");
        String paymentMethod = request.getParameter("payment_method");
        
        if (paymentMethod.equals("PhonePe")) {
        %>
        <form action="completePayment.jsp" method="POST" class="payment-form">
            <h2>PhonePe Payment</h2>
            <input type="hidden" name="email" value="<%=email%>">
            <input type="hidden" name="order_date" value="<%=orderDate%>">
            <input type="hidden" name="delivery_date" value="<%=deliveryDate%>">
            <input type="hidden" name="payment_method" value="<%=paymentMethod%>">
            <div class="form-group">
                <label for="account_number">Account Number:</label>
                <input type="text" name="account_number" required>
            </div>
            <div class="form-group">
                <label for="ifsc_code">IFSC Code:</label>
                <input type="text" name="ifsc_code" required>
            </div>
            <div class="form-group">
                <label for="cvv">CVV:</label>
                <input type="text" name="cvv" required>
            </div>
            <div class="form-group">
                <label for="amount">Amount:</label>
                <%
                int totalAmount = 0;
                // Add code to fetch total amount from the cart and calculate 18% GST
                // Assuming totalAmount is fetched and calculated
                totalAmount = 1000; // replace with actual fetched value
                double finalAmount = totalAmount * 1.18; // 18% GST
                %>
                <input type="text" name="amount" value="<%=finalAmount%>" readonly>
            </div>
            <button type="submit" class="payment-btn">Make Payment</button>
        </form>
        <%
        } else {
        // Handle other payment methods
        // For simplicity, we just redirect to a confirmation page
        %>
        <form action="completePayment.jsp" method="POST" class="payment-form">
            <h2>Payment Confirmation</h2>
            <input type="hidden" name="email" value="<%=email%>">
            <input type="hidden" name="order_date" value="<%=orderDate%>">
            <input type="hidden" name="delivery_date" value="<%=deliveryDate%>">
            <input type="hidden" name="payment_method" value="<%=paymentMethod%>">
            <p>Please click the button below to confirm your payment.</p>
            <button type="submit" class="payment-btn">Confirm Payment</button>
        </form>
        <%
        }
        %>
    </div>
</body>
</html>
