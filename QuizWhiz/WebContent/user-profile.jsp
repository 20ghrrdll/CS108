<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="java.util.*, quizzes.*, users.*, main.*, messages.*, administration.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="navigation-bar.jsp"%>

<style>
.modal-header, .close {
	background-color: #5cb85c;
	color: white !important;
	text-align: center;
	font-size: 30px;
}

.modal-footer {
	background-color: #f9f9f9;
}
</style>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<%
ArrayList<QuizPerformance> recentlyTakenScores = quizManager.getRecentlyTakenQuizzesScore(user.getUsername());

	String usernameToView = request.getParameter("username");
	User userToView = userManager.getUser(usernameToView);
	if (userToView == null) {
%>
<div class="alert alert-danger">
	<strong>Error!</strong>
	<%=usernameToView%>
	does not exist.
</div>
<%
	} else {

		ArrayList<String> sentRequests = userManager.getSentRequests(user.getUsername());
		PrivacySetting profilePrivacy = userToView.getProfilePrivacy();
		boolean viewable = true;

		if (profilePrivacy == PrivacySetting.MyFriends) {
			if (!friendsNames.contains(usernameToView)){
				viewable = false;
			}
		}
		if (profilePrivacy.equals(PrivacySetting.NoOne)) {
			viewable = false; 
		}
%>
		

<title>
	<%
		out.print(usernameToView);
	%>'s Profile
</title>
</head>
<body>
	<div class="container">
		<!-- Modal -->
		<div class="modal fade" id="myModal" role="dialog">
			<div class="modal-dialog">
				<!-- Modal content-->
				<div class="modal-content">
					<div class="modal-header" style="padding: 35px 50px;">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4>Challenge a Friend!</h4>
					</div>
					<div class="modal-body" style="padding: 40px 50px;">
						<form action="MessageServlet" method="post">
							<div class="form-group">
								<label>Challenge</label> <input type="test" class="form-control"
									name="username" placeholder="Username"
									value="<%=usernameToView%>">
							</div>
							<label>Select a quiz from the quizzes you've taken</label> 
							<select class="form-control"  name="quizId" >
							<% for (int i = 0; i < recentlyTakenScores.size(); i++) { %>
								<option value="<%=recentlyTakenScores.get(i).getQuizId()%> <%=recentlyTakenScores.get(i).getScore() %>&#47;<%=recentlyTakenScores.get(i).getPossibleScore() %>">
								<%=recentlyTakenScores.get(i).getQuizName()%> Score: <%=recentlyTakenScores.get(i).getScore() %></option>
							<% } %>
							</select>
							<input type="hidden" name="senderId"
								value="<%=user.getUsername()%>"/> <input type="hidden"
								name="sendChallenge" value="<%=user.getUsername()%>"/>
								<input name="userProfile" type="hidden" value="defaultvalue"/>
							<button onclick="sendChallenge" class="btn btn-default" value="send">Challenge!</button>
						</form>
					</div>
					<div class="modal-footer">
						<button type="submit" class="btn btn-danger btn-default pull-left"
							data-dismiss="modal">
							<span class="glyphicon glyphicon-remove"></span> Cancel
						</button>
					</div>
				</div>

			</div>
		</div>
	</div>
	

	<div class="container">
		<!-- Modal -->
		<div class="modal fade" id="myMessageModal" role="dialog">
			<div class="modal-dialog">

				<!-- Modal content-->
				<div class="modal-content">
					<div class="modal-header" style="padding: 35px 50px;">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4>Send a Message</h4>
					</div>
					<div class="modal-body" style="padding: 40px 50px;">
						<form action="MessageServlet" method="post" id="messageForm">
							<div class="form-group">
								<label>Send to</label> <input type="test" class="form-control"
									name="username" placeholder="Username"
									value="<%=usernameToView%>">
							</div>
							<div class="form-group">
								<label for="exampleInputEmail1">Subject</label> <input
									type="test" class="form-control" name="subject"
									placeholder="Subject">
							</div>
							<div class="form=group">
								<label for="exampleInputEmail1">Body</label>
								<textarea class="form-control" rows="3" placeholder="message..."
									name="body"></textarea>
							</div>
							<input type="hidden" name="senderId"
								value="<%=user.getUsername()%>"> <input type="hidden"
								name="sendNote" value="<%=user.getUsername()%>"> <input
								type="hidden" name="userProfile" value="<%=user.getUsername()%>">
							<button type="submit" class="btn btn-default" value="send">Send
								Message</button>
						</form>
					</div>
					<div class="modal-footer">
						<button type="submit" class="btn btn-danger btn-default pull-left"
							data-dismiss="modal">
							<span class="glyphicon glyphicon-remove"></span> Cancel
						</button>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script>
		$(document).ready(function() {
			$("#myBtn").click(function() {
				$("#myModal").modal();
			});
			$("#myMessageBtn").click(function() {
				$("#myMessageModal").modal();
			});
			
		});
	</script>


	<%
		if (userManager.getUser(usernameToView) == null) {
	%>
	<div class="alert alert-danger">
		<strong>Error!</strong> User does not exist.
	</div>
	<%
		} else {
	%>

	<div class="container-fluid">
		<div class="row">
			<div class="col-md-5">
				<div class="panel panel-default">
					<div class="panel-heading">
						<h1>
							<%
								out.println(usernameToView);
								
							%>
						</h1>
					</div>
					<div class="panel-body" style="text-align: left">
					<div><li>Date joined: <%=userManager.getUser(usernameToView).getJoinDate()%></li>
							<li>Number of quizzes made: <%=quizManager.getMyQuizzes(usernameToView).size()%></li></div>
							<br>
						<%
							if (!user.getUsername().equals(usernameToView)) {
										Set<String> currentUserFriends = userManager.getFriends(user.getUsername());
										if (!currentUserFriends.contains(usernameToView.toLowerCase())) {
											if (!sentRequests.contains(usernameToView.toLowerCase())) {
						%>
						<div> 
							
					
						<form action="FriendRequestServlet" method="post">
							<input type="hidden" name="user1" value="<%=user.getUsername()%>">
							<input type="hidden" name="user2" value="<%=usernameToView%>">
							<div class="col-md-3" style="float: left">
								<button type="submit" class="btn btn-link" name="buttonAction"
									value="delete">
									<i class="material-icons">add</i> <br>Add Friend
								</button>
							</div>
						</form>
						<%
							} else {
						%>
						<div class="col-md-3" style="float: left">
							<button type="submit" class="btn btn-link disabled"
								name="buttonAction" value="delete">
								<i class="material-icons">add</i> <br> <i>Request Sent</i>
							</button>
						</div>
						<%
							}
										}
						%>

						<div class="col-md-3" style="float: left">
							<a class="btn btn-link" id="myMessageBtn"> <i
								class="material-icons">email</i> <br>Message
							</a>
						</div>

						<div class="col-md-3" style="float: left">
							<a class="btn btn-link" id="myBtn"> <i class="material-icons">games</i>
								<br>Challenge
							</a>
						</div>

						<%
							if (userManager.isAdmin(user.getUsername())) {
						%>
						<form action="EditUserServlet" method="post">
							<input type="hidden" name="usernames"
								value="<%out.print(usernameToView);%>">
							<div class="col-md-3" style="float: left">
								<button type="submit" class="btn btn-link" name="buttonAction"
									value="delete">
									<i class="material-icons">delete</i> <br>Delete
								</button>
							</div>
							<% if (!userManager.isAdmin(usernameToView)) { %>
							<div class="col-md-3" style="float: left">
								<button type="submit" class="btn btn-link" name="buttonAction"
									value="admin">
									<i class="material-icons">grade</i> <br>Make Admin
								</button>
							</div><% } %>
						</form>
						<%
							}
						%>

						<%
							}
						%>
					</div>
				</div>
			</div>
		</div>

		<% if (viewable) {
				%>
		<div class="row">
			<div class="col-md-12">
				<div class="panel panel-default">
			
					<div class="panel-heading">
						<h1 class="panel-title">Achievements</h1>
					</div>
					<div class="panel-body">
						<%
							ArrayList<String> userAchievements = userManager.getAchievements(usernameToView);
									if (userAchievements.size() == 0) {
						%>
						<h4>No achievements to display.</h4>
						<%
							} else {
										for (int i = 0; i < userAchievements.size(); i++) {
											Achievement a = FinalConstants.ACHIEVEMENTS.get(userAchievements.get(i));
						%>
						<div class="col-md-2" style="float: left">
							<div class="thumbnail">
								<img src="<%out.print(a.getImageUrl());%>">
								<div class="caption" style="text-align: center">
									<h3>
										<%
											out.print(a.getName());
										%>
									</h3>
									<p>
										<%
											out.println(a.getDescription());
										%>
									</p>
								</div>
							</div>
						</div>
						<%
							}
									}
						%>
					</div>
				</div>
			</div>
		</div>


		<div class="row">
			<div class="col-md-6">
				<div class="panel panel-default">
					<div class="panel-heading">
						<h1 class="panel-title">Quizzes Created</h1>
					</div>
					<div class="panel-body">
						<ol>
							<%
								ArrayList<Quiz> quizzesCreated = quizManager.getMyQuizzes(usernameToView);
										if (quizzesCreated.size() == 0) {
							%>
							<h4>No quizzes created.</h4>
							<%
								} else {
											for (int i = 0; i < quizzesCreated.size(); i++) {
							%>
							<li><a
								<%String id = String.valueOf(quizzesCreated.get(i).getQuizID());%>
								href="quiz-summary-page.jsp?id=<%=id%>"
								STYLE="text-decoration: none">
									<h4><%=quizzesCreated.get(i).getQuizName()%></h4>
									<p><%=quizzesCreated.get(i).getQuizDescription()%></p>
							</a></li>
							<%
								}
										}
							%>
						</ol>
					</div>
				</div>
			</div>

			<div class="col-md-6">
				<div class="panel panel-default">
					<div class="panel-heading">
						<h1 class="panel-title">Recent Performance</h1>
					</div>
					<div class="panel-body">
						<ol>
							<%
								ArrayList<Quiz> quizzesTaken = quizManager.getMyRecentlyTakenQuizzes(usernameToView);
										if (quizzesTaken.size() == 0) {
							%>
							<h4>No recent activity to display.</h4>
							<%
								} else {
											for (int i = 0; i < quizzesTaken.size() && i < 5; i++) {
							%>
							<li><a
								<%String id = String.valueOf(quizzesTaken.get(i).getQuizID());%>
								href="quiz-summary-page.jsp?id=<%=id%>"
								STYLE="text-decoration: none">
									<h4><%=quizzesTaken.get(i).getQuizName()%></h4>
									<p><%=quizzesTaken.get(i).getQuizDescription()%></p>
							</a></li>
							<%
								}
										}
							%>
						</ol>
					</div>
				</div>
			</div> <%} %>
		</div>
		<%
		}
			}
		%>
	
</body>

</html>