<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="java.util.*, quizzes.*, users.*, main.*, messages.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Send Message</title>
<%@include file="navigation-bar.jsp" %>
</head>
<body>
	<%
		String username = request.getParameter("replyTo");
		if(username == null) username = "";
		if (user != null) {
			friendsNames = userManager.getFriends(user.getUsername());
		}
	%>
	
<div class="container">
	<form action="MessageServlet" method="post">
		<div class="form-group">
			<label >Send to</label> <input
				type="test" class="form-control" name="username"
				placeholder="Username" value="<%=username %>" >
		</div>
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
		<input type="hidden" name="sendNote" value="<%=user.getUsername()%>">
		<button type="submit" class="btn btn-default" value="send">Submit</button>
	</form>
	</div>
</body>
</html>