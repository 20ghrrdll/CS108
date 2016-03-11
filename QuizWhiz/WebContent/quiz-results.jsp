<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="java.util.*, quizzes.*, users.*, main.*, messages.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<%@include file="navigation-bar.jsp"%>
<%
ArrayList<QuizPerformance> recentlyTakenScores = quizManager.getRecentlyTakenQuizzesScore(user.getUsername());

	String usernameToView = request.getParameter("username");
/* 	if (userManager.getUser(usernameToView) == null) {
 */%>

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
	<center>
		<a href="quiz-summary-page.jsp?id=<%=id%>">
			<button type="button" class="btn btn-default">Return to Quiz
				Summary</button>
		</a>
	</center>
	<center>
		<button type="button" class="btn btn-default" id="challengeBtn">Challenge
			a friend!</button>
	</center>

	<br>
	<br>
	<div class="container-fluid">

		<div class="col-md-6">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h1 class="panel-title">Your Results:</h1>
				</div>
				<div class="panel-body">
					<ol>
						<%
				ArrayList<String> userAnswers = (ArrayList<String>)request.getAttribute("allUserAnswers");
			
				out.print(userAnswers);
			%>
					</ol>
				</div>
			</div>
		</div>

	</div>

	<div class="container">
		<!-- Modal -->
		<div class="modal fade" id="myChallengeModal" role="dialog">
			<div class="modal-dialog">
				<!-- Modal content-->
				<div class="modal-content">
					<div class="modal-header" style="padding: 35px 50px;">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4>Challenge a Friend!</h4>
					</div>
					<div class="modal-body" style="padding: 40px 50px;">
						<form action="MessageServlet" method="post">
							<div class="form-group">
								<label>Challenge:</label> <select class="form-control"
									name="username">
									<% for (String friend: friendsNames) { %>
									<option value="<%=friend%>"><%=friend %></option>
									<% } %>
								</select>
							</div>
							<label>Your Results:</label>
							<p><%=session.getAttribute("score") %>
								out of
								<%=session.getAttribute("maxScore") %></p>
							<input type="hidden" name="senderId"
								value="<%=user.getUsername()%>"/> <input type="hidden"
								name="sendChallenge" value="<%= user.getUsername()%>"/>
								<input type="hidden" name="quizId" value="<%= session.getAttribute("currQuizId")%> <%=session.getAttribute("score") %>" />
							<button onclick="sendChallenge" class="btn btn-default"
								value="send">Challenge!</button>
						</form>
					</div>
					<div class="modal-footer">
						<button type="submit" class="btn btn-danger btn-default pull-left"
							data-dismiss="modal">
							<span class="glyphicon glyphicon-remove"></span> Cancel
						</button>
					</div>
				</div>

			</div>
		</div>
	</div>

	<script>
		$(document).ready(function() {
			$("#challengeBtn").click(function() {
				$("#myChallengeModal").modal();
			});

		});
	</script>

</body>
</html>