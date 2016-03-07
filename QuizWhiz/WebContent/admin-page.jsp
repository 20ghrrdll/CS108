<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*, quizzes.*, users.*, main.*, messages.*, administration.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
<script type="${pageContext.request.contextPath}/text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Admin Portal</title>
</head>
<body>

<% 
String username = request.getParameter("username");
AdminManager adminManager = (AdminManager) request.getServletContext().getAttribute("adminManager");
 %>

<div class="container">
	<h1>Site Statistics</h1>
	<div class="row">
		<div class="col-md-4" style="text-align: center">
		<h3><% out.println(adminManager.getNumUsers()); %><br>
		Users</h3></div>
		</div>
		<div class="col-md-4" style="text-align: center">
		<h3><% out.println(adminManager.getNumQuizzesCreated()); %><br>
		Quizzes Created</h3></div>
		</div>
		<div class="col-md-4" style="text-align: center">
		<h3><% out.println(adminManager.getNumQuizzesTaken()); %><br>
		Quizzes Taken</h3></div>
	</div>
</div>

</body>
</html>