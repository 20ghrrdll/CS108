<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*, quizzes.*, users.*, main.*, messages.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<%@include file="navigation-bar.jsp"%>

<title>Results</title>
</head>
<body>
	<% System.out.println(session.getAttribute("currQuizId"));
		int id = (Integer)session.getAttribute("currQuizId"); %>

	<h1 class="text-center">Results</h1>
	<h4 class="text-center">
		<% out.print(user.getUsername()); %>, you scored
		<% out.print(session.getAttribute("score")); %>/<% out.print(session.getAttribute("maxScore")); %>
		 points.
		 
		 <% if (session.getAttribute("score").equals(session.getAttribute("maxScore"))) {
			 if (!userManager.getAchievements(user.getUsername()).contains(FinalConstants.PERFECT_SCORE)) {
			 	userManager.addAchievement(user.getUsername(), FinalConstants.PERFECT_SCORE);
			 }
		 }%>
	</h4>
	
	<br>
	<center><a href="quiz-summary-page.jsp?id=<%=id%>">
		<button type="button" class="btn btn-default">Return to Quiz Summary</button>
	</a></center>
	
	<br><br>
	<div class="container-fluid">
	
	<div class="col-md-6"><div class="panel panel-default">
	<div class="panel-heading"><h1 class="panel-title">header</h1></div>
	<div class="panel-body">
		test
	</div></div></div>
	
	</div>

</body>
</html>