<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*, quizzes.*, users.*, main.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

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
<body class="w3-theme-light standards">
<%
User user = (User) session.getAttribute("currentUser");

UserManager userManager =(UserManager) request.getServletContext().getAttribute("userManager");
ArrayList<Message> messages = userManager.getMessages(user.getUsername(), false);
ArrayList<Message> unreadMessages = userManager.getMessages(user.getUsername(), false);


%>

<ul class="w3-navbar w3-theme-dark w3-border">
		<% if(user != null) { %>
		<li><a href="index.jsp?">QuizWhiz!
		</a></li>
		<% } else {
				response.sendRedirect("login-page.jsp?");
		}%>
		<ul class="w3-right">
			<li><a href="#">Friends</a></li>
			<li><a href="#">Messages<span class="w3-badge w3-green"><%=unreadMessages.size()%></span></a></li>
			<li class="w3-dropdown-hover"><a href="#">Settings</a>
				<div class="w3-dropdown-content w3-white w3-card-4">
					<a href="#">Privacy Options</a>
					<form action="LogoutServlet" method="post">
					<a href="#">Log out</a>
					<input type="submit" /></form>
				</div></li>
			<li><a href="#">Achievements</a></li>
		</ul>
	</ul>
	
<nav class="w3-sidenav w3-light-grey w3-card-2" style="width:20%">
Message or challenge one of your friends!
<a class="w3-border-bottom" href="#">Link 1</a> 
  <a class="w3-border-bottom" href="#">Link 2</a> 
  <a href="#">Link 3</a> 
</nav>
<div style="margin-left:20%">

		<% for(int i= 0; i < messages.size(); i++){ 
			if(!messages.get(i).isUnread()){ %>
			<div class="w3-container">
			<h2><i><%=messages.get(i).getTitle() %> - <%=messages.get(i).getSender()%></i></h2>
			<p><i><%= messages.get(i).getBody() %></i></p>
		</div>
			<% } else if(messages.get(i).getType().equals("NOTE")){%>
		<div class="w3-container w3-pale-blue w3-leftbar w3-border-blue">
			<h2><%=messages.get(i).getTitle() %><i> - <%=messages.get(i).getSender() %></i></h2>
			<p><%= messages.get(i).getBody() %></p>
		</div>
		<%} else { %>
		<div class="w3-container w3-pale-red w3-leftbar w3-border-red">
			<h2><%=messages.get(i).getTitle() %><i> - <%=messages.get(i).getSender() %></i></h2>
			<p><%= messages.get(i).getBody() %></p>
			<button class="w3-btn w3-white w3-border w3-round">Accept Challenge</button>
		</div>
		<%} %>
		<br>
		<%} %>
		</div>

</body>
</html>