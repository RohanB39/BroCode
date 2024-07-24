<%@page import="project.ConnectionProvider" %>
<%@page import="java.sql.*" %>
<%
String email = request.getParameter("email");
String pass = request.getParameter("password");
if("rohan@gmail.com".equals(email) && "rohanb".equals(pass)){
	session.setAttribute("email", email);
	response.sendRedirect("admin/adminHome.jsp");
}else {
	int count = 0;
	try {
		Connection con = ConnectionProvider.getCon();
		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery("select * from users where Email='"+email+"' and Password='"+pass+"'");
		while(rs.next()){
			count = 1;
			session.setAttribute("email", email);
			response.sendRedirect("home.jsp");
		}
		if(count == 0) {
			response.sendRedirect("login.jsp?msg=notexist");
		}
	}catch(Exception e){
		System.out.println(e);
		response.sendRedirect("login.jsp?msg=invalid");
	}
}
%>