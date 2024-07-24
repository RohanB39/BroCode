<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="css/signup.css">
<title>E-Cart! Login</title>
</head>
<body>
	<div class="nav">
		<div class="left">
			<h1>
				E-Cart<i>!</i>
			</h1>
		</div>
		<div class="right">
			<a herf="#">Help</a> <a herf="#">Terms</a> <a herf="#">Privacy</a>
		</div>
	</div>
	<div class="container">
		<div class="form-container">
			<div class="header">
				<h2>
					Login E-Cart<i>!</i> account
				</h2>
			</div>
			<form action="loginAction.jsp" method="post">
				<div class="form-group">
					<label for="first-name">E-Cart<i>!</i> Email<span>*</span>
					</label> <input type="text" id="first-name" name="email" required>
				</div>
				<div class="form-group">
					<label for="email">E-Cart<i>!</i> Password<span>*</span>
					</label> <input type="password" id="email" name="password" required>
				</div>
				<button type="submit">Continue</button>
				
				<%
				String msg = request.getParameter("msg");
				if ("notexist".equals(msg)) {
				%>
				<div class="error-message">
					Incorrect Email or Password..
				</div>
				<%
				}
				%>
				<%
				if ("invalid".equals(msg)) {
				%>
				<div class="error-message">Something went wrong! Try again!</div>
				<%
				}
				%>
				
			</form>
			<div class="buttons">
				<a href="signup.jsp">Create an account?</a>
				<a href="forgotPassword.jsp">Forgot password?</a>
			</div>
		</div>
		<p>The Online Shopping System is the application that allows the
			users to shop online without going to the shops to buy them.</p>
	</div>
</body>
</html>