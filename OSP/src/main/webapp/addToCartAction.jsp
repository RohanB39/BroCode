<%@page import="project.ConnectionProvider" %>
<%@page import="java.sql.*" %>
<%
String email = session.getAttribute("email").toString();
String product_id = request.getParameter("id");
int qty = 1;
int product_price = 0;
int product_total = 0;
int cart_total = 0;
int z = 0;
Connection con = null;
Statement st = null;
ResultSet rs = null;
ResultSet rs1 = null;

try {
    con = ConnectionProvider.getCon();
    st = con.createStatement();
    rs = st.executeQuery("SELECT * FROM product WHERE Id='" + product_id + "'");
    
    while (rs.next()) {
        product_price = rs.getInt(4);
        product_total = product_price;
    }
    
    rs1 = st.executeQuery("SELECT * FROM cart WHERE Product_Id='" + product_id + "' AND Email='" + email + "' AND Address IS NULL");
    
    while (rs1.next()) {
        cart_total = rs1.getInt(5);
        cart_total = cart_total + product_total;
        qty = rs1.getInt(3);
        qty = qty + 1;
        z = 1;
    }
    
    if (z == 1) {
        st.executeUpdate("UPDATE cart SET Total='" + cart_total + "', Quantity='" + qty + "' WHERE Product_Id='" + product_id + "' AND Email='" + email + "' AND Address IS NULL");
        response.sendRedirect("home.jsp?msg=exist&productId=" + product_id);
    } else {
        PreparedStatement pt = con.prepareStatement("INSERT INTO cart (Email, Product_Id, Quantity, Price, Total) VALUES (?,?,?,?,?)");
        pt.setString(1, email);
        pt.setString(2, product_id);
        pt.setInt(3, qty);
        pt.setInt(4, product_price);
        pt.setInt(5, product_total);
        pt.executeUpdate();
        response.sendRedirect("home.jsp?msg=added&productId=" + product_id);
    }
} catch (Exception e) {
    e.printStackTrace();
    response.sendRedirect("home.jsp?msg=invalid");
} finally {
    if (rs != null) {
        try {
            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    if (rs1 != null) {
        try {
            rs1.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    if (st != null) {
        try {
            st.close();
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
