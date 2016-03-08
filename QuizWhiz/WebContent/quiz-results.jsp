<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*, quizzes.*, users.*, main.*, messages.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js"></script>
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/style/results.css" />
<link
	href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css"
	rel="stylesheet" type="text/css" />
<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<title>Results</title>
</head>
<body>

	<h1 class="text-center">Results:</h1>
	<h4 class="text-center">
		<%
			System.out.println(session.getAttribute("currQuizId"));
			int id = (Integer)session.getAttribute("currQuizId");
			User user = (User) session.getAttribute("currentUser");
		if(user != null){
			out.print(user.getUsername());
		}
		else{
			out.print("Test User");
		}
		%>, you scored
		<%
			out.print(session.getAttribute("score"));
		%>/<%
			out.print(session.getAttribute("maxScore"));
		%>
		 points.
	</h4>

		<div class="wrapper">
			<button class="btn btn-default">Return to Quiz Summary</button>
		</div>
		
		<script>
			$("button").click(function(){
				window.location.href = "quiz-summary-page.jsp?id=<%=id%>";
			});
		</script>


</body>
</html>