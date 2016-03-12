<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*, quizzes.*, users.*, main.*, messages.*, administration.*, quizExtras.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href=”bootstrap/css/bootstrap.min.css” rel=”stylesheet” type=”text/css” />
<script type=”text/javascript” src=”bootstrap/js/bootstrap.min.js”></script>
<title>Privacy</title>
<%@include file="navigation-bar.jsp" %>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="bootstrap/js/bootstrap.min.js"></script>
    
    <script>
    function successMessage() {
    	var page = document.getElementById("page");
    	var success = document.createTextNode("Privacy Settings Successfully updated");
    	page.appendChild(success);
    	
    }
    </script>
    <%
    	PrivacySetting profilePrivacy = userManager.getProfilePrivacy(user.getUsername());
    	
    %>
    
</head>
<body>
<div class="container-fluid">
<div class="col-md-12"><div class="panel panel-default">
<div class="panel-heading"><h1>Privacy Settings</h1></div>

<div class="panel-body" id = "page">
<form action = "UserPrivacyServlet" method = "post">

<% %>

<div><h3> Profile <small>Who can view my full profile?</small></h3>
<%
	if (profilePrivacy == PrivacySetting.Everyone) {
%>
<label class="radio-inline"><input type="radio" name="profile" value="Everyone" checked="checked">Everyone</label>
<%} else { %>
<label class="radio-inline"><input type="radio" name="profile" value="Everyone">Everyone</label>
<%} %>
<%
	if (profilePrivacy == PrivacySetting.MyFriends) {
%>
<label class="radio-inline"><input type="radio" name="profile" value="MyFriends" checked="checked">My Friends</label>
<%} else { %>
<label class="radio-inline"><input type="radio" name="profile" value="MyFriends">My Friends</label>
<%} %>

<%
	if (profilePrivacy == PrivacySetting.NoOne) {
%>
<label class="radio-inline"><input type="radio" name="profile" value="NoOne" checked = "checked">No One</label>
<%} else { %>
<label class="radio-inline"><input type="radio" name="profile" value="NoOne">No One</label>
<%} %>




</div>

<div><h3> Messages <small>Who can send me messages?</small></h3>
<label class="radio-inline"><input type="radio" name="messages" checked="checked">Everyone</label>
<label class="radio-inline"><input type="radio" name="messages" >My Friends</label>
</div>

<div><h3> Viewability <small>Who can see my name in quiz performances?</small></h3>
<label class="radio-inline"><input type="radio" name="performance" checked="checked">Everyone</label>
<label class="radio-inline"><input type="radio" name="performance">My Friends</label>
<label class="radio-inline"><input type="radio" name="performance">No One</label>
</div>
<div><h3> Friend <small> Who can add me as a friend?</small> </h3>
<label class="radio-inline"><input type="radio" name="friend" value = "Everyone" checked="checked">Everyone</label>
<label class="radio-inline"><input type="radio" name="friend" value = "NoOne">No One</label>
</div>
<br>
<br>
<input type="hidden" name="username" value="<%=user.getUsername()%>">
<button class="btn btn-success" type="submit" >Done</button>

<%
	String updated = request.getParameter("updated");
	if (updated.equals("true")) {
%>
<h4> Privacy settings updated!</h4>
<%} %>	
	
</form>

</div>


</body>
</html>