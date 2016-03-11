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
			out.println("<div class = \"question\">"
					+ qManager.QuestionHTML(quizType, currQuestion.getQuestionText(),
							Integer.toString(currQuestion.getQuestionId()), Integer.toString(quizID), questionNum)
					+ "</div>");
		%>
	</div>
	<br>
	<script>
		$(button).click(function(){
			
		});
	</script>
	<%
		if(multiQuiz.getImmediateScoring()){
			%>
				<button class = "btn btn-default checkAnswer" >Check Answer</button>
				<script>
					$checkAnswer = $('.checkAnswer').click(function(){
						<%
							String questionId = Integer.toString(currQuestion.getQuestionId());
							//out.print()
							
						%>
						answer = $('input[name="questionId"]');
					});
				</script>
				<span class="glyphicon glyphicon-thumbs-up" aria-hidden="true"></span>
				<span class="glyphicon glyphicon-thumbs-up" aria-hidden="true"></span>
			
			<% 
		}
		out.println("<input name=\"questionNum\" type = \"hidden\" value = \"" + questionNum+"\"/>");		
		out.println("<input name=\"questionId\" type = \"hidden\" value = \"" + currQuestion.getQuestionId()+"\"/>");
		out.println("<input name=\"quizId\" type = \"hidden\" value = \"" + quizID+"\"/>");
	%>
	<div class="submit">
	<%
		String nextPageButton;
		if (questionNum < multiQuiz.getNumQuestions()) {
			nextPageButton = "<input type=\"submit\" class = \"btn btn-default\" value =\"Next Question\"/>";
		} else {
			nextPageButton = "<input type=\"submit\" class = \"btn btn-default\" value =\"Finish Quiz\"/>";
		}
		out.println(nextPageButton);
	%>
	</div>
	</form>

</body>
</html>