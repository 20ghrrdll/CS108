<!-- TODO: how to ensure that user isn't null -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*, quizzes.*, users.*, main.*, messages.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%
String username = request.getParameter("username");
User currentUser = (User) session.getAttribute("currentUser");
QuizManager quizManager = (QuizManager) request.getServletContext().getAttribute("quizManager");
UserManager userManager = (UserManager) request.getServletContext().getAttribute("userManager");
MessageManager messageManager = (MessageManager) request.getServletContext().getAttribute("messageManager");

ArrayList<Quiz> popularQuizzes = quizManager.getPopularQuizzes();
ArrayList<Quiz> recentQuizzes = quizManager.getRecentlyCreatedQuizzes();
ArrayList<Quiz> recentlyTakenQuizzes = quizManager.getRecentlyTakenQuizzes();
ArrayList<Quiz> myQuizzes = new ArrayList<Quiz>();
ArrayList<Message> unreadMessages = new ArrayList<Message>();
Set<Achievement> myAchievements;
Set<User> friends;
if(currentUser != null){
	myQuizzes = quizManager.getMyQuizzes(currentUser.getUsername());
	myAchievements = userManager.getAchievements(currentUser.getUsername());
	unreadMessages = messageManager.getMessages(currentUser.getUsername(), true);
}
%>
<title><% out.print(username); %>'s Profile</title>
<link type="text/css" rel="stylesheet"
	href="${pageContext.request.contextPath}/style/index.css" />
<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
      rel="stylesheet">
<link href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
<script type="${pageContext.request.contextPath}/text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
</head>
<body>

<nav class="navbar navbar-default">
  <div class="container-fluid">
    <!-- Brand and toggle get grouped for better mobile display -->
    <div class="navbar-header">
      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <a class="navbar-brand" href="index.jsp?">Quiz Whiz</a>
    </div>

    <!-- Collect the nav links, forms, and other content for toggling -->
    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
      <ul class="nav navbar-nav">
        <li><a href="friends.jsp?">Friends</a></li>
        <li><a href="messages.jsp?">Messages <%
				if (unreadMessages.size() > 0) {
			%><span
					class="badge"><%=unreadMessages.size()%></span>
					<%
						}
					%></a></li>
		<% System.out.println("checking admin for " + currentUser.getUsername() + ": " + userManager.isAdmin(currentUser.getUsername()));
			if (userManager.isAdmin(currentUser.getUsername())) { 
				System.out.println("is admin");%>
				<li><a href="admin-page.jsp?">Admin Portal</a></li>
			<% } %>
      </ul>
      <form action="LogoutServlet" method="post" id="logout" type="hidden"></form>
      <ul class="nav navbar-nav navbar-right">
        <li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Settings <span class="caret"></span></a>
          <ul class="dropdown-menu">
            <li><a href="#">Privacy</a></li>
            <li role="separator" class="divider"></li>
            <li><a onclick="document.getElementById('logout').submit()">Logout</a></li>
          </ul>
        </li>
      </ul>
    </div><!-- /.navbar-collapse -->
  </div><!-- /.container-fluid -->
</nav>


<div class="container-fluid">
<h1><% out.println(username); %></h1>

<center>
<%
if (!currentUser.getUsername().equals(username)) {
	Set<String> currentUserFriends = userManager.getFriends(currentUser.getUsername());
	out.println("<center><div class=\"row\">");
	if (!currentUserFriends.contains(username)) {
%>
		<a href="#"><div class="col-md-4"><center><i class="material-icons">add</i>
		<br>Add Friend</center></div></a>
<%
	} %>
	<a href="#"><div class="col-md-4"><center><i class="material-icons">email</i>
	<br>Message</center></div></a>
	</div></center>
<% 	
}
%>
</center>
</div>

<div class="container-fluid">
<h2>Achievements</h2>
<%
Set<Achievement> userAchievements = userManager.getAchievements(username);
if (userAchievements.size() == 0) { %>
	<h4>No achievements to display.</h4>
	<div style="position: relative">
<% } else {
	Iterator<Achievement> achievementsIt = userAchievements.iterator();
	while (achievementsIt.hasNext()) {
		Achievement a = achievementsIt.next();
		%>
		<img src="<% out.print(a.getImageUrl()); %>" 
			data-toggle="tool-tip" data-placement="bottom" 
			title="<% out.print(a.getName()); %>: <% out.println(a.getDescription()); %>">
	<% 
	} %>
	</div>
<% 
}
%>
</div>


<div class="container-fluid">
<h2>Recent Performance</h2>
<ol>
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
</div>

<div class="container-fluid">
<h2>Quizzes Created</h2>
<ol>
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
</ol></div>

</body>

<script type="text/javascript">
$(document).ready(function(){
    $('[data-toggle="tooltip"]').tooltip();   
});
</script>

</html>