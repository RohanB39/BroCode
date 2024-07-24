<%@page import="project.ConnectionProvider"%>
<%@page import="java.sql.*"%>
<% 
String id = request.getParameter("id");
String name = request.getParameter("name");
String category = request.getParameter("category");
String price = request.getParameter("price");
String active = request.getParameter("active");

try{
	Connection con = ConnectionProvider.getCon();
	Statement st = con.createStatement();
	st.executeUpdate("update product set pName='"+name+"', pCategory='"+category+"', pPrice='"+price+"', pActive='"+active+"' where Id='"+id+"'");
	if(active.equalsIgnoreCase("no")){
		st.executeUpdate("delete from cart where Product_Id='"+id+"' and Address is NULL");
	}
	response.sendRedirect("allEditProduct.jsp?msg=done");
}catch(Exception e){
	e.printStackTrace();
	response.sendRedirect("allEditProduct.jsp?msg=invalid");
}
%>