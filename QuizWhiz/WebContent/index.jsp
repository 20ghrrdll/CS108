<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*, quizzes.*, users.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%
User user = (User) session.getAttribute("currentUser");

%>
</head>
<body>
<% if(user != null) { %>
	<div>
		<strong>Hello <% out.print(user.getUsername()); %>!</strong>
	</div>
	<% } else {
		response.sendRedirect("login-page.jsp?");
	}%>
	
	<h3>Welcome to our quiz website woohoo!</h3>

</body>
</html>