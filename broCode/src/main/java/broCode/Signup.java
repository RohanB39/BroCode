package broCode;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/Signup")
public class Signup extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String fullNameParameter = "fname";
		String emailParameter = "email";
		String passwordParameter = "password";
		String fullName = request.getParameter(fullNameParameter);
		String email = request.getParameter(emailParameter);
		String password = request.getParameter(passwordParameter);

		String url = "jdbc:mysql://localhost:3306/brocode";
		String user = "root";
		String pass = "25082018@Rt";

		String query = "insert into usersbro(FullName, Email, Password) values (?,?,?)";
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection(url, user, pass);
			PreparedStatement ptmt = con.prepareStatement(query);
			ptmt.setString(1, fullName);
			ptmt.setString(2, email);
			ptmt.setString(3, password);
			int result = ptmt.executeUpdate();
			
			if (result > 0) {
				RequestDispatcher RD = request.getRequestDispatcher("login.html");
				RD.forward(request, response);
			} else {
				RequestDispatcher RD = request.getRequestDispatcher("signup.html");
				RD.include(request, response);
			}

			con.close();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
