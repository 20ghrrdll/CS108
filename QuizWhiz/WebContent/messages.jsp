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


<div>
	<% for(int i= 0; i < messages.size(); i++){ 
			if(!messages.get(i).isUnread()){ %>
				<div class="container-fluid">
					<h2><i><%=messages.get(i).getTitle() %> - <%=messages.get(i).getSender()%></i></h2>
					<p><i><%= messages.get(i).getBody() %></i></p>
				</div>
			<% } else if(messages.get(i).getType().equals("NOTE")){%>
				<div class="container-fluid" style="background-color: #CFF0FE">
					<h2><%=messages.get(i).getTitle() %><i> - <%=messages.get(i).getSender() %></i></h2>
					<p><%= messages.get(i).getBody() %></p>			
					<form action="MessageServlet" method="post" id="message">
						<input type="hidden" name="messageId" value="<%= messages.get(i).getId()%>">
						<input type="hidden" name="note">
						<a class="btn btn-default" href="create-message.jsp?replyTo=<%=messages.get(i).getSender()%>">Reply</a>	
						<button class="btn btn-default"type="submit" value="note">Mark as read</button>				
					</form>
				</div>
		<%} else { %>
		<div class="container-fluid" style="background-color: #FECFCF">
			<h2><%=messages.get(i).getTitle() %><i> - <%=messages.get(i).getSender() %></i></h2>
			<p><%= messages.get(i).getBody() %></p>
			<form action="MessageServlet" method="post">
				<input type="hidden" name="messageId" value="<%= messages.get(i).getId()%>">
				<input type="hidden" name="quizId" value="<%= messages.get(i).getQuizId()%>">		
				<input type="hidden" name="challenge">
				<button class="btn btn-default" type="submit" value="challenge">Accept Challenge</button>
			</form>
		</div>
		<%} %>
		<br>
	<%} %>
</div>
</body>
</html>