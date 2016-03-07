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

		UserManager userManager = (UserManager) request.getServletContext().getAttribute("userManager");
		MessageManager messageManager = (MessageManager) request.getServletContext().getAttribute("messageManager");

		ArrayList<Message> messages = new ArrayList<Message>();
		ArrayList<Message> unreadMessages = new ArrayList<Message>();
		if (user != null) {
			messages = messageManager.getMessages(user.getUsername(), false);

			unreadMessages = messageManager.getMessages(user.getUsername(), true);
		}
	%>
<%-- 	<ul class="w3-navbar w3-theme-dark w3-border">
		<%
			if (user != null) {
		%>
		<li><a href="index.jsp?">QuizWhiz! </a></li>
		<%
			} else {
				response.sendRedirect("login-page.jsp?");
			}
		%>
		<ul class="w3-right">
			<li><a href="friends.jsp">Friends</a></li>
			<li><a href="messages.jsp">Messages<%
				if (unreadMessages.size() > 0) {
			%><span
					class="w3-badge w3-green"><%=unreadMessages.size()%></span>
					<%
						}
					%></a></li>
			<li class="w3-dropdown-hover"><a href="#">Settings</a>
				<div class="w3-dropdown-content w3-white w3-card-4">
					<a href="#">Privacy Options</a>
					<form action="LogoutServlet" method="post">
						<a href="#">Log out</a> <input type="submit" />
					</form>
				</div></li>
			<li><a href="#">Achievements</a></li>
		</ul>
	</ul> --%>
	
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
      <a class="navbar-brand" href="#">Quiz Whiz</a>
    </div>

    <!-- Collect the nav links, forms, and other content for toggling -->
    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
      <ul class="nav navbar-nav">
        <li><a href="friends.jsp?">Friends</li>
        <li class="active"><a href="messages.jsp?">Messages<%
				if (unreadMessages.size() > 0) {
			%><span
					class="badge"><%=unreadMessages.size()%></span>
					<%
						}
					%></a></li>
      </ul>
      
      <ul class="nav navbar-nav navbar-right">
        <li><a href="#">Link</a></li>
        <li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Settings <span class="caret"></span></a>
          <ul class="dropdown-menu">
            <li><a href="#">Privacy</a></li>
            <li role="separator" class="divider"></li>
            <li><form action="LogoutServlet" method="post">
						<a href="#">Log out</a><input type="submit" />
					</form></li>
          </ul>
        </li>
      </ul>
    </div><!-- /.navbar-collapse -->
  </div><!-- /.container-fluid -->
</nav>
<!-- 
	<form>
		<div class="form-group">
			<label for="exampleInputEmail1">Email address</label> <input
				type="email" class="form-control" id="exampleInputEmail1"
				placeholder="Email">
		</div>
		<textarea class="form-control" rows="3"></textarea>

		<button type="submit" class="btn btn-default">Submit</button>
	</form> -->
</body>
</html>