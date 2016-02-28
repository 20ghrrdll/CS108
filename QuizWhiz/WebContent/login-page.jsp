<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/style/login.css" />
<title>Login</title>
</head>
<body>
<div class="centerDiv loginView">
<div class="centerDiv inputView">
<% if("empty".equals(request.getParameter("invalid"))) { %>
	<div class="warning">
		<strong>Empty Field </strong> Please enter a username and password.
	</div>
	<% } else if("fail".equals(request.getParameter("invalid"))) { %>
	<div class="warning">
		<strong>Not found</strong> That username password combination was not found.
	</div>
	<% } %>
<form action="LoginServlet" method="post">
<div class="inputDesc">User Name:</div> <input type="text" name="username" /><br>
<div class="inputDesc">Password:</div> <input type="password" name="password" />
<input type="submit" /></form>
<a href="create-user.jsp">Create New Account</a>
</div>
</div>
</body>
</html>

