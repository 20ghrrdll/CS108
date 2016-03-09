<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*, quizzes.*, users.*, main.*, messages.*, administration.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<link href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
<script type="${pageContext.request.contextPath}/text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Admin Portal</title>
<link type="text/css" rel="stylesheet"
	href="${pageContext.request.contextPath}/style/index.css" />
<script type="text/javascript"
	src="${pageContext.request.contextPath}/javascript/homepage.js"></script>
	<link href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
<script type="${pageContext.request.contextPath}/text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
</head>
<body>

<% 
User user = (User) session.getAttribute("currentUser");
AnnouncementManager announcementManager = (AnnouncementManager) request.getServletContext().getAttribute("announcementManager");
ArrayList<Announcement> announcements = announcementManager.getAnnouncements();

QuizManager quizManager = (QuizManager) request.getServletContext().getAttribute("quizManager");
UserManager userManager =(UserManager) request.getServletContext().getAttribute("userManager");
MessageManager messageManager = (MessageManager) request.getServletContext().getAttribute("messageManager");
AdminManager adminManager = (AdminManager) request.getServletContext().getAttribute("adminManager");

ArrayList<Quiz> myQuizzes = new ArrayList<Quiz>();
ArrayList<Message> unreadMessages = new ArrayList<Message>();
Set<Achievement> myAchievements;
Set<User> friends;
if(user != null){
	myQuizzes = quizManager.getMyQuizzes(user.getUsername());
	myAchievements = userManager.getAchievements(user.getUsername());
	unreadMessages = messageManager.getMessages(user.getUsername(), true);
} else if (user == null) {
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
		<% if (userManager.isAdmin(user.getUsername())) { %>
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
	<h1>Site Statistics</h1>
	<div class="row">
		<div class="col-xs-6 col-sm-3" style="text-align: center">
		<h3><% out.print(adminManager.getNumUsers()); %><br>
		Users</h3></div>
		<div class="col-xs-6 col-sm-3" style="text-align: center">
		<h3><% out.print(adminManager.getNumQuizzesCreated()); %><br>
		Quizzes Created</h3></div>
		<div class="col-xs-6 col-sm-3" style="text-align: center">
		<h3><% out.print(adminManager.getNumQuizzesTaken()); %><br>
		Quizzes Taken</h3></div>
	</div>
</div>

<br><br>
<div class="container-fluid">
<h1>Administrative Functions</h1>

  <div class="panel panel-default">
    <div class="panel-heading" >
      <h4 class="panel-title">
          Create Announcements
      </h4>
    </div>
      <div class="panel-body">
		<form action="AnnouncementCreationServlet" method="post">
		    <% if("empty".equals(request.getParameter("invalidAnnouncement"))) { %>
			<div class="alert alert-danger" role="alert">
				<strong>Empty Field </strong> Please enter a subject and body.
			</div>
			<% } %>
			<div class="form-group">
				<label>Subject</label> <input
					type="test" class="form-control" name="subject"
						placeholder="Subject" >
			</div>
			<div class="form-group">
				<label for="exampleInputEmail1">Body</label>
				<textarea class="form-control" rows="3" placeholder="Announcement..." name="body"></textarea>
			</div>
			<input type="hidden" name="creator" value="Max">
			<button type="submit" class="btn btn-default">Create</button>
		</form>
      </div>
  </div>
  
  <div class="panel panel-default">
    <div class="panel-heading" role="tab" id="headingTwo">
      <h4 class="panel-title">
			Quick Edit Users
      </h4>
    </div>
      <div class="panel-body">
      	Enter usernames (one per line) to modify.<br>
		<form action="EditUserServlet" method="post">
			<% if("empty".equals(request.getParameter("invalidUsers"))) { %>
			<div class="alert alert-danger" role="alert">
				<strong>Empty Field </strong> Please enter at least one user.
			</div>
			<% } %>
			<div class="form-group">
				<textarea class="form-control" rows="4" name="usernames"></textarea>
			</div>
			<button type="submit" class="btn btn-default" name="buttonAction" value="delete">Delete</button>
			<button type="submit" class="btn btn-default" name="buttonAction" value="admin">Make Admin</button>
		</form>
      </div>
  </div>
  
  <div class="panel panel-default">
    <div class="panel-heading" role="tab" id="headingThree">
      <h4 class="panel-title">
          Quick Edit Quizzes
      </h4>
    </div>
      <div class="panel-body">
		Enter quiz IDs (one per line and should be numbers) to modify.<br>
		<form action="EditQuizServlet" method="post">
			<% if("empty".equals(request.getParameter("invalidQuizzes"))) { %>
			<div class="alert alert-danger" role="alert">
				<strong>Empty Field </strong> Please enter at least one quiz ID.
			</div>
			<% } %>
			<div class="form-group">
				<textarea class="form-control" rows="4" name="quizIDs"></textarea>
			</div>
			<button type="submit" class="btn btn-default" name="buttonAction" value="delete">Delete</button>
			<button type="submit" class="btn btn-default" name="buttonAction" value="clearHistory">Clear History</button>
		</form>
      </div>
  </div>
</div>



</body>
</html>