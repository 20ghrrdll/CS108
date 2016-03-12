<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.util.*, quizzes.*, users.*, main.*, messages.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href=”bootstrap/css/bootstrap.min.css” rel=”stylesheet” type=”text/css” />
<script type=”text/javascript” src=”bootstrap/js/bootstrap.min.js”></script>
<title>Edit Quiz</title>
<%@include file="navigation-bar.jsp" %>
<%
	int quizId = Integer.valueOf(request.getParameter("id"));
	//QuizManager quizManager = (QuizManager) request.getServletContext().getAttribute("quizManager");
	QuestionManager questionManager = (QuestionManager) request.getServletContext().getAttribute("questionManager");

	Quiz quiz = quizManager.getQuiz(quizId);
	String quizName = quiz.getQuizName();
	ArrayList<Question> questions = quizManager.getQuestions(quiz.getQuizID());
	int num = 0;
%>


<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="bootstrap/js/bootstrap.min.js"></script>
<script>
function removeElement(elementId) {	
	//elementId.value = "change";
	document.getElementById(elementId).remove();
	//que.removeChild(elementId);	
}
</script>
<script language="javascript">
//int num = 0;
	function addQuestions() {

		var div = document.createElement("div");
		div.id = "div";
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

		var del = document.createElement("input");
		del.setAttribute("type", "button");
		del.setAttribute("value", "Delete Question");

		page.appendChild(p);
		page.appendChild(br);
		page.appendChild(questionLabel);
		page.appendChild(question);
		page.appendChild(br);
		page.appendChild(answerLabel);
		page.appendChild(answer);
		page.appendChild(br);
		page.appendChild(br);
		page.appendChild(p);
		page.appendChild(br);

		page.appendChild(del);
		page.appendChild(p);

		page.appendChild(br);
		page.appendChild(br);
	}
</script>


</head>
<body>

<%
	ArrayList<String> questionText = new ArrayList<String>();
	ArrayList<String> answerText = new ArrayList<String>();
	ArrayList<String> questionIds = new ArrayList<String>();
%>

<%
	for (int i = 0; i < questions.size(); i++) {
		Question q = questions.get(i);
		String question = q.getQuestionText();
		String answer = "";
		
		String questionId = "question" + i;
		questionIds.add(questionId);
		//questionIds.add()
		
		answer = q.getCorrectAnswer();
		
		if (!answer.equals("go to question_answers") && quiz.getQuizType() != QuizType.MultipleChoice) {
			questionText.add(question);
			answer = q.getCorrectAnswer();
			answerText.add(answer);
		} else {
			if (quiz.getQuizType() == QuizType.MultipleChoice) {
				answer = q.getCorrectAnswer() + " | ";
			} else answer = "";
			
			ArrayList<String> c = questionManager.getAllAnswers(String.valueOf(quizId), String.valueOf(i+1));
			 //String corr = "";
			 for (int j = 0; j < c.size(); j++) {
				// if (j == 0) answer += " | " + c.get(j) + " | ";
				  if (j == c.size()-1) answer += c.get(j);
				 else answer += c.get(j) + " | ";
			 }
			 questionText.add(question);
			 answerText.add(answer);
		%>
		
		<%} %>
	
	
			
		<% 	
	}
%>

<div class="container-fluid">
<div class="col-md-12"><div class="panel panel-default">
<div class="panel-heading"><h1>Edit '<%=quizName%>'</h1></div>
<div class="panel-body">

	<form action="AddQuestionsServlet" method="post">
		
<span id="questions">
	<%

	for (int i = 0; i < questionText.size(); i++) {
		String questionId = questionIds.get(i);
		String q = "Question";
	%>
<div id="<%=questionId%>">
		Question: <textarea class = "form-control" name="question" id=questionId><%=questionText.get(i)%></textarea><br>
		Answer: <textarea class = "form-control" name="answer"><%=answerText.get(i)%></textarea>
				<br>
		
		<input type="button" class="btn btn-danger" value="Delete question" onclick="removeElement('<%=questionId%>')">
		<br>
		<br>
		</div>
<%} %>
</span>	
<br>
	<input type="button" class="btn btn-primary" value="Add question" onclick="addQuestions()">
	<input type="submit" class="btn btn-success" value="Done">
		
		<br>
		<br>
	<input type="hidden" name="quizId" value=<%=String.valueOf(quizId)%>></input>
		<input type="hidden" name="editing" value="yes"></input>
	
		</form>
	
	</div></div></div></div>

</body>
</html>