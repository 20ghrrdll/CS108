<!-- TODO: how to ensure that user isn't null -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*, quizzes.*, users.*, main.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%
String username = request.getParameter("username");
User currentUser = (User) session.getAttribute("currentUser");
QuizManager quizManager = (QuizManager) request.getServletContext().getAttribute("quizManager");
UserManager userManager = (UserManager) request.getServletContext().getAttribute("userManager");
%>
<title><% out.print(username); %>'s Profile</title>
<link type="text/css" rel="stylesheet"
	href="${pageContext.request.contextPath}/style/index.css" />
<link rel="stylesheet" href="http://www.w3schools.com/lib/w3.css">
<link rel="stylesheet"
	href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.4.0/css/font-awesome.min.css">
<link rel="stylesheet"
	href="http://www.w3schools.com/lib/w3-theme-indigo.css">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
      rel="stylesheet">
      </head>
<body class="w3-theme-light standards">

<h1 class="center-title w3-theme"><% out.println(username); %></h1>

<center>
<%
if (!currentUser.getUsername().equals(username)) {
	Set<String> currentUserFriends = userManager.getFriends(currentUser.getUsername());
	out.println("<table>");
	if (!currentUserFriends.contains(username)) {
%>
		<a href="#"><td><center><i class="material-icons">add</i>
		<br>Add Friend</center></td></a>
<%
	} %>
	<a href="#"><td><center><i class="material-icons">email</i>
	<br>Message</center></td></a>
	</table>
<% 	
}
%>
</center>


<h2 class="center-title w3-theme">Achievements</h2>
<%
Set<Achievement> userAchievements = userManager.getAchievements(username);
if (userAchievements.size() == 0) { %>
	<h4>No achievements to display.</h4>
<% } else {
	Iterator<Achievement> achievementsIt = userAchievements.iterator();
	while (achievementsIt.hasNext()) {
		Achievement a = achievementsIt.next();
		%>
		<div class="w3-tooltip">
			<b><% out.print(a.getName()); %>:</b><br>
			<% out.println(a.getDescription()); %>
			<img src="<% out.print(a.getImageUrl()); %>">
		</div>
	<% 
	}
}
%>



<h2 class="center-title w3-theme">Recent Performance</h2>
<ol class="w3-ul w3-hoverable">
<%
ArrayList<Quiz> quizzesTaken = quizManager.getMyRecentlyTakenQuizzes(username);
if (quizzesTaken.size() == 0) { %>
<h4>No recent activity to display.</h4>
<% 	
} else {
	for (int i = 0; i < quizzesTaken.size() && i < 5; i++) {
	%>
		<li><a
			<% String id = String.valueOf(quizzesTaken.get(i).getQuizID()); %>
				href="quiz-summary-page.jsp?id=<%=id%>" STYLE="text-decoration:none">
				<h4><%= quizzesTaken.get(i).getQuizName()%></h4>
				<p><%= quizzesTaken.get(i).getQuizDescription() %></p>
		</a></li>
<% 
	}
}
%>
</ol>



<h2 class="center-title w3-theme">Quizzes Created</h2>
<ol class="w3-ul w3-hoverable">
<%
ArrayList<Quiz> quizzesCreated = quizManager.getMyQuizzes(username);
if (quizzesCreated.size() == 0) { %>
	<h4>No quizzes created.</h4>
<% 
} else {
	for (int i = 0; i < quizzesCreated.size(); i++) {
	%>
		<li><a
			<% String id = String.valueOf(quizzesCreated.get(i).getQuizID()); %>
				href="quiz-summary-page.jsp?id=<%=id%>" STYLE="text-decoration:none">
				<h4><%= quizzesCreated.get(i).getQuizName()%></h4>
				<p><%= quizzesCreated.get(i).getQuizDescription() %></p>
		</a></li>
<% 
	}
}
%>
</ol>

</body>
</html>