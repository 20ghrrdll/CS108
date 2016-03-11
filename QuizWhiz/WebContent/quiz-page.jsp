<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*, quizzes.*, users.*, main.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href=”bootstrap/css/bootstrap.min.css” rel=”stylesheet” type=”text/css” />
<script type=”text/javascript” src=”bootstrap/js/bootstrap.min.js”></script>
<title>Quiz</title>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="bootstrap/js/bootstrap.min.js"></script>

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
<div class="container-fluid">
<div class="col-md-12"><div class="panel panel-default">
<div class="panel-heading"><h1><%=quizName%></h1></div>
<div class="panel-body">

	<%
		//ArrayList<Question> questions = new ArrayList<Question>(2);
		ArrayList<Question> questions = quizManager.getQuestions(quizID);
		/*Question testQ1 = new Question(1, 1, "How many knees do elephants have?", 
				"0", 1);
		questions.add(testQ1);
		Question testQ2 = new Question(1, 2, "Who has more neck vertabrae: humans, giraffes or they both have the same number?",
				"they both have the same number", 0);
		<<<<<<< HEAD
		questions.add(testQ2);*/
		//int numQuestions = questions.size();

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
				out.println("<div class = \"question\">"+
						qManager.QuestionHTML(quizType, toPrint.getQuestionText(), qId, Integer.toString(quizID), a+1)+"</div>");
			%>
		</div>
		<%
			}
			boolean practiceMode = toDisplay.hasPracticeMode();
			out.println("<input name=\"practiceMode\" type = \"hidden\" value = \"" + practiceMode+"\"/>");
			
			out.println("<input name=\"quizType\" type = \"hidden\" value = \"" + quizType+"\"/>");
		%>
		<br> <div class="submit"><input type="submit" /></div>
	</form>
</div></div></div></div>
</body>
</html>