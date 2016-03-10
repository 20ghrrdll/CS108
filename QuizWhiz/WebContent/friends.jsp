<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="java.util.*, quizzes.*, users.*, main.*, messages.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Friends</title>
<%@include file="navigation-bar.jsp" %>
 <script>
         $(function() {
            var availableTutorials = [
               "ActionScript",
               "Boostrap",
               "C",
               "C++",
            ];
            $( "#automplete-1" ).autocomplete({
               source: availableTutorials
            });
         });
      </script>
</head>
<body>
<div class="container-fluid">
<div class="panel panel-success">
<div class="ui-widget">
         <p>Type "a" or "s"</p>
         <label for="automplete-1">Tags: </label>
         <input id="automplete-1">
      </div>
      </div>
      </div>
<!-- <h3>Country</h3>
    <input type="text" id="country" name="country"/>
     
    <script>
    	$(this.target).find('country').autocomplete("getData.jsp");
        //$("#country").autocomplete("getData.jsp");
    </script> -->

<%
	Set<String> friendsNames = new HashSet<String>();
	Set<String> friendRequests = new HashSet<String>();

	if(user!= null){
		friendsNames = userManager.getFriends(user.getUsername());
		friendRequests = userManager.getFriendRequests(user.getUsername());
	}
%>

<%if(!friendRequests.isEmpty()) {%>
<div class="container-fluid"><div class="col-md-12"><div class="panel panel-success">
	<div class="panel-heading"><h1 class="panel-title">Friend Requests</h1></div>
	<div class="panel-body">
	<ol><% for (String username : friendRequests) { %>
			<li>
					<h4><b><a href="user-profile.jsp?username=<%=username%>"
							STYLE="text-decoration: none"><%=username%></a></b></h4>
								<form action="FriendRequestServlet" method="post">
							<input type="hidden" name="id" value="<%=username%>"/>
							<input type="hidden" name="userId" value="<%=user.getUsername()%>">
							<button  class="btn btn-default"  type="submit" name="Accept">Accept</button>
							<button  class="btn btn-default"  type="submit" name="Ignore">Ignore</button>
							</form>
			</li>
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