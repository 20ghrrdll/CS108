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
</head>
<body>
<div class="container-fluid">
<div class="col-md-12"><div class="panel panel-default">
<div class="panel-heading"><h1>Privacy Settings</h1></div>

<div class="panel-body">
<form action = "UserPrivacyServlet" method = "post">

<div><h3> Profile <small>Who can view my full profile?</small></h3>
<label class="radio-inline"><input type="radio" name="profile" checked="checked">Everyone</label>
<label class="radio-inline"><input type="radio" name="profile">My Friends</label>
<label class="radio-inline"><input type="radio" name="profile">No One</label>

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
<div><h3> Searchability <small> Who can add me as a friend?</small> </h3>
<label class="radio-inline"><input type="radio" name="friend" checked="checked">Everyone</label>
<label class="radio-inline"><input type="radio" name="friend">No One</label>
</div>
<br>
<br>
<button class="btn btn-success" type="submit">Done</button>
</form>

</div>


</body>
</html>