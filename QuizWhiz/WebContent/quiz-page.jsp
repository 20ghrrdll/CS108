<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*, quizzes.*, users.*, main.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/style/index.css" />
<link rel="stylesheet" href="http://www.w3schools.com/lib/w3.css">
<link rel="stylesheet" href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.4.0/css/font-awesome.min.css">
<link rel="stylesheet" href="http://www.w3schools.com/lib/w3-theme-indigo.css">
<script>
function myFunction(id) {
    document.getElementById(id).classList.toggle("w3-show");
}
</script>
<title><% 
QuizManager quizManager = (QuizManager) request.getServletContext().getAttribute("quizManager"); 
Quiz toDisplay = quizManager.getQuiz(Integer.valueOf("1"));
String quizName = toDisplay.getQuizName();
out.print(quizName);
//out.print(quizName);
//quizManager.getQuiz(session.getAttribute("quizid"));
%>
</title>
</head>
<body>
	<h1><% out.print(quizName); %></h1>
	<% //ArrayList<Question> questions = new ArrayList<Question>(2);
	ArrayList<Question> questions = quizManager.getQuestions(toDisplay.getQuizID());
	/*Question testQ1 = new Question(1, 1, "How many knees do elephants have?", 
			"0", 1);
	questions.add(testQ1);
	Question testQ2 = new Question(1, 2, "Who has more neck vertabrae: humans, giraffes or they both have the same number?",
			"they both have the same number", 0);
	questions.add(testQ2);*/
	//int numQuestions = questions.size();
	
	int numQuestions = questions.size();
	%>
	<form action="QuizResultServlet" method="post">
		<%
		QuestionManager qManager = new QuestionManager();
		String quizType = toDisplay.getQuizType();
		for(int a = 0; a < numQuestions; a++){ 
			Question toPrint = questions.get(a);
		%>
			<div class="question_info">
				<% out.println(qManager.QuestionHTML(quizType, toPrint.getQuestionText())); %>
				<div class="answer">Answer: </div><% out.println(qManager.AnswerHTML(quizType));%>
			</div>				
		<% } %>
		<br>
		
		<input type="submit" />
	</form>

</body>
</html>