<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Create User</title>
</head>
<body>
<% if("empty".equals(request.getParameter("invalid"))) { %>
	<div>
		<strong>Empty Field </strong> Please enter fill in both a username and password.
	</div>
	<% } else if("exists".equals(request.getParameter("invalid"))) { %>
	<div>
		<strong>Exists!</strong> Sorry, a user with that name already exists.
	</div>
	<% } %>
<form action="UserCreationServlet" method="post">
User Name: <input type="text" name="username" /><br>
Password: <input type="text" name="password" />
<input type="submit" /></form>
</body>
</html>

