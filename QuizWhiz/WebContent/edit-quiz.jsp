<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.util.*, quizzes.*, users.*, main.*, messages.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Edit Quiz</title>
<%
	int quizId = Integer.valueOf(request.getParameter("id"));
	QuizManager quizManager = (QuizManager) request.getServletContext().getAttribute("quizManager");
	Quiz quiz = quizManager.getQuiz(quizId);
	String quizName = quiz.getQuizName();
	ArrayList<Question> questions = quizManager.getQuestions(quiz.getQuizID());
%>
<script>
function removeElement(elementId) {
    var element = document.getElementById(elementId);
	var questions = document.getElementById("questions");
	element.value = "changed";
	//questions.appendChild(element);
   // questions.removeChild(element);
   // element.setAttribute("type", "button");
}

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


</head>
<body>

<h1>Edit '<%=quizName %>'</h1>
<%
	ArrayList<String> questionText = new ArrayList<String>();
	ArrayList<String> answerText = new ArrayList<String>();
	ArrayList<String> questionIds = new ArrayList<String>();
%>

<%
	for (int i = 0; i < questions.size(); i++) {
		Question q = questions.get(i);
		String question = q.getQuestionText();
		String answer = q.getCorrectAnswer();
		questionText.add(question);
		answerText.add(answer);
		
		if (answer.equals("go to question_answers")) answer = "";
		int num = q.getNumAnswers();
		ArrayList<String> c = null;
		
 		%>
	
<%
		if (num > 1) {
			 c = q.getCorrectAnswers();
			 //String corr = "";
			 for (int j = 0; j < c.size(); j++) {
				 if (j == 0) answer += " | " + c.get(j) + " | ";
				 else if (j == c.size()-1) answer += c.get(j);
				 else answer += c.get(j) + " | ";
			 }
			 questionText.add(question);
			 answerText.add(answer);
		%>
		
		<%} %>
	
		<% String questionId = "question" + i;
			questionIds.add(questionId);
		%>
			
		<% 
		
	}

for (int i = 0; i < questionText.size(); i++) {
	%>
		Question: <%=questionText.get(i) %>
		Answer: <%=answerText.get(i) %>
		QuestionId: <%=questionIds.get(i) %>
		
	
	<%} %>





<%-- 
	<form>
		Question: <textarea rows="5" cols="20" name=questionId id=questionId><%=question %></textarea> <br>
		Answer: <textarea rows="5" cols="20" name="answer"><%=answer%></textarea>
		<input type="submit" value="Delete question" onclick="removeElement(questionId)">
		<br>
		<br>
	
	<span id="questions">&nbsp;</span>
		</form>
	--%>
	

</body>
</html>