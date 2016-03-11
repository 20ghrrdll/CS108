<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href=”bootstrap/css/bootstrap.min.css” rel=”stylesheet”
	type=”text/css” />
<script type=”text/javascript” src=”bootstrap/js/bootstrap.min.js”></script>
<title>Quiz History</title>
<%@include file="navigation-bar.jsp"%>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<!-- Include all compiled plugins (below), or include individual files as needed -->
<script src="bootstrap/js/bootstrap.min.js"></script>
<%

	ArrayList<Quiz> recentlyTakenQuizzes = quizManager.getMyRecentlyTakenQuizzes(user.getUsername());
%>
</head>
<body>

<div class="col-md-4"><div class="panel panel-default">
			<div class="panel-heading"><h1 class="panel-title">Full Quiz History</h1></div>
			<div class="panel-body">
				<ol>
					<% for (int i = 0; i < recentlyTakenQuizzes.size(); i++) { %>
						<li><a
							<%String id = String.valueOf(recentlyTakenQuizzes.get(i).getQuizID());%>
							href="quiz-summary-page.jsp?id=<%=id%>"
							STYLE="text-decoration: none">
							<h4><%=recentlyTakenQuizzes.get(i).getQuizName()%></h4>
							<p><%=recentlyTakenQuizzes.get(i).getQuizDescription()%></p>
							</a>
						</li>
					<% } %>
				</ol>
			</div>
		</div></div>
	</div></div>

</body>
</html>