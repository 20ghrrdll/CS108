<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.util.*, quizzes.*, users.*, main.*, messages.*, administration.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Add Questions</title>

<script language="javascript">
function addQuestions() {
 	
    var div = document.createElement("p");

    //Create an input type dynamically.
    var element1 = document.createElement("input");
 	var element2 = document.createElement("input");
   
	var text1 = document.createTextNode("Question: ");
 	element1.setAttribute("type", "text");
    element1.setAttribute("name", "question");
    
    var text2 = document.createTextNode("Response: ");
    element2.setAttribute("type", "text");
    element2.setAttribute("name", "answer");    
    
    
    var br = document.createElement("BR");

    var questions = document.getElementById("questions");

    questions.appendChild(div);
    questions.appendChild(br);

    questions.appendChild(text1);
    questions.appendChild(element1);
    questions.appendChild(br);

    questions.appendChild(text2);
    questions.appendChild(element2); 
}
</script>

<%
//Quiz quiz = (Quiz) request.getAttribute("quiz");
//String quizName = quiz.getQuizName();
%>

</head>
<form action="AddQuestionsServlet" method="post">
<h2>Add Questions to</h2>
<p>Questions can have up to 4 correct answers</p>
<p>Separate answers with the | symbol</p>
<br/>

<input type="button" value="Add Question" onclick="addQuestions()"/>
<input type="submit" value = "Done" >

<span id="questions">&nbsp;</span>

 
</form>
</html>