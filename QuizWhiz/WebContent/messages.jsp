<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*, quizzes.*, users.*, main.*, messages.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Messages</title>
<%@include file="navigation-bar.jsp" %>

</head>
<body>


<div class="container-fluid"><ul class="list-group">
	<% for(int i= 0; i < messages.size(); i++){ 
			if(!messages.get(i).isUnread()){ %>
				<li class="list-group-item">
					<h2><i><%=messages.get(i).getTitle() %> - <%=messages.get(i).getSender()%></i></h2>
					<p><i><%= messages.get(i).getBody() %></i></p>
				</li>
			<% } else if(messages.get(i).getType().equals("NOTE")){%>
				<li class="list-group-item" style="background-color: #CFF0FE">
					<h2><%=messages.get(i).getTitle() %><i> - <%=messages.get(i).getSender() %></i></h2>
					<p><%= messages.get(i).getBody() %></p>			
					<form action="MessageServlet" method="post" id="message">
						<input type="hidden" name="messageId" value="<%= messages.get(i).getId()%>">
						<input type="hidden" name="note">
						<a class="btn btn-default" href="create-message.jsp?replyTo=<%=messages.get(i).getSender()%>">Reply</a>	
						<button class="btn btn-default"type="submit" value="note">Mark as read</button>				
					</form><br>
				</li>
		<%} else { %>
		<li class="list-group-item" style="background-color: #FECFCF">
			<h2>Quiz Challenge from <%=messages.get(i).getSender() %>!</h2>
			<p><%=messages.get(i).getSender() %> took the quiz, <%= quizManager.getQuiz(messages.get(i).getQuizId()).getQuizName()%>, and got a <%=messages.get(i).getScore() %>. Can you beat that score?</p>			
			<form action="MessageServlet" method="post">
				<input type="hidden" name="messageId" value="<%= messages.get(i).getId()%>">
				<input type="hidden" name="quizId" value="<%= messages.get(i).getQuizId()%>">		
				<input type="hidden" name="challenge">
				<button class="btn btn-default" type="submit" value="challenge">Accept Challenge</button>
				<button class="btn btn-default" type="submit" value="challengeIgnore" name="challengeIgnore">Ignore Challenge</button>
				
			</form><br>
		</li>
		<%} %>
		<br>
	<%} %>

</ul>
</div>
</body>
</html>