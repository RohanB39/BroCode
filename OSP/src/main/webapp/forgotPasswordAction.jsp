<%@page import="project.ConnectionProvider" %>
<%@page import="java.sql.*" %>
<% 
String email = request.getParameter("email");
String mobile = request.getParameter("mobileNumber");
String securityQuestion = request.getParameter("securityQuestion");
String answer = request.getParameter("answer");
String newPassword = request.getParameter("password");

int check = 0;
try {
	Connection con = ConnectionProvider.getCon();
	Statement st = con.createStatement();
	ResultSet rs = st.executeQuery("select * from users where Email='"+email+"' and MobileNumber='"+mobile+"' and SecurityQuestions='"+securityQuestion+"' and Answer='"+answer+"'");
	while(rs.next()){
		check = 1;
		st.executeUpdate("update users set Password='"+newPassword+"' where Email='"+email+"'");
		response.sendRedirect("forgotPassword.jsp?msg=done");
	}
	if(check == 0){
		response.sendRedirect("forgotPassword.jsp?msg=done");
	}
}catch(Exception e){
	System.out.println(e);
}
%>