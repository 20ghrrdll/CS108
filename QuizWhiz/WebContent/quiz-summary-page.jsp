<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*, quizzes.*, users.*, main.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Quiz Summary</title>
<link type="text/css" rel="stylesheet"
	href="${pageContext.request.contextPath}/style/index.css" />
<link rel="stylesheet" href="http://www.w3schools.com/lib/w3.css">
<link rel="stylesheet"
	href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.4.0/css/font-awesome.min.css">
<link rel="stylesheet"
	href="http://www.w3schools.com/lib/w3-theme-indigo.css">
</head>

<%
	QuizManager quizManager = (QuizManager) request.getServletContext().getAttribute("quizManager");
	Quiz quiz = quizManager.getQuiz(Integer.valueOf(request.getParameter("id")));
%>

<body class="w3-theme-light standards">

	<h1 class="center-title w3-theme">Quiz Description</h1>
		<p><%=quiz.getQuizDescription()%></p>
		<p><i> created by <a href="user-profile.jsp?username=<%=quiz.getQuizCreator() %>"> <%=quiz.getQuizCreator() %></a></i> </p>

</body>
</html>

