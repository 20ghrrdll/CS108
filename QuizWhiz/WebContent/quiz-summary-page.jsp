<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="java.util.*, quizzes.*, users.*, main.*, java.sql.*, java.text.*, administration.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Quiz Summary</title>
<%@include file="navigation-bar.jsp"%>
</head>

<%
	int id = Integer.valueOf(request.getParameter("id"));
	System.out.println(id);
	System.out.println(id);
	Quiz quiz = quizManager.getQuiz(Integer.valueOf(id));
	ArrayList<QuizPerformance> scores = quizManager.getQuizPerformances(id);
%>

<body>


	<% if(quiz == null) { %>
	<div class="alert alert-danger">
		<strong>Error!</strong> Quiz does not exist.
	</div>
	<% } else if(request.getParameter("error") != null) { %>
	<div class="alert alert-danger">
		<strong>Error:</strong>
		<% out.print(FinalConstants.ERROR_MSG); %>
	</div>
	<% } else { 
	if (request.getParameter("reported") != null) {%>
	<div class="alert alert-info">
		<strong>Success:</strong> This quiz has been reported.
	</div>
	<% }
%>

	<div class="container-fluid">
		<h1><%=quiz.getQuizName() %></h1>
		<div class="row">
			<div class="col-md-6">
				<div class="panel panel-default">

					<div class="panel-heading">
						<h1 class="panel-title">Quiz Description</h1>
					</div>
					<div class="panel-body">
						<%=quiz.getQuizDescription()%>
						<p>
							<i> created by <a
								href="user-profile.jsp?username=<%=quiz.getQuizCreator()%>">
									<%=quiz.getQuizCreator()%></a></i>
						</p>
						<br>
						<br>
						<% 
							System.out.println("Id is "+id);
							String quizPageButton;
							if(!quiz.displayMultiplePages()){
								quizPageButton = "<a class=\"btn btn-primary\" href=\"quiz-page.jsp?id="+id+"\" role=\"button\">Start Quiz</a>";
							}
							else{
								quizPageButton = "<a class=\"btn btn-primary\" href=\"MultiplePageServlet.java\" role=\"button\">Start Quiz</a>";
							}
							System.out.println(quizPageButton);
							out.println(quizPageButton);
						%>
						<% if (user.getUsername().equals(quiz.getQuizCreator())) { %>
						
						<a class="btn btn-primary" href="edit-quiz.jsp?id=<%=id%>">Edit Quiz</a>
						
						<% } else { %>
						<br>
						<br>
						<form action="ReportQuizServlet" method="post">
							<input type="hidden" name="quizId" value="<%=id%>"> <input
								type="hidden" name="reporter" value="<%=user.getUsername()%>">
							<button type="submit" class="btn btn-danger">Report Quiz</button>
						</form>
						<% }
			
			if (userManager.isAdmin(user.getUsername())) { %>
						<br>
						<br>
						<b>Admin Functions:</b>
						<form action="AdminServlet" method="post">
							<input type="hidden" name="quizId"
								value="<%=quiz.getQuizID() %>">
							<div class="col-md-3" style="float: left">
								<button type="submit" class="btn btn-link" name="buttonAction"
									value="delete">
									<i class="material-icons">delete</i> <br>Delete
								</button>
							</div>
							<div class="col-md-3" style="float: left">
								<button type="submit" class="btn btn-link" name="buttonAction"
									value="clearHistory">
									<i class="material-icons">history</i> <br>Clear History
								</button>
							</div>
						</form>
						<% } %>
					</div>
				</div>
			</div>

			<div class="col-md-6">
				<div class="panel panel-default">
					<div class="panel-heading">
						<h2 class="panel-title">Summary Statistics</h2>
					</div>
					<div class="panel-body">
						<% 
				 if (scores.size() == 0) { %>
						<p>This quiz hasn't been taken yet!</p>
						<% } else {
								double scoreAvgTotal = 0;
								long timeTotal = 0;
				for (int i = 0; i < scores.size(); i++) {
					scoreAvgTotal += (double) scores.get(i).getScore()/scores.get(i).getPossibleScore();
					timeTotal += scores.get(i).getTotalTime();
				}

				double avgScore = scoreAvgTotal/scores.size();
				avgScore *= 100;
				String s = String.format("%.2f", avgScore);
				long avgTime = timeTotal/scores.size();
				long avgMins = avgTime / 60;
				long avgSecs = avgTime % 60;
			
			%>

						<b>Average Score:</b>
						<%=s%>%
						<br> <b>Average Time Taken:</b>
						<%=avgMins%>
						mins,
						<%=avgSecs%>
						secs<br>
						<% } %>

						<b>Average Rating: </b>
						<% double avgRating = quizManager.getAverageRating(id); 
			if (avgRating == 0) {
				out.println("Quiz has not been rated yet.<br>");
			} else {
				out.println(String.format( "%.1f", avgRating) + "/" + FinalConstants.MAX_RATING);
			}
			%>

					</div>
				</div>
			</div>
		</div>

		<div class="row">
			<div class="col-md-12">
				<div class="panel panel-default">
					<div class="panel-heading">
						<h2 class="panel-title">Your Past Performance</h2>
					</div>
					<div class="panel-body">
						<ol>
							<% ArrayList<QuizPerformance> quizzesTaken = quizManager.getMyRecentlyTakenQuizPerformance(user.getUsername(), id);
				if (quizzesTaken.size() == 0) { %>
							<p>No recent activity to display.</p>
							<% } else {
					for (int i = 0; i < quizzesTaken.size() && i < 5; i++) {
						String score = quizzesTaken.get(i).getScoreString();
						String date = quizzesTaken.get(i).getDate(); %>
							<p>
								Date:
								<%=date%>, Score:
								<%=score%></p>

							<% }
			  } %>
						</ol>
					</div>
				</div>
			</div>
		</div>

		<div class="row">
			<div class="col-md-6">
				<div class="panel panel-default">
					<div class="panel-heading">
						<h2 class="panel-title">All-Time High Scores</h2>
					</div>
					<div class="panel-body">
						<ol>
							<% ArrayList<QuizPerformance> highScores = quizManager.getQuizHighScores(id);
					if (highScores.size() == 0) { %>
							<p>No high scores to display.</p>
							<% } else {
						for (int i = 0; i < highScores.size() && i < 5; i++) {
							String highScoreUser = highScores.get(i).getUserName();
							if (i == 0 && !userManager.getAchievements(highScoreUser).contains(FinalConstants.HIGHEST_SCORE)) {
								userManager.addAchievement(highScoreUser, FinalConstants.HIGHEST_SCORE);
							}
							String score = highScores.get(i).getScoreString(); %>
							<p>
							<li><a href="user-profile.jsp?username=<%=highScoreUser%>">
									<%=highScoreUser%></a>, Score: <%=score%></li>
							</p>
							<% }
					} %>
						</ol>
					</div>
				</div>
			</div>

			<div class="col-md-6">
				<div class="panel panel-default">
					<div class="panel-heading">
						<h2 class="panel-title">Today's High Scores</h2>
					</div>
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
							String score = highScoresToday.get(i).getScoreString(); %>
							<p>
							<li><a href="user-profile.jsp?username=<%=highScoreUser%>">
									<%=highScoreUser%></a>, Score: <%=score%></p></li>
							<% } 
					} %>
						</ol>
					</div>
				</div>
			</div>
		</div>

		<div class="row">
			<div class="col-md-12">
				<div class="panel panel-default">
					<div class="panel-heading">
						<h2 class="panel-title">Recent Performances</h2>
					</div>
					<div class="panel-body">
						<ol>
							<% if (scores.size() == 0) { %>
							<p>This quiz hasn't been taken yet!</p>
							<% } else {
								for (int i = 0; i < scores.size() && i < 5; i++) {
									String scoreUser = scores.get(i).getUserName();
									String score = scores.get(i).getScoreString(); %>
							<p>
							<li><a href="user-profile.jsp?username=<%=scoreUser%>">
									<%=scoreUser%></a>, Score: <%=score%></li>
							</p>
							<%}
						}
						%>
						</ol>
					</div>
				</div>
			</div>
		</div>


		<% if (user.getUsername().equals(quiz.getQuizCreator())) { 
			out.println("<div class=\"row\"><div class=\"col-md-12\">");
		} else {
			out.println("<div class=\"row\"><div class=\"col-md-6\">");
		} %>
		<div class="panel panel-default">
			<div class="panel-heading">
				<h2 class="panel-title">Ratings and Reviews</h2>
			</div>
			<div class="panel-body">
				<% ArrayList<Review> reviews = quizManager.getReviews(id);
				if (reviews.size() == 0) {
					out.println("No reviews yet.");
				} else { 
					for (int i = 0; i < reviews.size(); i++) { 
						Review review = reviews.get(i); %>
				<div class="panel panel-primary">
					<div class="panel-heading">
						<% 
						  int rating = review.getRating();
						  for (int r = 0; r < rating; r++) {
							  out.print("★");
						  }
						  for (int r = 0; r < FinalConstants.MAX_RATING - rating; r++) {
							  out.print("☆");
						  }
						  out.print(" - " + review.getReviewer() + " - " + review.getCreated()); 
						  %>
					</div>
					<div class="panel-body">
						<% out.println(review.getReview()); %>
					</div>
				</div>
				<% } 
				} %>
			</div>
		</div>
	</div>

	<% if (!user.getUsername().equals(quiz.getQuizCreator())) { %>
	<div class="col-md-6">
		<div class="panel panel-default">
			<div class="panel-heading">
				<h2 class="panel-title">Write A Review</h2>
			</div>
			<div class="panel-body">
				<form action="ReviewServlet" method="post">
					<label for="exampleInputEmail1">Rating</label><br>
					<% for (int i = 1; i <= FinalConstants.MAX_RATING; i++) { %>
					<label class="radio-inline"> <input type="radio"
						name="rating" value="<%=i%>"> <%=i%>
					</label>
					<% } %>
					<br>
					<br>
					<div class="form-group">
						<label for="exampleInputEmail1">Review</label>
						<textarea class="form-control" rows="3" name="review"></textarea>
					</div>
					<input type="hidden" name="quizId" value="<%=id%>"> <input
						type="hidden" name="reviewer" value="<%=user.getUsername()%>">
					<br>
					<button type="submit" class="btn btn-default">Submit</button>
				</form>
			</div>
		</div>
	</div>
	<% } %>

	</div>
	</div>
	</div>

	<% } %>

</body>
</html>

