<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*, quizzes.*, users.*, main.*, messages.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href=”bootstrap/css/bootstrap.min.css” rel=”stylesheet”
	type=”text/css” />
<script type=”text/javascript” src=”bootstrap/js/bootstrap.min.js”></script>
<title>Results</title>
</head>
<body>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script src="bootstrap/js/bootstrap.min.js"></script>

	<h1 class="text-center">Results:</h1>
	<h4 class="text-center">
		<%
			User user = (User) session.getAttribute("currentUser");
		if(user != null){
			out.print(user.getUsername());
		}
		else{
			out.print("Test User");
		}
		%>, You scored
		<%
			out.print(session.getAttribute("score"));
		%>/<%
			out.print(session.getAttribute("maxScore"));
		%>
	</h4>

	<form action="quiz-summary-page.jsp" method="post">
		<button type="submit">Return to Quiz Summary</button>
	</form>

</body>
</html>