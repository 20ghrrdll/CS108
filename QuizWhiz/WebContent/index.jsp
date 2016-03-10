<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="java.util.*, quizzes.*, users.*, main.*, messages.*, administration.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Homepage</title>

<%@include file="navigation-bar.jsp" %>

</head>
<body class="standards">

<% if(request.getParameter("error") != null) { %>
	<div class="alert alert-danger">
  		<strong>Error:</strong> <% out.print(FinalConstants.ERROR_MSG); %>
	</div>
<% } %>

	<div class="container-fluid">
		<div class="row">
			<div class="col-md-4">
				<div class="panel panel-default">
					<div class="panel-heading">
						<% if (user != null) { %>
							<h3 class="panel-title"><%=user.getUsername()%></h3>
						<% } %>
					</div>
					<div class="panel-body">
						<ul>
							<li>Date joined: <%=user.getJoinDate()%></li>
							<li>Number of quizzes made: <%=myQuizzes.size()%></li>
						</ul>
						<a class="btn btn-primary" href="make-quiz.jsp" role="button">Make Quiz</a>
					</div>
				</div>
				
			</div>
			<div class="col-md-8">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h3 class="panel-title">Announcements</h3>
				</div>
				<div class="panel-body">
					<ul>
						<% for (int i = 0; i < announcements.size(); i++) { %>
						<li>
							<h3><%=announcements.get(i).getSubject()%></h3>
							<p><%=announcements.get(i).getBody()%></p>
						</li>
						<% } %>
					</ul>
				</div>
			</div>
			</div>


		</div>
	</div>

	<div class="container-fluid">
	<div class="row">
		<div class="col-md-4"><div class="panel panel-default">
			<div class="panel-heading"><h1 class="panel-title">Popular Quizzes</h1></div>
			<div class="panel-body">
				<ol>
					<% for (int i = 0; i < popularQuizzes.size() && i < 5; i++) { %>
						<li><a
							<%String id = String.valueOf(popularQuizzes.get(i).getQuizID());%>
							href="quiz-summary-page.jsp?id=<%=id%>"
							STYLE="text-decoration: none">
								<h4><%=popularQuizzes.get(i).getQuizName()%></h4>
								<p><%=popularQuizzes.get(i).getQuizDescription()%></p>
						</a></li>
					<% } %>
				</ol>
			</div></div></div>
			
		<div class="col-md-4"><div class="panel panel-default">
			<div class="panel-heading"><h1 class="panel-title">Recently Created</h1></div>
			<div class="panel-body">
				<ol>
					<% for (int i = 0; i < recentQuizzes.size() && i < 5; i++) { %>
						<li>
							<h4><%=recentQuizzes.get(i).getQuizName()%></h4>
							<p><%=recentQuizzes.get(i).getQuizDescription()%></p>
						</li>
					<% } %>
				</ol>
		</div></div></div>

		<div class="col-md-4"><div class="panel panel-default">
			<div class="panel-heading"><h1 class="panel-title">Recently Taken</h1></div>
			<div class="panel-body">
				<ol>
					<% for (int i = 0; i < recentlyTakenQuizzes.size() && i < 5; i++) { %>
						<li>
							<h4><%=recentlyTakenQuizzes.get(i).getQuizName()%></h4>
							<p><%=recentlyTakenQuizzes.get(i).getQuizDescription()%></p>
						</li>
					<% } %>
				</ol>
			</div>
		</div></div>
	</div></div>
	
	<div class="container-fluid">
	<div class="row">
	<div class="col-md-6"><div class="panel panel-default">
		<div class="panel-heading"><h1 class="panel-title">My Quizzes</h1></div>
		<div class="panel-body">
			<ol>
				<% for (int i = 0; i < myQuizzes.size() && i < 5; i++) { %>
					<li>
						<h4><%=myQuizzes.get(i).getQuizName()%></h4>
						<p><%=myQuizzes.get(i).getQuizDescription()%></p>
					</li>
				<% } %>
			</ol>
		</div>
	</div></div>
	
	<div class="col-md-6"><div class="panel panel-default">
		<div class="panel-heading"><h1 class="panel-title">Friend Activities</h1></div>
		<div class="panel-body">
			tbd
		</div>
	</div></div>
	</div>
	</div>
	
</body>
</html>