<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*, quizzes.*, users.*, main.*, messages.*, administration.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<%@include file="navigation-bar.jsp" %>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">


</head>
<body>
<% if(request.getParameter("error") != null) { %>
	<div class="alert alert-danger">
  		<strong>Error:</strong> <% out.print(FinalConstants.ERROR_MSG); %>
	</div>
<% } %>

<div class="container-fluid">
<div class="panel panel-default">
    <div class="panel-heading" >
	<h1 class="panel-title">Site Statistics</h1>
	      </div>
	<div class="panel-body">
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
		<form action="AnnouncementServlet" method="post">
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
				<label>Body</label>
				<textarea class="form-control" rows="3" placeholder="Announcement..." name="body"></textarea>
			</div>
			<input type="hidden" name="creator" value="<%=user.getUsername()%>">
			<button type="submit" class="btn btn-default" name="buttonAction" value="create">Create</button>
		</form>
      </div>
  </div>
  
  <div class="panel panel-default">
    <div class="panel-heading">
      <h4 class="panel-title">
			Quick Edit Users
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
				<textarea class="form-control" rows="4" name="usernames"></textarea>
			</div>
			<button type="submit" class="btn btn-danger" name="buttonAction" value="delete">Delete</button>
			<button type="submit" class="btn btn-default" name="buttonAction" value="admin">Make Admin</button>
		</form>
      </div>
  </div>
  
  <div class="panel panel-default">
    <div class="panel-heading">
      <h4 class="panel-title">
          Quick Edit Quizzes
      </h4>
    </div>
      <div class="panel-body">
		Enter quiz IDs (one per line and should be numbers) to modify.<br>
		<form action="AdminEditQuizServlet" method="post">
			<% if("empty".equals(request.getParameter("invalidQuizzes"))) { %>
			<div class="alert alert-danger" role="alert">
				<strong>Empty Field </strong> Please enter at least one quiz ID.
			</div>
			<% } %>
			<div class="form-group">
				<textarea class="form-control" rows="4" name="quizIDs"></textarea>
			</div>
			<button type="submit" class="btn btn-danger" name="buttonAction" value="delete">Delete</button>
			<button type="submit" class="btn btn-default" name="buttonAction" value="clearHistory">Clear History</button>
		</form>
      </div>
  </div>
  
  <div class="panel panel-default">
    <div class="panel-heading">
      <h4 class="panel-title">
          Reported Quizzes
      </h4>
    </div>
      <div class="panel-body"> 
		<% ArrayList<ReportedQuiz> reportedQuizzes = adminManager.getReportedQuizzes(); 
		if (reportedQuizzes.size() == 0) {
			out.println("No reported quizzes.");
		} else {
			for (int i = 0; i < reportedQuizzes.size(); i++) {
				ReportedQuiz reportedQuiz = reportedQuizzes.get(i);
				Quiz fullQuiz = quizManager.getQuiz(reportedQuiz.getQuizId());
				%>
				<div class="panel panel-default">
				  <div class="panel-body">
				    <b>Name: </b> <a href="quiz-summary-page.jsp?id=<%=reportedQuiz.getQuizId()%>"><%=fullQuiz.getQuizName() %></a><br>
				    <b>Creator: </b> <%=fullQuiz.getQuizCreator() %><br>
				    Reported by <%=reportedQuiz.getReporter() %> on <%=reportedQuiz.getDate() %>.
				    <br><br>
				    <form action="HandleReportedQuizServlet" method="post">
				    	<input type="hidden" name="quizId" value="<%=reportedQuiz.getQuizId()%>">
				    	<button type="submit" class="btn btn-danger" name="buttonAction" value="delete">Delete</button>
						<button type="submit" class="btn btn-default" name="buttonAction" value="ignore">Ignore</button>
				    </form>
				  </div>
				</div>
			<%}
		}
		%>
      </div>
  </div>
  
</div>

</body>
</html>