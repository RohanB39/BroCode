<%@page import="project.ConnectionProvider" %>
<%@page import="java.sql.*" %>
<%
String email = session.getAttribute("email").toString();
String product_id = request.getParameter("productId");
String action = request.getParameter("action");

Connection con = null;
PreparedStatement pstmt = null;

try {
    con = ConnectionProvider.getCon();

    if ("remove".equals(action)) {
        // Remove the selected product from the cart
        pstmt = con.prepareStatement("DELETE FROM cart WHERE Email = ? AND Product_Id = ?");
        pstmt.setString(1, email);
        pstmt.setString(2, product_id);
        pstmt.executeUpdate();
        
        // Check if the cart is empty after removing the item
        ResultSet rs = con.createStatement().executeQuery("SELECT COUNT(*) AS total FROM cart WHERE Email = '" + email + "'");
        rs.next();
        int totalItems = rs.getInt("total");
        
        if(totalItems == 0) {
            // If the cart is empty, do not delete the address
            response.sendRedirect("myCart.jsp?msg=removed");
        } else {
            // If there are still items in the cart, redirect to myCart.jsp
            response.sendRedirect("myCart.jsp?msg=removed&address=true");
        }
    } else if ("checkout".equals(action)) {
        // Perform the checkout action
        response.sendRedirect("checkout.jsp?msg=checkout");
    }
} catch (Exception e) {
    e.printStackTrace();
    response.sendRedirect("myCart.jsp?msg=error");
} finally {
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
