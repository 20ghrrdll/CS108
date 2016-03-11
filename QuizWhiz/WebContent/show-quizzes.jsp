<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="java.util.*, quizzes.*, users.*, main.*, messages.*, administration.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Quizzes</title>

<%@include file="navigation-bar.jsp"%>

</head>
<body>

<% String category = request.getParameter("category");
ArrayList<Quiz> quizzesToDisplay = null;
if (category == null) {%>
	<div class="alert alert-danger">
  		<strong>Error:</strong> <% out.print(FinalConstants.ERROR_MSG); %>
	</div>
<%
} else if (category.equals("ALL")) { 
	quizzesToDisplay = quizManager.getAllQuizzes();
} else {
	quizzesToDisplay = quizManager.getCategorizedQuizzes(category);
}%>

<div class="container-fluid">

<div class="panel panel-default">
<div class="panel-heading"><%
if (category.equals("ALL")) {
	out.print("All Quizzes");
} else {
	out.print(FinalConstants.CATEGORIES_PLAINTEXT.get(category));
}%></div>

<div class="panel-body">
<% if (quizzesToDisplay.size() == 0) { %>
	No quizzes to display.
<% } else { %>
<div class="list-group">
 	<% for (int i = 0; i < quizzesToDisplay.size(); i++) { 
 			Quiz quiz = quizzesToDisplay.get(i); %>
 			<a href="quiz-summary-page.jsp?id=<%=quiz.getQuizID()%>" class="list-group-item"><b><%=quiz.getQuizName() %></b> by <%=quiz.getQuizCreator() %></a>
 	<% } %>
</div><% } %>
</div>

</div>
</div>

</body>
</html>