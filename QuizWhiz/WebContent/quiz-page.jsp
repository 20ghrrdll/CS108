<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*, quizzes.*, users.*, main.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<link type="text/css" rel="stylesheet"
	href="${pageContext.request.contextPath}/style/index.css" />
<link type="text/css" rel="stylesheet"
	href="${pageContext.request.contextPath}/style/quizPage.css" />
 <script
 	src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js"></script>
 <link
 	href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css"
 	rel="stylesheet" type="text/css" />
 	<link
 	href="${pageContext.request.contextPath}/style/bootstrapOverride.css"
 	rel="stylesheet" type="text/css" />
<script>
	function myFunction(id) {
		document.getElementById(id).classList.toggle("w3-show");
	}
</script>
<title>
	<%
		long start = System.currentTimeMillis();
		session.setAttribute("startTime", start);
		int quizID = Integer.parseInt(request.getParameter("id"));
		QuizManager quizManager = (QuizManager) request.getServletContext().getAttribute("quizManager");
		Quiz toDisplay = quizManager.getQuiz(quizID);
		String quizName = toDisplay.getQuizName();
		session.setAttribute("currQuizId", quizID);
		User user = (User)session.getAttribute("currentUser");
		
		out.print(quizName);
	%>
</title>
</head>
<body>
	<div class="container-fluid"><div class="panel panel-default">
					
	<div class="panel-heading"><h1> <% out.print(quizName); %> </h1></div>
	<%
		ArrayList<Question> questions = quizManager.getQuestions(quizID);
		int numQuestions = questions.size();
	%>
	<form action="QuizResultServlet" method="post">
		<%
			QuestionManager qManager = (QuestionManager) request.getServletContext().getAttribute("questionManager");
			if(toDisplay.randomOrder()){
				long seed = System.nanoTime();
				Collections.shuffle(questions, new Random(seed));
			}
			request.setAttribute("questions", questions);
			 String quizType = ((QuizType)toDisplay.getQuizType()).toString();
			for (int a = 0; a < numQuestions; a++) {
				Question toPrint = questions.get(a);
				String qId = Integer.toString(toPrint.getQuestionId());
		%>
		<div class="question_info">
			<%
				out.println(qManager.QuestionHTML(quizType, toPrint.getQuestionText(), qId, Integer.toString(quizID), a+1));
			%>
		</div>
		<%
			}
			boolean practiceMode = toDisplay.hasPracticeMode();
			%>
			<input name="practiceMode" type="hidden" value=<%=practiceMode%>>
			<input name="quizType" type="hidden" value=<%=quizType%>>
		
		<br> <div class="submit"><input type="submit" /></div>
	</form>
	<br>
</div>
</div>
</body>
</html>