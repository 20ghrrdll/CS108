<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="java.util.*, quizzes.*, users.*, main.*, messages.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Messages</title>
<%@include file="navigation-bar.jsp"%>
<%
	ArrayList<QuizPerformance> recentlyTakenScores = quizManager.getRecentlyTakenQuizzesScore(user.getUsername());
%>
</head>
<body>

	<div class="container">
		<div class="row">
			<div class="col-md-6">
				<center><a class="btn btn-link" id="myBtn"> <i class="material-icons">games</i>
					<br>Challenge
				</a></center>
			</div>
			<div class="col-md-6">
				<center><a class="btn btn-link" id="myMessageBtn"> <i class="material-icons">email</i>
					<br>Message
				</a></center>
			</div>
		</div>
	</div>
	<div class="container-fluid">
		<ul class="list-group">
			<%
				for (int i = 0; i < messages.size(); i++) {
					if (!messages.get(i).isUnread()) {
			%>
			<li class="list-group-item">
				<h2>
					<i><%=messages.get(i).getTitle()%> - <%=messages.get(i).getSender()%></i>
				</h2>
				<p>
					<i><%=messages.get(i).getBody()%></i>
				</p>
			</li>
			<%
				} else if (messages.get(i).getType().equals("NOTE")) {
			%>
			<li class="list-group-item" style="background-color: #CFF0FE">
				<h2><%=messages.get(i).getTitle()%><i> - <%=messages.get(i).getSender()%></i>
				</h2>
				<p><%=messages.get(i).getBody()%></p>
				<form action="MessageServlet" method="post" id="message">
					<input type="hidden" name="messageId"
						value="<%=messages.get(i).getId()%>"> <input
						type="hidden" name="note"> <a class="btn btn-default"
						href="create-message.jsp?replyTo=<%=messages.get(i).getSender()%>">Reply</a>
					<button class="btn btn-default" type="submit" value="note">Mark
						as read</button>
				</form>
				<br>
			</li>
			<%
				} else {
			%>
			<li class="list-group-item" style="background-color: #FECFCF">
				<h2>
					Quiz Challenge from
					<%=messages.get(i).getSender()%>!
				</h2>
				<p><%=messages.get(i).getSender()%>
					took the quiz,
					<%=quizManager.getQuiz(messages.get(i).getQuizId()).getQuizName()%>,
					and got a
					<%=messages.get(i).getScore()%>. Can you beat that score?
				</p>
				<form action="MessageServlet" method="post">
					<input type="hidden" name="messageId"
						value="<%=messages.get(i).getId()%>"> <input
						type="hidden" name="quizId"
						value="<%=messages.get(i).getQuizId()%>"> <input
						type="hidden" name="challenge">
					<button class="btn btn-default" type="submit" value="challenge">Accept
						Challenge</button>
					<button class="btn btn-default" type="submit"
						value="challengeIgnore" name="challengeIgnore">Ignore
						Challenge</button>

				</form>
				<br>
			</li>
			<%
				}
			%>
			<br>
			<%
				}
			%>

		</ul>
	</div>
	<div class="container">
		<!-- Modal -->
		<div class="modal fade" id="myModal" role="dialog">
			<div class="modal-dialog">
				<!-- Modal content-->
				<div class="modal-content">
					<div class="modal-header"
						style="padding: 35px 50px; background-color: #3ccecc">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4>Challenge a Friend!</h4>
					</div>
					<div class="modal-body" style="padding: 40px 50px;">
						<form action="MessageServlet" method="post">
							<div class="form-group">
								<label>Challenge</label> <input type="test" class="form-control"
									name="username" placeholder="Username">
							</div>
							<label>Select a quiz from the quizzes you've taken</label> <select
								class="form-control" name="quizId">
								<%
									for (int i = 0; i < recentlyTakenScores.size(); i++) {
								%>
								<option
									value="<%=recentlyTakenScores.get(i).getQuizId()%> <%=recentlyTakenScores.get(i).getScore()%>&#47;<%=recentlyTakenScores.get(i).getPossibleScore()%>">
									<%=recentlyTakenScores.get(i).getQuizName()%> Score:
									<%=recentlyTakenScores.get(i).getScore()%></option>
								<%
									}
								%>
							</select> <input type="hidden" name="senderId"
								value="<%=user.getUsername()%>" /> <input type="hidden"
								name="sendChallenge" value="<%=user.getUsername()%>" />
							<button onclick="sendChallenge" class="btn btn-default"
								value="send">Challenge!</button>
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
					<div class="modal-header"
						style="padding: 35px 50px; background-color: #3ccecc">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4>Send a Message</h4>
					</div>
					<div class="modal-body" style="padding: 40px 50px;">
						<form action="MessageServlet" method="post" id="messageForm">
							<div class="form-group">
								<label>Send to</label> <input type="test" class="form-control"
									name="username" placeholder="Username">
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
								name="sendNote" value="<%=user.getUsername()%>">
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
</body>
</html>