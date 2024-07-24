<%@page import="java.sql.*"%>
<%@page import="project.ConnectionProvider"%>
<%
    String searchQuery = request.getParameter("query");
    if (searchQuery != null && !searchQuery.isEmpty()) {
        Connection con = ConnectionProvider.getCon();
        PreparedStatement pstmt = con.prepareStatement("SELECT Id, Pname, pPrice, pCategory FROM product WHERE Pname LIKE ? OR pCategory LIKE ?");
        pstmt.setString(1, "%" + searchQuery + "%");
        pstmt.setString(2, "%" + searchQuery + "%");
        ResultSet rs = pstmt.executeQuery();
%>
    <h2>Search Results:</h2>
    <ul>
        <% while (rs.next()) { %>
            <li class="search-result">
                <strong><%= rs.getString("Pname") %></strong> - <%= rs.getString("pCategory") %> - <%= rs.getString("pPrice") %>
                <button onclick="addToCart('<%= rs.getString("Id") %>')">Add to Cart</button>
            </li>
        <% } %>
    </ul>
<%
    rs.close();
    pstmt.close();
    con.close();
} else {
%>
    <p>No search query provided.</p>
<%
}
%>
