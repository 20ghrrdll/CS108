<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="java.util.*, quizzes.*, users.*, main.*, messages.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<%@include file="navigation-bar.jsp"%>
<%
	ArrayList<QuizPerformance> recentlyTakenScores = quizManager
			.getRecentlyTakenQuizzesScore(user.getUsername());

	String usernameToView = request.getParameter("username");
	/* 	if (userManager.getUser(usernameToView) == null) {
	 */
%>

<title>Results</title>
</head>
<body>
	<%
		int id = (Integer) session.getAttribute("currQuizId");
	%>
	<h1 class="text-center">Results</h1>
	<h4 class="text-center">
		<% out.print(user.getUsername());
		%>, you scored
		<%
			out.print(session.getAttribute("score"));
		%>/<%
			out.print(session.getAttribute("maxScore"));
		%>
		points.
		<%
			//Long startTime = 
			if (session.getAttribute("score").equals(session.getAttribute("maxScore"))) {
				if (!userManager.getAchievements(user.getUsername()).contains(FinalConstants.PERFECT_SCORE)) {
					userManager.addAchievement(user.getUsername(), FinalConstants.PERFECT_SCORE);
				}
			}
		%>
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
						<%
							ArrayList<String> userAnswers = (ArrayList<String>) request.getAttribute("allUserAnswers");

							ArrayList<Question> questions = (ArrayList<Question>) request.getAttribute("questions");
						%>
						<table class="table">
							<tr>
							<td>Question</td>
							<td>Your Answer</td>
							<td>Correct Answer</td>
							</tr>
							<%
								ArrayList<Boolean> isAnswerCorrect = (ArrayList<Boolean>)request.getAttribute("isAnswerCorrect");
								for (int a = 0; a < userAnswers.size(); a++) {
									if(isAnswerCorrect.get(a)) out.println("<tr>");
									else out.println("<tr class=\"danger\">");
									Question currQuestion = questions.get(a);
									out.println("<td>"+ (a+1)+". "+currQuestion.getQuestionText()+"</td>");
									out.println("<td>"+userAnswers.get(a)+"</td>");
									String answer = currQuestion.getCorrectAnswer();
									
									if(answer.equals("go to question_answers")){
										answer = "";
										QuestionManager manager = (QuestionManager) request.getServletContext().getAttribute("questionManager");
										ArrayList<String> potentialAnswers = currQuestion.potentialAnswers(manager);
										int numPotentialAnswers = potentialAnswers.size();
										for(int b = 0; b < numPotentialAnswers -1; b++){
											answer += potentialAnswers.get(b) + ", ";
										}
										answer+= potentialAnswers.get(numPotentialAnswers-1);
									}
									
									out.println("<td>"+answer+"</td>");
									out.println("</tr>");
								}

							%>
						</table>
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
									<%
										for (String friend : friendsNames) {
									%>
									<option value="<%=friend%>"><%=friend%></option>
									<%
										}
									%>
								</select>
							</div>
							<label>Your Results:</label>
							<p><%=session.getAttribute("score")%>
								out of
								<%=session.getAttribute("maxScore")%></p>
							<input type="hidden" name="senderId"
								value="<%=user.getUsername()%>" /> <input type="hidden"
								name="sendChallenge" value="<%=user.getUsername()%>" /> <input
								name="resultsPage" type="hidden"
								value="<%=request.getContextPath()%>" /> <input type="hidden"
								name="quizId"
								value="<%=session.getAttribute("currQuizId")%> <%=session.getAttribute("score")%>&#47;<%=session.getAttribute("maxScore")%>" />
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