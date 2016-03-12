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
<script
	src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js"></script>
<link
	href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css"
	rel="stylesheet" type="text/css" />
<link
	href="${pageContext.request.contextPath}/style/bootstrapOverride.css"
	rel="stylesheet" type="text/css" />

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="bootstrap/js/bootstrap.min.js"></script>
    
<script language="javascript">
	function addQuestions() {

		var p = document.createElement("p");
		var question = document.createElement("textarea");
		var answer = document.createElement("textarea");

		var questionLabel = document.createTextNode("Question: ");		
		question.setAttribute("name", "question");
		question.classList.add("form-control");	
		var answerLabel = document.createTextNode("Answer: ");
		answer.setAttribute("name", "answer");
		answer.classList.add("form-control");	
		var br = document.createElement("BR");
		var page = document.getElementById("questions");

		page.appendChild(p);
		page.appendChild(br);
		page.appendChild(questionLabel);
		page.appendChild(question);
		page.appendChild(br);
		page.appendChild(answerLabel);
		page.appendChild(answer);
		page.appendChild(br);

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
<div class="container-fluid"><br>
<div class="col-md-12"><div class="panel panel-default">
<div class="panel-heading"><h1>Add Questions to '<%=quizName%>'</h1></div>
<div class="panel-body">

<% if(request.getParameter("error") != null) { %>
	<div class="alert alert-danger">
  		<strong>Error:</strong> There was an error adding questions. Please have at least one question.
	</div>
<% } %>

<form action="AddQuestionsServlet" method="post">
	
	<h2><small><%=instructions%></small></h2>
	<br /> 

 <button type="button" class="btn btn-primary" value="Add Question" onclick="addQuestions()">Add Question</button>
<button type="submit" class="btn btn-success" value="Done">Done</button>

	<span id="questions">&nbsp;</span>
	<input type="hidden" name="quizId" value="<%=quiz.getQuizID() %>">
		<input type="hidden" name="editing" value="no"></input>

</form>
</div></div></div></div>
</body>
</html>