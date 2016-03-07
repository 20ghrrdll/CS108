<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="java.util.*, quizzes.*, users.*, main.*, messages.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Send Message</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
<script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js"></script>
<link
	href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css"
	rel="stylesheet" type="text/css" />
</head>
<body>
	<%
		User user = (User) session.getAttribute("currentUser");
		if(user == null)
			response.sendRedirect("login-page.jsp?");
		String username = request.getParameter("replyTo");
		if(username == null)
			username = "";
		String disabled = "";
		UserManager userManager = (UserManager) request.getServletContext().getAttribute("userManager");
		MessageManager messageManager = (MessageManager) request.getServletContext().getAttribute("messageManager");
		ArrayList<Message> messages = new ArrayList<Message>();
		ArrayList<Message> unreadMessages = new ArrayList<Message>();
		Set<String> friends = new HashSet<String>();
		if (user != null) {
			messages = messageManager.getMessages(user.getUsername(), false);
			unreadMessages = messageManager.getMessages(user.getUsername(), true);
			friends = userManager.getFriends(user.getUsername());
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
<div>
	<form action="MessageServlet" method="post">
		<div class="form-group">
			<label >Send to</label> <input
				type="test" class="form-control" name="username"
				placeholder="Username" value="<%=username %>" >
		</div>
		<% if(!friends.contains(username)) { disabled = "disabled"; %>
		<div class="alert alert-danger">
  			<strong>Oops!</strong> Looks like this user isnt one of your friends
		</div>
		<%} %>
		<div class="form-group">
			<label for="exampleInputEmail1">Subject</label> <input
				type="test" class="form-control" name="subject"
				placeholder="Subject">
		</div>
		<div class="form=group">
			<label for="exampleInputEmail1">Body</label>
			<textarea class="form-control" rows="3" placeholder="message..." name="body"></textarea>
		</div>
		<input type="hidden" name="senderId" value="<%=user.getUsername()%>">
		<button type="submit" class="btn btn-default <%=disabled %>" value="send">Submit</button>
	</form>
	</div>
</body>
</html>