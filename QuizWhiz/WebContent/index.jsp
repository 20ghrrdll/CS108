<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*, quizzes.*, users.*, main.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Homepage</title>
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/style/index.css" />
<link rel="stylesheet" href="http://www.w3schools.com/lib/w3.css">
<link rel="stylesheet" href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.4.0/css/font-awesome.min.css">
<link rel="stylesheet" href="http://www.w3schools.com/lib/w3-theme-indigo.css">
<script>
function myFunction(id) {
    document.getElementById(id).classList.toggle("w3-show");
}
</script>
<%
User user = (User) session.getAttribute("currentUser");
AnnouncementManager announcementManager = (AnnouncementManager) request.getServletContext().getAttribute("announcementManager");
ArrayList<Announcement> announcements = announcementManager.getAnnouncements();

QuizManager quizManager = (QuizManager) request.getServletContext().getAttribute("quizManager");
ArrayList<Quiz> popularQuizzes = quizManager.getPopularQuizzes();

%>
</head>
<body class="w3-theme-light standards">
	<ul class="w3-navbar w3-theme-dark w3-border">
  		<% if(user != null) { %>
	  	<li>
				<a href="index.jsp?" >Hello <% out.print(user.getUsername()); %>!</a>
			</li>
		<% } else {
				response.sendRedirect("login-page.jsp?");
		}%>
  		<ul class="w3-right">
    		<li><a href="#">Friends</a></li>
    		<li><a href="#">Messages</a></li>
    		<li class="w3-dropdown-hover">
    			<a href="#">Settings</a>
    			<div class="w3-dropdown-content w3-white w3-card-4">
      				<a href="#">Privacy Options</a>
     				<a href="#">Log out</a>
    			</div>
 		 	</li>
 		 	<li><a href="#">Achievements</a></li>
  		</ul>
	</ul>
<div class="w3-accordion">
		<h1 id="announcement" class="center-title w3-theme" onclick="myFunction('Demo1')"> Announcements</h1>
		<div id="Demo1" class="w3-accordion-content">
		<ul class="w3-ul w3-hoverable">
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
		</div>
		</div>
		<div class="w3-row">
		  <div class="w3-container w3-half">
		
		<h1 class="center-title w3-theme"> Popular Quizzes</h1>
		
		<ol class="w3-ul w3-hoverable">
		<%
		for(int i = 0; i < popularQuizzes.size(); i++){
			%>
			<li>
			<h3><%= popularQuizzes.get(i).getQuizName() %></h3>
			<p><%= popularQuizzes.get(i).getQuizDescription() %></p>
			
			</li> 
			
			<%
		}
		
		%>
		</ol>
		</div>
		  <div class="w3-container w3-half">
		
		<h1 class="center-title w3-theme "> Recently Created</h1>
		<ul class="w3-ul w3-hoverable">
		<li><a href="#">Test List</a></li>
		<li><a href="#">Test List</a></li>
		<li><a href="#">Test List</a></li>
		<li><a href="#">Test List</a></li>
		</ul>
		
		</div>
		</div>
		<div class="w3-row">
				  <div class="w3-container w3-half">
		
		<h1 class="center-title w3-theme"> Recently Taken</h1>
		<ul class="w3-ul w3-hoverable">
		<li><a href="#">Test List</a></li>
		<li><a href="#">Test List</a></li>
		<li><a href="#">Test List</a></li>
		<li><a href="#">Test List</a></li>
		</ul>
		</div>
				  <div class="w3-container w3-half">
		
		<h1 class="center-title w3-theme"> My Quizzes</h1>
		<ul class="w3-ul w3-hoverable">
		<li><a href="#">Test List</a></li>
		<li><a href="#">Test List</a></li>
		<li><a href="#">Test List</a></li>
		<li><a href="#">Test List</a></li>
		</ul>
		</div>
		</div>
		<h1 class="center-title w3-theme"> Friend Activities</h1>

</body>
</html>