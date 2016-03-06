<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Results</title>
</head>
<body>

	<h1>Results:</h1>
	<h4>You scored <%out.print(session.getAttribute("score")); %>/<%out.print(session.getAttribute("maxScore")); %></h4>

</body>
</html>