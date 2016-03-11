<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*, quizzes.*, users.*, main.*, messages.*, administration.*, quizExtras.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <link type="text/css" rel="stylesheet"
  	href="${pageContext.request.contextPath}/style/index.css" />
  <link href="http://code.jquery.com/ui/1.10.4/themes/ui-lightness/jquery-ui.css" rel="stylesheet">
  <link href="https://fonts.googleapis.com/icon?family=Material+Icons"
      rel="stylesheet">	
  	<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<!--  <script
 	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script> -->
 <!-- Include all compiled plugins (below), or include individual files as needed -->
 <script
 	src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js"></script>
 <link
 	href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css"
 	rel="stylesheet" type="text/css" />
 	<link
 	href="${pageContext.request.contextPath}/style/bootstrapOverride.css"
 	rel="stylesheet" type="text/css" />
  <script type="text/javascript"
  	src="${pageContext.request.contextPath}/javascript/homepage.js"></script>
</head>
<body>

<% 
User user = (User) session.getAttribute("currentUser");
if(user == null){
	response.sendRedirect("login-page.jsp?");
	return;
}
QuizManager quizManager = (QuizManager) request.getServletContext().getAttribute("quizManager");
UserManager userManager = (UserManager) request.getServletContext().getAttribute("userManager");
MessageManager messageManager = (MessageManager) request.getServletContext().getAttribute("messageManager");
AnnouncementManager announcementManager = (AnnouncementManager) request.getServletContext().getAttribute("announcementManager");
AdminManager adminManager = (AdminManager) request.getServletContext().getAttribute("adminManager");

ArrayList<Quiz> myQuizzes = new ArrayList<Quiz>();
ArrayList<Message> unreadMessages = new ArrayList<Message>();
ArrayList<Message> messages = new ArrayList<Message>();

ArrayList<String> myAchievements = new ArrayList<String>();
Set<String> friendsNames = new HashSet<String>();
ArrayList<String> requests = new ArrayList<String>();
ArrayList<RecentActivity> recentActivity = new ArrayList<RecentActivity>();
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

<nav class="navbar navbar-default" style="background-color: #40D851; background-image: none;">
  <div class="container-fluid" style="background-color: #40D851; background-image: none; color: #fff">
    <!-- Brand and toggle get grouped for better mobile display -->
    <div class="navbar-header" style="background-color: #40D851; background-image;">
      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <a class="navbar-brand" href="index.jsp?" style="color: #fff">Quiz Whiz</a>
    </div>

    <!-- Collect the nav links, forms, and other content for toggling -->
    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1" style="background-color: #40D851l; background-image: none;">
      <ul class="nav navbar-nav" style="background-color: #40D851; background-image: none; color: #fff">
        <li><a href="friends.jsp?" style="color: #fff">Friends <%
				if (requests.size() > 0) {
			%><span
					class="badge" style="background-color: #fff; background-image: none; color: #333"><%=requests.size()%></span>
					<%
						}
					%></a></li>
        <li><a href="messages.jsp?" style="color: #fff">Messages <%
				if (unreadMessages.size() > 0) {
			%><span
					class="badge" style="background-color: #fff; color: #333"><%=unreadMessages.size()%></span>
					<%
						}
					%></a></li>
			<% 	if (userManager.isAdmin(user.getUsername())) { %>
				<li><a href="admin-page.jsp?" style="color: #fff">Admin Portal</a></li>
			<% } %>
			
		<li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false" style="background-color: #40D851; background-image: none; color: #fff">Quizzes <span class="caret"></span></a>
          <ul class="dropdown-menu">
            <% for (int i = 0; i < FinalConstants.CATEGORIES.length; i++) {%>
            	<li><a href="show-quizzes.jsp?category=<%=FinalConstants.CATEGORIES[i] %>"><%=FinalConstants.CATEGORIES_PLAINTEXT.get(FinalConstants.CATEGORIES[i]) %></a></li>
           	<% } %>
           	<li><a href="show-quizzes.jsp?category=ALL">Show All</a>
          </ul>
        </li>
      </ul>
      
      
      <form action="LogoutServlet" method="post" id="logout" type="hidden"></form>
      <ul class="nav navbar-nav navbar-right" style="background-color: #40D851; background-image: none;">
        <li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false" style="background-color: #40D851; background-image: none; color: #fff">Settings <span class="caret"></span></a>
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