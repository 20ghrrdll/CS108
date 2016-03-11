<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*, quizzes.*, users.*, main.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<title>
	<%
		MultiplePageQuiz multiQuiz = (MultiplePageQuiz) request.getServletContext()
				.getAttribute("multiplePageQuiz");
		int quizID = Integer.parseInt(request.getParameter("quizId"));

		int questionNum = multiQuiz.getCurrQuestionNum();
		QuizManager quizManager = (QuizManager) request.getServletContext().getAttribute("quizManager");
		Quiz toDisplay = quizManager.getQuiz(quizID);
		String quizName = toDisplay.getQuizName();
		String quizType = ((QuizType) request.getAttribute("QuizType")).toString();
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
	<%
		out.println("<input name=\"questionNum\" type = \"hidden\" value = \"" + questionNum+"\"/>");		
		out.println("<input name=\"questionId\" type = \"hidden\" value = \"" + currQuestion.getQuestionId()+"\"/>");
		out.println("<input name=\"quizId\" type = \"hidden\" value = \"" + quizID+"\"/>");
	%>
	<div class="submit">
	<%
		String nextPageButton;
		if (questionNum < multiQuiz.getNumQuestions()) {
			nextPageButton = "<input type=\"submit\" value =\"Next Question\"/>";
		} else {
			nextPageButton = "<input type=\"submit\" value =\"Finish Quiz\"/>";
		}
		out.println(nextPageButton);
	%>
	</div>
	</form>

</body>
</html>