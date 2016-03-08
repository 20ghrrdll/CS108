<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*, quizzes.*, users.*, main.*, messages.*, administration.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<link href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
<script type="${pageContext.request.contextPath}/text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Admin Portal</title>
</head>
<body>

<% 
User user = (User) session.getAttribute("currentUser");
AdminManager adminManager = (AdminManager) request.getServletContext().getAttribute("adminManager");
 %>

<div class="container-fluid">
	<h1>Site Statistics</h1>
	<div class="row">
		<div class="col-xs-6 col-sm-3" style="text-align: center">
		<h3><% out.print(adminManager.getNumUsers()); %><br>
		Users</h3></div>
		<div class="col-xs-6 col-sm-3" style="text-align: center">
		<h3><% out.print(adminManager.getNumQuizzesCreated()); %><br>
		Quizzes Created</h3></div>
		<div class="col-xs-6 col-sm-3" style="text-align: center">
		<h3><% out.print(adminManager.getNumQuizzesTaken()); %><br>
		Quizzes Taken</h3></div>
	</div>
</div>

<div class="container-fluid">
<h1>Administrative Functions</h1>

  <div class="panel panel-default">
    <div class="panel-heading" >
      <h4 class="panel-title">
          Create Announcements
      </h4>
    </div>
      <div class="panel-body">
		<form action="AnnouncementCreationServlet" method="post">
		    <% if("empty".equals(request.getParameter("invalidAnnouncement"))) { %>
			<div class="alert alert-danger" role="alert">
				<strong>Empty Field </strong> Please enter a subject and body.
			</div>
			<% } %>
			<div class="form-group">
				<label>Subject</label> <input
					type="test" class="form-control" name="subject"
						placeholder="Subject" >
			</div>
			<div class="form-group">
				<label for="exampleInputEmail1">Body</label>
				<textarea class="form-control" rows="3" placeholder="Announcement..." name="body"></textarea>
			</div>
			<input type="hidden" name="creator" value="Max">
			<button type="submit" class="btn btn-default">Create</button>
		</form>
      </div>
  </div>
  
  <div class="panel panel-default">
    <div class="panel-heading" role="tab" id="headingTwo">
      <h4 class="panel-title">
			Edit Users
      </h4>
    </div>
      <div class="panel-body">
      	Enter usernames (one per line) to modify.<br>
		<form action="EditUserServlet" method="post">
			<% if("empty".equals(request.getParameter("invalidUsers"))) { %>
			<div class="alert alert-danger" role="alert">
				<strong>Empty Field </strong> Please enter at least one user.
			</div>
			<% } %>
			<div class="form-group">
				<label for="exampleInputEmail1">Usernames</label>
				<textarea class="form-control" rows="4" name="usernames"></textarea>
			</div>
			<button type="submit" class="btn btn-default" value="delete" onclick="action=this.value">Delete</button>
			<button type="submit" class="btn btn-default" value="admin" onclick="action=this.value">Make Admin</button>
		</form>
      </div>
  </div>
  
  <div class="panel panel-default">
    <div class="panel-heading" role="tab" id="headingThree">
      <h4 class="panel-title">
          Edit Quizzes
      </h4>
    </div>
      <div class="panel-body">
        Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid. 3 wolf moon officia aute, non cupidatat skateboard dolor brunch. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch et. Nihil anim keffiyeh helvetica, craft beer labore wes anderson cred nesciunt sapiente ea proident. Ad vegan excepteur butcher vice lomo. Leggings occaecat craft beer farm-to-table, raw denim aesthetic synth nesciunt you probably haven't heard of them accusamus labore sustainable VHS.
      </div>
  </div>
</div>



</body>
</html>