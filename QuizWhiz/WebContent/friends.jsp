<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="java.util.*, quizzes.*, users.*, main.*, messages.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Friends</title>
<%@include file="navigation-bar.jsp" %>
</head>
<body>
<%
	Set<String> friendsNames = new HashSet<String>();
	Set<String> friendRequests = new HashSet<String>();

	if(user!= null){
		friendsNames = userManager.getFriends(user.getUsername());
		friendRequests = userManager.getFriendRequests(user.getUsername());
	}
%>

<%if(!friendRequests.isEmpty()) {%>
<div class="container-fluid"><div class="col-md-12"><div class="panel panel-default">
	<div class="panel-heading"><h1 class="panel-title">Friends</h1></div>
	<div class="panel-body">
	<ol><% for (String username : friendRequests) { %>
			<li><a href="user-profile.jsp?username=<%=username%>"
				STYLE="text-decoration: none">
					<h4><%=username%></h4>
			</a></li>
		<% } %>
	</ol>
	</div>
</div></div></div>
<%} %>
	
<div class="container-fluid"><div class="col-md-12"><div class="panel panel-default">
	<div class="panel-heading"><h1 class="panel-title">Friends</h1></div>
	<div class="panel-body">
	<ol><% for (String username : friendsNames) { %>
			<li><a href="user-profile.jsp?username=<%=username%>"
				STYLE="text-decoration: none">
					<h4><%=username%></h4>
			</a></li>
		<% } %>
	</ol>
	</div>
</div></div></div>



</body>
</html>