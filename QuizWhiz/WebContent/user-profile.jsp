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
</head>
<body class="w3-theme-light standards">

<h1 class="center-title w3-theme"><% out.println(username); %></h1>

<!-- if not friends, add friend request and message buttons here -->

<h2>Achievements</h2>
<%
Set<Achievement> userAchievements = userManager.getAchievements(username);
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
%>

<h2>Recent Performance</h2>


<h2>Quizzes Created</h2>


</body>
</html>