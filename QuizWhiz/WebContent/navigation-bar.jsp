<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*, quizzes.*, users.*, main.*, messages.*, administration.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <link type="text/css" rel="stylesheet"
  	href="${pageContext.request.contextPath}/style/index.css" />
 <script
 	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
 <!-- Include all compiled plugins (below), or include individual files as needed -->
 <script
 	src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js"></script>
 <link
 	href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css"
 	rel="stylesheet" type="text/css" />
  <script type="text/javascript"
  	src="${pageContext.request.contextPath}/javascript/homepage.js"></script>
</head>
<body>

<% 
User user = (User) session.getAttribute("currentUser");
QuizManager quizManager = (QuizManager) request.getServletContext().getAttribute("quizManager");
UserManager userManager = (UserManager) request.getServletContext().getAttribute("userManager");
MessageManager messageManager = (MessageManager) request.getServletContext().getAttribute("messageManager");
AnnouncementManager announcementManager = (AnnouncementManager) request.getServletContext().getAttribute("announcementManager");
AdminManager adminManager = (AdminManager) request.getServletContext().getAttribute("adminManager");

ArrayList<Announcement> announcements = announcementManager.getAnnouncements();
ArrayList<Quiz> popularQuizzes = quizManager.getPopularQuizzes();
ArrayList<Quiz> recentQuizzes = quizManager.getRecentlyCreatedQuizzes();
ArrayList<Quiz> recentlyTakenQuizzes = quizManager.getRecentlyTakenQuizzes();
ArrayList<Quiz> myQuizzes = new ArrayList<Quiz>();
ArrayList<Message> unreadMessages = new ArrayList<Message>();
ArrayList<Message> messages = new ArrayList<Message>();

ArrayList<String> myAchievements;
Set<User> friends;
if(user != null){
	myQuizzes = quizManager.getMyQuizzes(user.getUsername());
	myAchievements = userManager.getAchievements(user.getUsername());
	messages = messageManager.getMessages(user.getUsername(), false);
	unreadMessages = messageManager.getMessages(user.getUsername(), true);
} else {
	response.sendRedirect("login-page.jsp?");
	return;
}
 %>

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
			<% 	if (userManager.isAdmin(user.getUsername())) { %>
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

</body>
</html>