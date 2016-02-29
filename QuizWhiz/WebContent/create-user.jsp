<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Create User</title>
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/style/login.css" />
</head>
<body>
<div class="centerDiv loginView">
<div class="centerDiv inputView">
<% if("empty".equals(request.getParameter("invalid"))) { %>
	<div class="warning">
		<strong>Empty Field </strong> Please enter a username and password.
	</div>
	<% } else if("exists".equals(request.getParameter("invalid"))) { %>
	<div class="warning">
		<strong>Exists!</strong> Sorry, a user with that name already exists.
	</div>
	<% } %>
<form action="UserCreationServlet" method="post">
<div class="inputDesc">User Name:</div><input type="text" name="username" /><br>
<div class="inputDesc">Password:</div><input type="password" name="password" />
<input type="submit" /></form>
Already signed up? <a href="login-page.jsp">Login Here!</a>
</div>
</div>
</body>
</html>

