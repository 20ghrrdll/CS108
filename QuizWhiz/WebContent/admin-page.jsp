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
<link rel="stylesheet" href="http://www.w3schools.com/lib/w3.css">
<link rel="stylesheet"
	href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.4.0/css/font-awesome.min.css">
<link rel="stylesheet"
	href="http://www.w3schools.com/lib/w3-theme-indigo.css">
<script type="text/javascript"
	src="${pageContext.request.contextPath}/javascript/homepage.js"></script>
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
}
 %>
 
 <ul class="w3-navbar w3-theme-dark w3-border">
	<% 	if (user == null) {
			response.sendRedirect("login-page.jsp?");
		} else if (!userManager.isAdmin(user.getUsername())) {
			response.sendRedirect("index.jsp?"); 
		} else {
	%>
		<li><a href="index.jsp?">QuizWhiz!
		</a></li>
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
			<% if (userManager.isAdmin(user.getUsername())) { %>
				<li><a href="admin-page.jsp?">Admin Portal</a></li>
			<% } %>
		</ul>
	<% } %>
	</ul>

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
			Edit Users
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
          Edit Quizzes
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