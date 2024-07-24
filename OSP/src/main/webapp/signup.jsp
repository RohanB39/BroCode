<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="css/signup.css">
<title>E-Cart! Sign up</title>
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
					Create a E-Cart<i>!</i> account
				</h2>
				<p>
					Access all that E-Cart<i>!</i> has to offer with a single account.
					All fields are required.
				</p>
			</div>
			<form action="signupAction.jsp" method="post">
				<div class="form-group">
					<label for="first-name">Full name<span>*</span></label> <input
						type="text" id="first-name" name="name" required>
				</div>
				<div class="form-group">
					<label for="email">New E-cart email address<span>*</span></label> <input
						type="email" id="email" name="email" required>
				</div>
				<div class="form-group">
					<label for="number">Mobile Number<span>*</span></label> <input
						type="number" id="number" name="mobileNumber" required>
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
					<label for="password">Password<span>*</span></label> <input
						type="password" name="password" required>
					<div class="pbar">
					<small>Must contain at least eight characters.</small> 
					<progress value="4" max="8" class="pro"></progress>
					</div>
					
				</div>
				<button type="submit">Continue</button>
				<p>
					By clicking Continue, you agree to the <a href="#">Terms</a> and
					acknowledge the <a href="#">Privacy Policy</a>.
				</p>
				<%
				String msg = request.getParameter("msg");
				if ("valid".equals(msg)) {
				%>
				<div class="success-message">
					Registered Successfully..! <br>Click on login button
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

			<p>
				<a href="login.jsp" class="btn">Login</a>
			</p>

		</div>
	</div>
</body>
</html>
