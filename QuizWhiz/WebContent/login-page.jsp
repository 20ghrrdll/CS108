<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Login</title>
</head>
<body>
<% 
if (request.getParameter("attempt") != null && request.getParameter("attempt").equals("invalid")) {
	out.println("Invalid username or password. Please try again.<br><br>");
} else {
	out.println("Please log in.<br><br>");
} 
%>
<form action="LoginServlet" method="post">
User Name: <input type="text" name="username" /><br>
Password: <input type="text" name="password" />
<input type="submit" /></form>
</body>
</html>

