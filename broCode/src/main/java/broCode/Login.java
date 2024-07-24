package broCode;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/Login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String emailParameter = "email";
		String passwordParameter = "password";
		String email = request.getParameter(emailParameter);
		String password = request.getParameter(passwordParameter);
		
		String url = "jdbc:mysql://localhost:3306/brocode";
		String user = "root";
		String pass = "25082018@Rt";
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection(url, user, pass);
			Statement stmt = con.createStatement();
			ResultSet RS = stmt.executeQuery("select * from usersbro where Email= '" + email + "' and Password='" + password + "'");
			if (RS.next()) {
				RequestDispatcher RD = request.getRequestDispatcher("home.html");
				RD.forward(request, response);
			}else {
				PrintWriter out = response.getWriter();
				response.setContentType("text/html");
				request.setAttribute("error", "<h3 style='color:red'>Invalid Email Password</h3>");
				out.println(request.getAttribute("error"));
				RequestDispatcher RD = request.getRequestDispatcher("login.html");
				RD.include(request, response);
			}
			con.close();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
