<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Create User</title>
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/style/login.css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js"></script>
<link
	href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css"
	rel="stylesheet" type="text/css" />
</head>
<body>
<nav class="navbar navbar-default">
  <div class="container-fluid">
    <!-- Brand and toggle get grouped for better mobile display -->
    <div class="navbar-header">
      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <a class="navbar-brand" href="index.jsp?">Quiz Whiz</a>
    </div>
  </div><!-- /.container-fluid -->
</nav>
<div class="panel panel-default centerDiv">
  <div class="panel-heading">Create an Account</div>
  <div class="panel-body">
    <form action="UserCreationServlet" method="post">
    <% if("empty".equals(request.getParameter("invalid"))) { %>
	<div class="warning">
		<strong>Empty Field </strong> Please enter a username and password.
	</div>
	<% } else if("exists".equals(request.getParameter("invalid"))) { %>
	<div class="warning">
		<strong>Exists!</strong> Sorry, a user with that name already exists.
	</div>
	<% } else if(request.getParameter("error") != null) {
	%>
		<div class="alert alert-danger">
  		<strong>Error:</strong> <% out.println(request.getParameter("error")); %>
		</div>
	<% } %>
		<div class="form-group">
			<label>Username</label> <input
				type="test" class="form-control" name="username"
				placeholder="Username" >
		</div>
		<div class="form-group">
			<label for="exampleInputEmail1">Password</label> <input
				type="password" class="form-control" name="password"
				placeholder="Subject">
		</div>
		<button type="submit" class="btn btn-default">Sign Up</button>
<div class="createAccount">
Already signed up? <br>
<a href="login-page.jsp">Login Here!</a>
</div>
	</form>
  </div>
</div>




</body>
</html>

