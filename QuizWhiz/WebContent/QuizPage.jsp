<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*, quizzes.*, users.*, main.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><% 
//QuizManager quizManager = (QuizManager) request.getServletContext().getAttribute("quizManager"); 
//Quiz toDisplay = quizManager.getQuiz(1);
String quizName = "TestQuiz";
//out.print(toDisplay.getQuizName());
out.print(quizName);
//quizManager.getQuiz(session.getAttribute("quizid"));
%>
</title>
</head>
<body>
	<h1><% out.print(quizName); %></h1>
	<% ArrayList<Question> questions = new ArrayList<Question>(2);
	//ArrayList<Question> questions = quizManager.getQuestions(toDisplay.getQuizId());
	Question testQ1 = new Question(1, 1, "How many knees do elephants have?", 
			"0", 1);
	questions.add(testQ1);
	Question testQ2 = new Question(1, 2, "Who has more neck vertabrae: humans, giraffes or they both have the same number?",
			"they both have the same number", 0);
	questions.add(testQ2);
	//int numQuestions = questions.size();
	
	int numQuestions = 2;
	%>
	<form>
		<%
		for(int a = 0; a < numQuestions; a++){ 
			Question toPrint = questions.get(a);
		%>
			<div class="question_info">
				<h3><% out.println(toPrint.getQuestionText()); %></h3>
				<div class="answer">Answer: </div><input type="text" name="answer" />
			</div>				
		<% } %>
		<br>
		<input type="submit" />
	</form>

</body>
</html>