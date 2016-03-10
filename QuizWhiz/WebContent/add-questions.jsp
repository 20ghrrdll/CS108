<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="java.util.*, quizzes.*, users.*, main.*, messages.*, administration.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href=”bootstrap/css/bootstrap.min.css” rel=”stylesheet” type=”text/css” />
<script type=”text/javascript” src=”bootstrap/js/bootstrap.min.js”></script>
<title>Add Questions</title>
<%@include file="navigation-bar.jsp" %>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="bootstrap/js/bootstrap.min.js"></script>
    
<script language="javascript">
	function addQuestions() {

		var div = document.createElement("p");

		var element1 = document.createElement("textarea");
		var element2 = document.createElement("textarea");

		var text1 = document.createTextNode("Question: ");
		//element1.setAttribute("type", "text");
		element1.setAttribute("name", "question");

		var text2 = document.createTextNode("Answer: ");
		//element2.setAttribute("type", "text");
		element2.setAttribute("name", "answer");

		var br = document.createElement("BR");

		var questions = document.getElementById("questions");

		questions.appendChild(div);
		questions.appendChild(br);
		questions.appendChild(br);

		questions.appendChild(text1);
		questions.appendChild(element1);
		questions.appendChild(br);

		questions.appendChild(text2);
		questions.appendChild(element2);
	}
</script>

<%
	Quiz quiz = (Quiz) request.getAttribute("quiz");
	String quizName = quiz.getQuizName();
	int id = quiz.getQuizID();
	String instructions = "";
	QuizType type = quiz.getQuizType();
	if (type == QuizType.QuestionResponse) instructions = "Separate valid answers with the | symbol.";
	else if (type == QuizType.FillIn) instructions = "Indicate blank to be filled in with | symbol. Separate valid answers with the | symbol.";
	else if (type == QuizType.MultipleChoice) instructions = "Put the correct answer choice first, separating the answer choices with the | symbol. Multiple choice questions should have 4 answer choices.";
	else if (type == QuizType.PictureResponse) instructions = "Ask a question, followed by | symbol and an absolute URL to an external image. Separate valid answers with the | symbol.";
%>

</head>

<body> 
<div class="container-fluid">
<div class="col-md-12"><div class="panel panel-default">
<div class="panel-heading"><h1>Add Questions to '<%=quizName%>'</h1></div>
<div class="panel-body">

<form action="AddQuestionsServlet" method="post">
	
	<p><%=instructions%></p>
	<br /> 

 <button type="button" class="btn btn-default" value="Add Question" onclick="addQuestions()">Add Question</button>
<button type="submit" class="btn btn-default" value="Done">Done</button>

	<span id="questions">&nbsp;</span>
	<input type="hidden" name="quizId" value="<%=quiz.getQuizID() %>">

</form>
</div></div></div></div>
</body>
</html>