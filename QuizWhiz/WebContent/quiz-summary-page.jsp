<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*, quizzes.*, users.*, main.*, java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Quiz Summary</title>
<link type="text/css" rel="stylesheet"
	href="${pageContext.request.contextPath}/style/index.css" />
<link rel="stylesheet" href="http://www.w3schools.com/lib/w3.css">
<link rel="stylesheet"
	href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.4.0/css/font-awesome.min.css">
<link rel="stylesheet"
	href="http://www.w3schools.com/lib/w3-theme-indigo.css">
</head>

<%
	QuizManager quizManager = (QuizManager) request.getServletContext().getAttribute("quizManager");
	int id = Integer.valueOf(request.getParameter("id"));
	User currentUser = (User) session.getAttribute("currentUser");
	String username = currentUser.getUsername();
	Quiz quiz = quizManager.getQuiz(Integer.valueOf(id));
%>

<body class="w3-theme-light standards">

<p> <a href="quiz-page.jsp?id=<%=id%>">Start Quiz</a> </p>
<%
	if (username.equals(quiz.getQuizCreator())) {
%>
	<p>EDIT QUIZ - LINK THIS </p>
<%
	}
%>

	<h1 class="center-title w3-theme">Quiz Description</h1>
	<p><%=quiz.getQuizDescription()%></p>
	<p>
		<i> created by <a
			href="user-profile.jsp?username=<%=quiz.getQuizCreator()%>"> <%=quiz.getQuizCreator()%></a></i>
	</p>

	<h1 class="center-title w3-theme">Your Past Performance</h1>
	<ol class="w3-ul w3-hoverable">
		<%
			
			ArrayList<QuizPerformance> quizzesTaken = quizManager.getMyRecentlyTakenQuizPerformance(username, id);
			if (quizzesTaken.size() == 0) {
		%>
		<p>No recent activity to display.</p>
		<%
			} else {
				for (int i = 0; i < quizzesTaken.size() && i < 5; i++) {
					int score = quizzesTaken.get(i).getScore();
					String date = quizzesTaken.get(i).getDate();
		%>
		
				<p>Date: <%=date%>, Score: <%=score%></p>
				
		<%
			}
			}
		%>
	</ol>

	<h1 class="center-title w3-theme">All-Time High Scores</h1>
	<ol class="w3-ul w3-hoverable">
		<%
			ArrayList<QuizPerformance> highScores = quizManager.getQuizHighScores(id);

			if (highScores.size() == 0) {
		%>
		<p>No high scores to display.</p>
		<%
			} else {
				for (int i = 0; i < highScores.size() && i < 5; i++) {
					String highScoreUser = highScores.get(i).getUserName();
					String score = String.valueOf(highScores.get(i).getScore());
		%>
		<p>
			<a href="user-profile.jsp?username=<%=highScoreUser%>"> <%=highScoreUser%></a>, Score:
			<%=score%></p>
		</li>
		<%
			}
			}
		%>
	</ol>
	
	<h1 class="center-title w3-theme">Today's High Scores</h1>
	<ol class="w3-ul w3-hoverable">
		<%
			ArrayList<QuizPerformance> highScoresToday = new ArrayList<QuizPerformance>();
			for (int i = 0; i < highScores.size(); i++) {
				if (highScores.get(i).wasToday()) {
					highScoresToday.add(highScores.get(i));
				}
			}
		
			if (highScoresToday.size() == 0) {
		%>
		<p>No high scores from today to display.</p>
		<%
			} else {
				for (int i = 0; i < quizzesTaken.size() && i < 5; i++) {
					
					String highScoreUser = highScoresToday.get(i).getUserName();
					String score = String.valueOf(highScoresToday.get(i).getScore());
		%>
		<p>
			<a href="user-profile.jsp?username=<%=highScoreUser%>"> <%=highScoreUser%></a>, Score:
			<%=score%></p>
		</li>
		<%
			}
			}
		%>
	</ol>
	
		<h1 class="center-title w3-theme">Recent Performances</h1>
	<ol class="w3-ul w3-hoverable">
		<%
			ArrayList<QuizPerformance> scores = quizManager.getQuizPerformances(id);
		
			if (scores.size() == 0) {
		%>
		<p>No high scores from today to display.</p>
		<%
			} else {
				for (int i = 0; i < scores.size() && i < 5; i++) {
					
					String user = scores.get(i).getUserName();
					String score = String.valueOf(scores.get(i).getScore());
		%>
		<p>
			<a href="user-profile.jsp?username=<%=user%>"> <%=user%></a>, Score:
			<%=score%></p>
		</li>
		<%
			}
			}
		%>
	</ol>
	
	<h1 class="center-title w3-theme">Summary Statistics</h1>
	<ol class="w3-ul w3-hoverable">
	<%
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
		
	</ol>



</body>
</html>

