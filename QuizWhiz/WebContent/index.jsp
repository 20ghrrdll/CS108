<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*, quizzes.*, users.*, main.*, messages.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Homepage</title>
<link type="text/css" rel="stylesheet"
	href="${pageContext.request.contextPath}/style/index.css" />
<link rel="stylesheet" href="http://www.w3schools.com/lib/w3.css">
<link rel="stylesheet"
	href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.4.0/css/font-awesome.min.css">
<link rel="stylesheet"
	href="http://www.w3schools.com/lib/w3-theme-indigo.css">
<script type="text/javascript"
	src="${pageContext.request.contextPath}/javascript/homepage.js"></script>

<%
User user = (User) session.getAttribute("currentUser");
AnnouncementManager announcementManager = (AnnouncementManager) request.getServletContext().getAttribute("announcementManager");
ArrayList<Announcement> announcements = announcementManager.getAnnouncements();

QuizManager quizManager = (QuizManager) request.getServletContext().getAttribute("quizManager");
UserManager userManager =(UserManager) request.getServletContext().getAttribute("userManager");
MessageManager messageManager = (MessageManager) request.getServletContext().getAttribute("messageManager");

ArrayList<Quiz> popularQuizzes = quizManager.getPopularQuizzes();
ArrayList<Quiz> recentQuizzes = quizManager.getRecentlyCreatedQuizzes();
ArrayList<Quiz> recentlyTakenQuizzes = quizManager.getRecentlyTakenQuizzes();
ArrayList<Quiz> myQuizzes = new ArrayList<Quiz>();
ArrayList<Message> unreadMessages = new ArrayList<Message>();
Set<Achievement> myAchievements;
Set<User> friends;
if(user != null){
	String userName = user.getUsername();
	myQuizzes = quizManager.getMyQuizzes(userName);
	myAchievements = userManager.getAchievements(user.getUsername());
	unreadMessages = messageManager.getMessages(user.getUsername(), true);
}

%>
</head>
<body class="w3-theme-light standards">
	<ul class="w3-navbar w3-theme-dark w3-border">
		<% if(user != null) { %>
		<li><a href="index.jsp?">QuizWhiz!
		</a></li>
		<% } else {
				response.sendRedirect("login-page.jsp?");
		}%>
		<ul class="w3-right">
			<li><a href="friends.jsp">Friends</a></li>
			<li><a href="messages.jsp?">Messages<%if(unreadMessages.size()>0){%><span class="w3-badge w3-green"><%=unreadMessages.size() %></span><%}%></a></li>
			<li class="w3-dropdown-hover"><a href="#">Settings</a>
				<div class="w3-dropdown-content w3-white w3-card-4">
					<a href="#">Privacy Options</a>
					<form action="LogoutServlet" method="post" id="settings">
					<a href="#" onclick="document.getElementById('settings').submit()">Log out</a>
					</form>
				</div></li>
			<li><a href="#">Achievements</a></li>
		</ul>
	</ul>
		<div class="w3-row">
		<div class="w3-col" style="width:20%">
		<% if(user != null) { %>
			<h1 class="centerTitle"><%=user.getUsername() %></h1>
			<ul>
				<li>Date joined: <%=user.getJoinDate() %></li>
				<li>Number of quizzes made: <%=myQuizzes.size() %></li>
			</ul>
		<% }%>
		
		</div>
	
	<div class="w3-col" style="width:80%">
		<h1 id="announcement" class="center-title w3-theme">Announcements</h1>
			<ul class="w3-ul w3-hoverable">
				<%
		for(int i = 0; i < announcements.size(); i++){
			%>
				<li>
					<h3><%= announcements.get(i).getSubject() %></h3>
					<p><%= announcements.get(i).getBody() %></p>

				</li>

				<%
		}
		
		%>
			</ul>
		</div>
	</div>
	</div>
	<div class="w3-row">
		<div class="w3-container w3-half">

			<h1 class="center-title w3-theme">Popular Quizzes</h1>

			<ol class="w3-ul w3-hoverable">
				<%
		for(int i = 0; i < popularQuizzes.size() && i < 5; i++){
			%>
				<li><a
				<% String id = String.valueOf(popularQuizzes.get(i).getQuizID()); %>
					href="quiz-summary-page.jsp?id=<%=id%>" STYLE="text-decoration:none">
						<h4><%= popularQuizzes.get(i).getQuizName()%></h4>
						<p><%= popularQuizzes.get(i).getQuizDescription() %></p>
				</a></li>
				<%
		}
		%>
			</ol>
		</div>
		  <div class="w3-container w3-half">
		
		<h1 class="center-title w3-theme "> Recently Created</h1>
		<ol class="w3-ul w3-hoverable">
		<%
		for(int i = 0; i < recentQuizzes.size() && i < 5; i++){
			%>
			<li>
			<h4><%= recentQuizzes.get(i).getQuizName() %></h4>
			<p><%= recentQuizzes.get(i).getQuizDescription() %></p>	
			</li> 
			
			<%
		}
		
		%>
		</ol>
		
		</div>
	</div>
	<div class="w3-row">
		<div class="w3-container w3-half">

			<h1 class="center-title w3-theme">Recently Taken</h1>
			<ol class="w3-ul w3-hoverable">
		<%
		for(int i = 0; i < recentlyTakenQuizzes.size() && i < 5; i++){
			%>
			<li>
			<h4><%= recentlyTakenQuizzes.get(i).getQuizName() %></h4>
			<p><%= recentlyTakenQuizzes.get(i).getQuizDescription() %></p>	
			</li> 
			
			<%
		}
		
		%>
		</ol>
		</div>
		<div class="w3-container w3-half">

			<h1 class="center-title w3-theme">My Quizzes</h1>
			<ol class="w3-ul w3-hoverable">
		<%
		for(int i = 0; i < myQuizzes.size() && i < 5; i++){
			%>
			<li>
			<h4><%= myQuizzes.get(i).getQuizName() %></h4>
			<p><%= myQuizzes.get(i).getQuizDescription() %></p>	
			</li> 
			
			<%
		}
		
		%>
		</ol>
		</div>
	</div>
	<h1 class="center-title w3-theme">Friend Activities</h1>
</body>
</html>