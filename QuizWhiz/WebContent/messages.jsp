<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*, quizzes.*, users.*, main.*, messages.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Messages</title>

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
MessageManager messageManager =(MessageManager) request.getServletContext().getAttribute("messageManager");

ArrayList<Message> messages = new ArrayList<Message>();
ArrayList<Message> unreadMessages = new ArrayList<Message>();
if(user!= null){
	messages = messageManager.getMessages(user.getUsername(), false);

	unreadMessages = messageManager.getMessages(user.getUsername(), true);
}

%>

<ul class="w3-navbar w3-theme-dark w3-border">
		<% if(user != null) { %>
		<li><a href="index.jsp?">QuizWhiz!
		</a></li>
		<% } else {
				response.sendRedirect("login-page.jsp?");
		}%>
		<ul class="w3-right">
			<li><a href="friends.jsp">Friends</a></li>
			<li><a href="messages.jsp">Messages<% if(unreadMessages.size() > 0) {%><span class="w3-badge w3-green"><%=unreadMessages.size()%></span><%}%></a></li>
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

<div>

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
			<form action="MessageServlet" method="post" id="message">
				<input type="hidden" name="messageId" value="<%= messages.get(i).getId()%>">
				<input type="hidden" name="note">
				<a class="w3-btn w3-white w3-border w3-round" href="create-message.jsp?replyTo=<%=messages.get(i).getSender()%>">Reply</a>	
				<button class="w3-btn w3-white w3-border w3-round "type="submit" value="note">Mark as read</button>				
			</form>
		</div>
		<%} else { %>
		<div class="w3-container w3-pale-red w3-leftbar w3-border-red">
			<h2><%=messages.get(i).getTitle() %><i> - <%=messages.get(i).getSender() %></i></h2>
			<p><%= messages.get(i).getBody() %></p>
			<form action="MessageServlet" method="post">
				<input type="hidden" name="messageId" value="<%= messages.get(i).getId()%>">
				<input type="hidden" name="quizId" value="<%= messages.get(i).getQuizId()%>">		
				<input type="hidden" name="challenge">
				<button class="w3-btn w3-white w3-border w3-round" type="submit" value="challenge">Accept Challenge</button>
			</form>
		</div>
		<%} %>
		<br>
		<%} %>
		</div>

</body>
</html>