<%@page isErrorPage="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>E-Cart! Error</title>
    <style>
        body {
            color: red;
            font-family: Arial, sans-serif;
            text-align: center;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            justify-content: center;
            height: 100vh;
        }
        h1 {
            font-size: 2em;
            margin-bottom: 0.5em;
        }
        p {
            font-size: 1.2em;
            margin: 0.5em 0;
        }
        a {
            color: white;
            text-decoration: none;
            background-color: #0056b3;
            padding: 10px 20px;
            border-radius: 5px;
            display: inline-block;
            margin-top: 1em;
        }
        a:hover {
            background-color: #003f7f;
        }
    </style>
</head>
<body>
    <div>
        <h1>Something went wrong!</h1>
        <p>We're sorry for the inconvenience.</p>
        <p>Please try to log in again.</p>
        <a href="login.jsp">Login</a>
    </div>
</body>
</html>
