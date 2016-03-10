<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*, quizzes.*, users.*, main.*, java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Quiz Summary</title>
<%@include file="navigation-bar.jsp" %>
</head>

<%
	int id = Integer.valueOf(request.getParameter("id"));
	Quiz quiz = quizManager.getQuiz(Integer.valueOf(id));
	ArrayList<QuizPerformance> scores = quizManager.getQuizPerformances(id);
%>

<body>
<div class="container-fluid">
	<div class="row">
	<div class="col-md-7"><div class="panel panel-default">
		<div class="panel-heading"><h1 class="panel-title">Quiz Description</h1></div>
		<div class="panel-body">
			<%=quiz.getQuizDescription()%>
			<p> <i> created by <a
			href="user-profile.jsp?username=<%=quiz.getQuizCreator()%>"> <%=quiz.getQuizCreator()%></a></i>
			</p>
			<br><br><a class="btn btn-primary" href="quiz-page.jsp?id=<%=id%>" role="button">Start Quiz</a>
			<% if (user.getUsername().equals(quiz.getQuizCreator())) { %>
				<p>EDIT QUIZ - LINK THIS </p>
			<% } 
			
			if (userManager.isAdmin(user.getUsername())) { %>
			<form action="EditQuizServlet" method="post">
				<input type="hidden" name="quizIDs" value="<% out.print(quiz.getQuizID()); %>">
					<div class="col-md-3" style="float: left">
						<button type="submit" class="btn btn-link" name="buttonAction" value="delete">
							<i class="material-icons">delete</i>
							<br>Delete
						</button>
					</div>
					<div class="col-md-3" style="float: left">
						<button type="submit" class="btn btn-link" name="buttonAction" value="clearHistory">
							<i class="material-icons">history</i>
							<br>Clear History</button>
					</div>
			</form>
		<% } %>
		</div>
	</div></div>
	
	<div class="col-md-5"><div class="panel panel-default">
		<div class="panel-heading"><h2 class="panel-title">Summary Statistics</h2></div>
		<div class="panel-body">
			<ol>
			<% if(scores.size() != 0){
				int scoreTotal = 0;
				long timeTotal = 0;
				for (int i = 0; i < scores.size(); i++) {
					scoreTotal += scores.get(i).getScore();
					timeTotal += scores.get(i).getTotalTime();
				}
			
				int avgScore = scoreTotal/scores.size();
				long avgTime = timeTotal/scores.size();
				long avgMins = avgTime / 60;
				long avgSecs = avgTime % 60;
			
			%>
			<p>Average Score: <%=avgScore%> </p>
			<p>Average Time Taken: <%=avgMins%> mins, <%=avgSecs%> secs</p>
			<%}  else { %>
			<p>This quiz hasn't been taken yet!</p>
			<%} %>
			</ol>
		</div>
	</div></div>
	</div>

	<div class="row"><div class="col-md-12">
	<div class="panel panel-default">
		<div class="panel-heading"><h2 class="panel-title">Your Past Performance</h2></div>
		<div class="panel-body">
			<ol>
			<% ArrayList<QuizPerformance> quizzesTaken = quizManager.getMyRecentlyTakenQuizPerformance(user.getUsername(), id);
				if (quizzesTaken.size() == 0) { %>
				<p>No recent activity to display.</p>
			<% } else {
					for (int i = 0; i < quizzesTaken.size() && i < 5; i++) {
						int score = quizzesTaken.get(i).getScore();
						String date = quizzesTaken.get(i).getDate(); %>
						<p>Date: <%=date%>, Score: <%=score%></p>
					
				<% }
			  } %>
			</ol>
		</div>
	</div>
	</div></div>

	<div class="row">
	<div class="col-md-6"><div class="panel panel-default">
		<div class="panel-heading"><h2 class="panel-title">All-Time High Scores</h2></div>
		<div class="panel-body">
			<ol>
				<% ArrayList<QuizPerformance> highScores = quizManager.getQuizHighScores(id);
					if (highScores.size() == 0) { %>
				<p>No high scores to display.</p>
				<% } else {
						for (int i = 0; i < highScores.size() && i < 5; i++) {
							String highScoreUser = highScores.get(i).getUserName();
							String score = String.valueOf(highScores.get(i).getScore()); %>
							<p><li><a href="user-profile.jsp?username=<%=highScoreUser%>"> 
								<%=highScoreUser%></a>, Score: <%=score%></li></p>
					<% }
					} %>
			</ol>
		</div>
	</div></div>
	
	<div class="col-md-6"><div class="panel panel-default">
		<div class="panel-heading"><h2 class="panel-title">Today's High Scores</h2></div>
		<div class="panel-body">
			<ol>
				<% ArrayList<QuizPerformance> highScoresToday = new ArrayList<QuizPerformance>();
					for (int i = 0; i < highScores.size(); i++) {
						if (highScores.get(i).wasToday()) {
							highScoresToday.add(highScores.get(i));
						}
					}
				
					if (highScoresToday.size() == 0) { %>
						<p>No high scores from today to display.</p>
				<% } else {
						for (int i = 0; i < quizzesTaken.size() && i < 5; i++) {	
							String highScoreUser = highScoresToday.get(i).getUserName();
							String score = String.valueOf(highScoresToday.get(i).getScore()); %>
							<p><li><a href="user-profile.jsp?username=<%=highScoreUser%>"> <%=highScoreUser%></a>, Score:
					<%=score%></p> </li>
					<% } 
					} %>
			</ol>
		</div>
	</div></div>
	</div>

	
	
	<div class="row"><div class="col-md-12">
	<div class="panel panel-default">
		<div class="panel-heading"><h2 class="panel-title">Recent Performances</h2></div>
		<div class="panel-body">
			<ol>
				<% if (scores.size() == 0) { %>
					<p>No high scores from today to display.</p>
				<% } else {
						for (int i = 0; i < scores.size() && i < 5; i++) {
							String scoreUser = scores.get(i).getUserName();
							String score = String.valueOf(scores.get(i).getScore()); %>
							<p><li><a href="user-profile.jsp?username=<%=scoreUser%>"> <%=scoreUser%></a>, Score:
							<%=score%></li></p>
					<% }
					} %>
			</ol>
		</div>
	</div></div></div>
	
	

</div>
</body>
</html>

