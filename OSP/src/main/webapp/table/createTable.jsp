<%@page import="project.ConnectionProvider" %>
<%@page import="java.sql.*" %>
<% 
	try{
		Connection con = ConnectionProvider.getCon();
		Statement st = con.createStatement();
		String q1 = "create table users(name varchar(100), Email varchar(100) primary key, MobileNumber bigint, SecurityQuestions varchar(200), Answer varchar(200), Password varchar(100), Address varchar(255), City varchar(100), State varchar(100), Country varchar(100))";
		String q2 = "create table product(Id int, pName varchar(100), pCategory varchar(100), pPrice int, pActive varchar(10))";
		String q3 = "create table cart(Email varchar(100), Product_Id int, Quantity int, Price int, Total int, Address varchar(400), City varchar(100), State varchar(100), Country varchar(100), Mobile_Number bigint, OrderDate varchar(100), DeliveryDate varchar(100), PaymentMethod varchar(100), TransactionId varchar(100), Status varchar(10))";
		System.out.println(q1);
		System.out.println(q2);
		System.out.println(q3);
		// st.execute(q1);
		// st.execute(q2);
		st.execute(q3);
		System.out.println("Table Created");
		con.close();
	}catch(Exception e){
		System.out.println(e);
	}
%>