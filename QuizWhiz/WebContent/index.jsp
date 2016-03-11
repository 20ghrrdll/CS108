<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="java.util.*, quizzes.*, users.*, main.*, messages.*, administration.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Homepage</title>

<%@include file="navigation-bar.jsp"%>

</head>
<body class="standards">

<%
ArrayList<Announcement> announcements = announcementManager.getAnnouncements();
ArrayList<Quiz> popularQuizzes = quizManager.getPopularQuizzes();
ArrayList<Quiz> recentQuizzes = quizManager.getRecentlyCreatedQuizzes();
ArrayList<Quiz> recentlyTakenQuizzes = quizManager.getRecentlyTakenQuizzes();
if(user != null){
	myQuizzes = quizManager.getMyQuizzes(user.getUsername());
	myAchievements = userManager.getAchievements(user.getUsername());
	messages = messageManager.getMessages(user.getUsername(), false);
	unreadMessages = messageManager.getMessages(user.getUsername(), true);
	requests = userManager.getFriendRequests(user.getUsername());
	friendsNames = userManager.getFriends(user.getUsername());
	recentActivity = userManager.getRecentActivity(user.getUsername(), friendsNames);
}
%>

<% if(request.getParameter("error") != null) { %>
	<div class="alert alert-danger">
  		<strong>Error:</strong> <% out.print(FinalConstants.ERROR_MSG); %>
	</div>
<% } %>

	<div class="container-fluid">
		<div class="row">
			<div class="col-md-4">
				<div class="panel panel-default">
					<div class="panel-heading">
						<%
							if (user != null) {
						%>
						<h3 class="panel-title"><%=user.getUsername()%></h3>
						<%
							}
						%>
					</div>
					<div class="panel-body">
						<ul>
							<li>Date joined: <%=user.getJoinDate()%></li>
							<li>Number of quizzes made: <%=myQuizzes.size()%></li>
							<li>Number of Achievements: <%=myAchievements.size() %>
						</ul>
						<a class="btn btn-primary" href="make-quiz.jsp" role="button">Make
							Quiz</a>
						<a class="btn btn-primary" href="user-profile.jsp?username=<%=user.getUsername() %>" role="button">User Profile</a>
						<a class="btn btn-primary" href="quiz-history.jsp?username=<%=user.getUsername() %>" role="button">Quiz History</a>
						
					</div>
				</div>

			</div>
			<div class="col-md-8">
				<div class="panel panel-default">
					<div class="panel-heading">
						<h3 class="panel-title">Announcements</h3>
					</div>
					<div class="panel-body">
						<ul class="list-group">
							<%
								for (int i = 0; i < announcements.size(); i++) {
							%>
							<li class="list-group-item">
								<h3><%=announcements.get(i).getSubject()%></h3>
								<p><%=announcements.get(i).getBody()%></p>
								<% if (userManager.isAdmin(user.getUsername())) { %>
								<form action="EditAnnouncementServlet" method="post">
									<input type="hidden" name="announcementId" value="<%=announcements.get(i).getId() %>">
										<button type="submit" class="btn btn-danger" name="buttonAction" value="delete">Delete
										</button>
								</form>
							<% } %>
							</li>
							<%
								}
							%>
						</ul>
					</div>
				</div>
			</div>


		</div>
	</div>

	<div class="container-fluid">

	<div class="row">
		<div class="col-md-4"><div class="panel panel-default">
			<div class="panel-heading"><h1 class="panel-title">Popular Quizzes</h1></div>
			<div class="panel-body">
				<ol>
					<% for (int i = 0; i < popularQuizzes.size() && i < 5; i++) { %>
						<% if (!userManager.getAchievements(popularQuizzes.get(i).getQuizCreator()).contains(FinalConstants.POPULAR_QUIZ)) {
							userManager.addAchievement(popularQuizzes.get(i).getQuizCreator(), FinalConstants.POPULAR_QUIZ);
						} %> 
						
						<li><a
							<%String id = String.valueOf(popularQuizzes.get(i).getQuizID());%>
							href="quiz-summary-page.jsp?id=<%=id%>"
							STYLE="text-decoration: none">
								<h4><%=popularQuizzes.get(i).getQuizName()%></h4>
								<p><%=popularQuizzes.get(i).getQuizDescription()%></p>
						</a></li>
					<% } %>
				</ol>
			</div></div></div>
			
			
			
		<div class="col-md-4"><div class="panel panel-default">
			<div class="panel-heading"><h1 class="panel-title">Recently Created</h1></div>
			<div class="panel-body">
				<ol>
					<% for (int i = 0; i < recentQuizzes.size() && i < 5; i++) { %>
						<li><a
							<%String id = String.valueOf(recentQuizzes.get(i).getQuizID());%>
							href="quiz-summary-page.jsp?id=<%=id%>"
							STYLE="text-decoration: none">
							<h4><%=recentQuizzes.get(i).getQuizName()%></h4>
							<p><%=recentQuizzes.get(i).getQuizDescription()%></p>
							</a>
						</li>
					<% } %>
				</ol>
		</div></div></div>

		<div class="col-md-4"><div class="panel panel-default">
			<div class="panel-heading"><h1 class="panel-title">Recently Taken</h1></div>
			<div class="panel-body">
				<ol>
					<% for (int i = 0; i < recentlyTakenQuizzes.size() && i < 5; i++) { %>
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
	
	<div class="container-fluid">
	<div class="row">
	<div class="col-md-6"><div class="panel panel-default">
		<div class="panel-heading"><h1 class="panel-title">My Quizzes</h1></div>
		<div class="panel-body">
			<ol>

				<% 
					if (myQuizzes.size() == 0) {
						out.println("No quizzes created. ");
						out.println("<a href=\"make-quiz.jsp\">Make a quiz now!</a>");
					} else {
						for (int i = 0; i < myQuizzes.size() && i < 5; i++) { %>
						<li> <a
								<%String id = String.valueOf(popularQuizzes.get(i).getQuizID());%>
								href="quiz-summary-page.jsp?id=<%=id%>"
								STYLE="text-decoration: none">
							<h4><%=myQuizzes.get(i).getQuizName()%></h4>
							<p><%=myQuizzes.get(i).getQuizDescription()%></p>
							</a>
						</li>
					<% } 
					}%>
			</ol>
		</div>
	</div></div>
	
	<div class="col-md-6"><div class="panel panel-default">
		<div class="panel-heading"><h1 class="panel-title">Friend Activities</h1></div>
		<div class="panel-body">
		<% if(recentActivity.isEmpty()) { %>
		<p> Looks like you don't have any friends yet! <a href="friends.jsp?">Search for friends here</a></p>
		<%} else{ %>
			<ol>
				<% for (int i = 0; i < recentActivity.size() && i < 6; i++) { 
					 if(recentActivity.get(i).getType().equals("taken")){%>
					<li> <h4><%=recentActivity.get(i).getUserId() %> has taken a quiz called <%=quizManager.getQuiz(recentActivity.get(i).getQuizId()).getQuizName() %></h4>
					<a href="quiz-summary-page.jsp?id=<%=recentActivity.get(i).getQuizId()%>"
							style="text-decoration: none; display:inline" class="btn btn-default">
						Take this quiz!
						</a>
						<p style="padding-top:2px; float:right"><i>Taken on: <%=recentActivity.get(i).getDate()%></i></p>
					</li>
					<%} else {%>
					<li> <h4><%=recentActivity.get(i).getUserId() %> has created a quiz called <%=quizManager.getQuiz(recentActivity.get(i).getQuizId()).getQuizName() %></h4>
					<a href="quiz-summary-page.jsp?id=<%=recentActivity.get(i).getQuizId()%>"
							STYLE="text-decoration: none" class="btn btn-default">
						Take this Quiz!
						</a>
						<p style="padding-top:2px; float:right"><i>Created on: <%=recentActivity.get(i).getDate()%></i></p>		
					</li>
				<% } }%>
			</ol>
			<%} %>
		</div>
	</div>

</body>
</html>