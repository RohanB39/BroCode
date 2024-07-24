<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="css/signup.css">
<title>E-Cart! Forgot</title>
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
					Forgot E-Cart<i>!</i> credentials
				</h2>
			</div>
			<form action="forgotPasswordAction.jsp" method="post">
				<div class="form-group">
					<label for="first-name">E-Cart<i>!</i> Email<span>*</span>
					</label> <input type="text" id="first-name" name="email" required>
				</div>
				<div class="form-group">
					<label for="num">Mobile Number<span>*</span>
					</label> <input type="number" id="num" name="mobileNumber" required>
				</div>
				<div class="form-group">
					<select name="securityQuestion" required>
						<option value="What is your first car?">What is your
							first car?</option>
						<option value="What is the name of your pet?">What is the
							name of your pet?</option>
						<option value="What elementry school you attend?">What
							elementry school you attend?</option>
						<option value="What is the name of town where you born">What
							is the name of town where you born</option>
					</select> <input type="text" name="answer" placeholder="Enter Your Answer*"
						required>
				</div>
				<div class="form-group">
					<label for="password">Set New Password<span>*</span></label> 
					<input type="password" name="password" required>
					<small>Must contain at least eight characters.</small> 
				</div>
				<button type="submit">Continue</button>
				
				<%
				String msg = request.getParameter("msg");
				if ("done".equals(msg)) {
				%>
				<div class="success-message">
					Password Changed Successfully <br> Click On Login Button.
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
				<a href="login.jsp">Login Existing User?</a>
			</div>
		</div>
		<p>The Online Shopping System is the application that allows the
			users to shop online without going to the shops to buy them.</p>
	</div>
</body>
</html>