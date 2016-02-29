<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*, quizzes.*, users.*, main.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Homepage</title>
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/style/index.css" />
<%
User user = (User) session.getAttribute("currentUser");
AnnouncementManager announcementManager = (AnnouncementManager) request.getServletContext().getAttribute("announcementManager");
ArrayList<Announcement> announcements = announcementManager.getAnnouncements();
System.out.println(announcements.size());

%>
</head>
<body>
	<ul class="nav" >
	  	<% if(user != null) { %>
			<li class="navListTitle">
				<a href="index.jsp?" ><strong class="navItem">Hello <% out.print(user.getUsername()); %>!</strong></a>
			</li>
		<% } else {
				response.sendRedirect("login-page.jsp?");
		}%>
		<li class="navList" >
			<a class="navItem" href="#">
			<img class="icon" src="Icons/settings_filled.png">
			</a>
		</li>
		<li class="navList" ><a class="navItem" href="#achievements"><img class="icon" src="Icons/medal.png"></a></li>
		<li class="navList" ><a class="navItem" href="#messages"><img class="icon" src="Icons/new_message.png"></a></li>
  		<li class="navList" ><a class="navItem" href="#friends"><img class="icon" src="Icons/groups_filled.png"></a></li>
  		
	</ul>
	<div class="content">
		<h1 id="announcement"> Announcements</h1>
		<ul>
		<%
		for(int i = 0; i < announcements.size(); i++){
			%>
			<li>
			<h3><%= announcements.get(i).getSubject() %></h3>
			<p><%= announcements.get(i).getBody() %></p>
			
			</li> 
			
			<%
		}
		
		%>
		</ul>
		
		<h1> Popular Quizzes</h1>
		<h1> Recently Created</h1>
		<h1> Recently Taken</h1>
		<h1> My Quizzes</h1>
		<h1> Friend Activities</h1>
	</div>


</body>
</html>