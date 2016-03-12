<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*, quizzes.*, users.*, main.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<link
	href="http://code.jquery.com/ui/1.10.4/themes/ui-lightness/jquery-ui.css"
	rel="stylesheet">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
	rel="stylesheet">
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<!--  <script
 	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script> -->
<!-- Include all compiled plugins (below), or include individual files as needed -->
<script
	src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js"></script>
<link
	href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css"
	rel="stylesheet" type="text/css" />
<link
	href="${pageContext.request.contextPath}/style/bootstrapOverride.css"
	rel="stylesheet" type="text/css" />
<link type="text/css" rel="stylesheet"
	href="${pageContext.request.contextPath}/style/multiplePages.css" />
<title>
	<%
		MultiplePageQuiz multiQuiz = (MultiplePageQuiz) request.getServletContext()
				.getAttribute("multiplePageQuiz");
		int quizID = Integer.parseInt(request.getParameter("quizId"));

		int questionNum = multiQuiz.getCurrQuestionNum();
		QuizManager quizManager = (QuizManager) request.getServletContext().getAttribute("quizManager");
		Quiz toDisplay = quizManager.getQuiz(quizID);
		String quizName = toDisplay.getQuizName();
		String quizType = multiQuiz.getQuizType();
		session.setAttribute("currQuizId", quizID);
		//User user = (User) session.getAttribute("currentUser");

		out.print(quizName + ": Question " + questionNum);
	%>
</title>
</head>
<body>
	<div class="container-fluid">
		<br> <br>
		<div class="panel panel-default">
			<div class="quit" align="right" >
				<a href="quiz-summary-page.jsp?id=<%=quizID%>" class="button"> <span
					title="quit" class="glyphicon glyphicon-remove-circle" width="100" height="100" style="color: #ce3c3e;"></span>
				</a>
			</div>

			<div class="panel-body">
				<%
					String nextPage;
					if (questionNum < multiQuiz.getNumQuestions()) {
						nextPage = "<form action=\"NextQuestionPageServlet\" method=\"post\">";
					} else {
						//need to rename with results Servlet
						nextPage = "<form action=\"NextQuestionPageServlet\" method=\"post\">";
					}
					out.println(nextPage);
				%>
				<div class="question_info">
					<%
						QuestionManager qManager = (QuestionManager) request.getServletContext().getAttribute("questionManager");

						Question currQuestion = multiQuiz.getQuestion();
						String html = "<div class = \"question\">"
								+ qManager.QuestionHTML(quizType, currQuestion.getQuestionText(),
										Integer.toString(currQuestion.getQuestionId()), Integer.toString(quizID), questionNum)
								+ "</div>";
						System.out.println(html);
						out.println(html);
						if (multiQuiz.getImmediateScoring() && request.getAttribute("prevAnswer") != null) {
					%>
					<script>
						
					<%String prevAnswer = (String) request.getAttribute("prevAnswer");
				if (quizType == "MultipleChoice")
					out.println("$('input:radio[value=" + prevAnswer + "]').checked=true;");
				else if (quizType == "FillIn")
					out.println("document.getElementsByName(\"" + currQuestion.getQuestionId() + "-0\")[0].value = \""
							+ prevAnswer + "\";");
				else
					out.println("document.getElementsByName(\"" + currQuestion.getQuestionId() + "\")[0].value = \""
							+ prevAnswer + "\";");%>
						
					</script>
					<%
						}
					%>

				</div>
				<br>

				<%
					if (multiQuiz.getImmediateScoring()) {
				%>
				<input type="submit" class="btn" name="checkWork"
					value="Check Your Answer"
					style="background-color: #3ccecc; color: #fff;" />

				<%
					if (request.getParameter("startQuiz") == null) {
							if (request.getAttribute("isCorrect") != null) {
								boolean correct = (Boolean) request.getAttribute("isCorrect");
								if (correct) {
				%>
				<i class="medium material-icons" style="color: #3cce83;">thumb_up</i>
				<%
					} else {
				%>
				<i class="medium material-icons" style="color: #ce3c3e;">thumb_down</i>
				<%
					}
							}
						}
					}
					out.println("<input name=\"questionNum\" type = \"hidden\" value = \"" + questionNum + "\"/>");
					out.println(
							"<input name=\"questionId\" type = \"hidden\" value = \"" + currQuestion.getQuestionId() + "\"/>");
					out.println("<input name=\"quizId\" type = \"hidden\" value = \"" + quizID + "\"/>");
				%>
				<div class="submit">
					<%
						String nextPageButton;
						if (questionNum < multiQuiz.getNumQuestions()) {
							nextPageButton = "<input type=\"submit\" class = \"btn btn-default\"  name = \"nextQuestion\" value =\"Next Question\"/>";
						} else {
							nextPageButton = "<input type=\"submit\" class = \"btn btn-default\" name = \"finishQuiz\" value =\"Finish Quiz\"/>";
						}
						out.println(nextPageButton);
					%>
				</div>
				</form>

			</div>
		</div>
	</div>
</body>
</html>