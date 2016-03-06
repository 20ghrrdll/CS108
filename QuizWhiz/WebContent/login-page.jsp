<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/style/login.css" />
<link rel="stylesheet" href="http://www.w3schools.com/lib/w3.css">
<link rel="stylesheet"
	href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.4.0/css/font-awesome.min.css">
<link rel="stylesheet"
	href="http://www.w3schools.com/lib/w3-theme-indigo.css">
<title>Login</title>
</head>
<body>
<header class="w3-container w3-theme">
  <h1>Quiz Whiz</h1>
</header>

<div class="w3-card-4 centerDiv">

<div class="w3-container w3-green">
  <h2>Login</h2>
</div>

<form class="w3-container" action="LoginServlet" method="post">
<% if("empty".equals(request.getParameter("invalid"))) { %>
	<div class="warning">
		<strong>Empty Field </strong> Please enter a username and password.
	</div>
	<% } else if("fail".equals(request.getParameter("invalid"))) { %>
	<div class="warning">
		<strong>Not found</strong> That username password combination was not found.
	</div>
	<% } %>

<label class="w3-label">Username</label>
<input class="w3-input w3-round" type="text" name="username">

<label class="w3-label">Password</label>
<input class="w3-input w3-round" type="password" name="password" >
<button class="w3-btn w3-white w3-border w3-round" type="submit">Login</button>

<div class="createAccount">
Don't have an account? <br>
<a href="create-user.jsp">Create New Account</a>
</div>
</form>
</div>

</body>
</html>

