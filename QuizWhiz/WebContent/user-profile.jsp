<!-- TODO: how to ensure that user isn't null -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*, quizzes.*, users.*, main.*, messages.*, administration.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%
String usernameToView = request.getParameter("username");
%>

<%@include file="navigation-bar.jsp" %>

<title><% out.print(usernameToView); %>'s Profile</title>
</head>
<body>



<div class="container-fluid">
<div class="row"><div class="col-md-5"><div class="panel panel-default">
<div class="panel-heading"><h1><% out.println(usernameToView); %></h1></div>
<div class="panel-body" style="text-align: center">
	<% if (!user.getUsername().equals(usernameToView)) {
		Set<String> currentUserFriends = userManager.getFriends(user.getUsername());
		out.println("<div class=\"row\" style=\"text-align: center\">");
		if (!currentUserFriends.contains(usernameToView)) {
	%>
			<a href="#"><div class="col-md-3"><center><i class="material-icons">add</i>
			<br>Add Friend</center></div></a>
	<%
		} %>
		<a href="#"><div class="col-md-3"><center><i class="material-icons">email</i>
		<br>Message</center></div></a></div>
		
		<% if (userManager.isAdmin(user.getUsername())) { %>
			
			<form action="EditUserServlet" method="post">
				<input type="hidden" name="usernames" value="<% out.print(usernameToView); %>">
				<center><div class="row" style="text-align: center">
					<div class="col-md-3">
						<button type="submit" class="btn btn-link" name="buttonAction" value="delete">
							<i class="material-icons">delete</i>
							<br>Delete
						</button>
					</div>
					<div class="col-md-3" style="text-align: center">
						<button type="submit" class="btn btn-link" name="buttonAction" value="admin">
							<i class="material-icons">grade</i>
							<br>Make Admin</button>
					</div>
				</div></center>
			</form>
		<% } %>
	
	<% 	
	}
	%>
</div></div></div></div></div>

<div class="container-fluid"><div class="row"><div class="col-md-12">
<div class="panel panel-default">
<div class="panel-heading"><h1 class="panel-title">Achievements</h1></div>
<div class="panel-body">
<%
ArrayList<String> userAchievements = userManager.getAchievements(usernameToView);
if (userAchievements.size() == 0) { %>
	<h4>No achievements to display.</h4>
	<div style="position: relative">
<% } else {
		Achievement a = FinalConstants.ACHIEVEMENTS.get(a);
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
</div></div>
</div></div></div>


<div class="container-fluid">
<div class="row">
<div class="col-md-6"><div class="panel panel-default">
<div class="panel-heading"><h1 class="panel-title">Quizzes Created</h1></div>
<div class="panel-body">
<ol>
<%
ArrayList<Quiz> quizzesCreated = quizManager.getMyQuizzes(usernameToView);
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
</div></div></div>

<div class="col-md-6"><div class="panel panel-default">
<div class="panel-heading"><h1 class="panel-title">Recent Performance</h1></div>
<div class="panel-body">
<ol>
<%
ArrayList<Quiz> quizzesTaken = quizManager.getMyRecentlyTakenQuizzes(usernameToView);
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
</div></div></div>
</div></div>

</body>

<script type="text/javascript">
$(document).ready(function(){
    $('[data-toggle="tooltip"]').tooltip();   
});
</script>

</html>