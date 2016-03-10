<!-- TODO: how to ensure that user isn't null -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*, quizzes.*, users.*, main.*, messages.*, administration.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="navigation-bar.jsp" %>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<%
//User user = (User) session.getAttribute("currentUser");
//UserManager userManager = (UserManager) request.getServletContext().getAttribute("userManager");
if(user == null){
	response.sendRedirect("login-page.jsp?");
	return;
}
String usernameToView = request.getParameter("username");
if (userManager.getUser(usernameToView) == null) { %>
	<div class="alert alert-danger">
	  <strong>Error!</strong> <%=usernameToView %> does not exist.
	</div>
<% } else {

requests = userManager.getSentRequests(user.getUsername());
System.out.println(requests.toString());
%>

<title><% out.print(usernameToView); %>'s Profile</title>
</head>
<body>

<% if(userManager.getUser(usernameToView) == null) { %> 
<div class="alert alert-danger">
  <strong>Error!</strong> User does not exist.
</div>
<% } else { %>

<div class="container-fluid">
<div class="row"><div class="col-md-5"><div class="panel panel-default">
<div class="panel-heading"><h1><% out.println(usernameToView); %></h1></div>
<div class="panel-body" style="text-align: center">
	<% if (!user.getUsername().equals(usernameToView)) {
		Set<String> currentUserFriends = userManager.getFriends(user.getUsername());
		if (!currentUserFriends.contains(usernameToView.toLowerCase())) {
			if(!requests.contains(usernameToView.toLowerCase())){
	%>
			<form action="FriendRequestServlet" method="post">
				<input type="hidden" name="user1" value="<%= user.getUsername() %>">
				<input type="hidden" name="user2" value="<%= usernameToView %>">
				<div class="col-md-3" style="float: left">
					<button type="submit" class="btn btn-link" name="buttonAction" value="delete">
						<i class="material-icons">add</i>
						<br>Add Friend
					</button>
				</div>
			</form>
	<%} else {%>
		<div class="col-md-3" style="float: left">
					<button type="submit" class="btn btn-link disabled" name="buttonAction" value="delete">
						<i class="material-icons">add</i>
						<br><i>Request Sent</i>
					</button>
				</div>
	<% }
		} %>
		
<%-- 		<form action="MessageServlet" method="post" id="message">
			<input type="hidden" name="note">
			<input type="hidden" name="senderId" value="<%=user.getUsername()%>"> --%>
			<div class="col-md-3" style="float: left">
				<a class="btn btn-link" name="buttonAction" value="delete"  href="create-message.jsp?replyTo=<%=usernameToView%>">
					<i class="material-icons">email</i>
					<br>Message
				</a>	
			</div>	
		<!-- </form> -->
		
		<% if (userManager.isAdmin(user.getUsername())) { %>
			<form action="EditUserServlet" method="post">
				<input type="hidden" name="usernames" value="<% out.print(usernameToView); %>">
					<div class="col-md-3" style="float: left">
						<button type="submit" class="btn btn-link" name="buttonAction" value="delete">
							<i class="material-icons">delete</i>
							<br>Delete
						</button>
					</div>
					<div class="col-md-3" style="float: left">
						<button type="submit" class="btn btn-link" name="buttonAction" value="admin">
							<i class="material-icons">grade</i>
							<br>Make Admin</button>
					</div>
			</form>
		<% } %>
	
	<% 	
	}
	%>
</div></div></div></div>

<div class="row"><div class="col-md-12">
<div class="panel panel-default">
<div class="panel-heading"><h1 class="panel-title">Achievements</h1></div>
<div class="panel-body">
<%
ArrayList<String> userAchievements = userManager.getAchievements(usernameToView);
if (userAchievements.size() == 0) { %>
	<h4>No achievements to display.</h4>
<% } else {
		for (int i = 0; i < userAchievements.size(); i++) {
			Achievement a = FinalConstants.ACHIEVEMENTS.get(userAchievements.get(i));
		%>
	  		<div class="col-md-2" style="float: left"><div class="thumbnail">
				<img src="<% out.print(a.getImageUrl()); %>">
			    <div class="caption" style="text-align: center">
			    	<h3><% out.print(a.getName()); %></h3>
			        <p><% out.println(a.getDescription()); %></p>
			    </div>
			</div></div>
		<% 
		} 
	}
%>
</div></div>
</div></div>


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
</div>
<% } %>
</body>

</html>