<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href=”bootstrap/css/bootstrap.min.css” rel=”stylesheet” type=”text/css” />
<script type=”text/javascript” src=”bootstrap/js/bootstrap.min.js”></script>
<title>Make Quiz</title>
</head>
<body>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="bootstrap/js/bootstrap.min.js"></script>


<%

%>
<h1>Make Quiz</h1>

	<form action="QuizMakerServlet" method="post">
		Quiz Name: <input type="text" name="quizName"> <br>
		Quiz Description: <input type="text" name = "quizDescription"> <br>
		Quiz Type: <br>
		<input type="radio" name="quizType" value="QuestionResponse"> Question Response<br>
		<input type="radio" name="quizType" value="FillIn"> Fill in the Blank <br>
		<input type="radio" name="quizType" value="mc"> Multiple Choice <br>
		<input type="radio" name="quizType" value="pic"> Picture-Response <br>
		
		Allow Randomized Order? <br>
		<input type="radio" name="randomOrder" value="y"> Yes<br>
		<input type="radio" name="randomOrder" value="n"> No <br>
		
		Allow Practice Mode? <br>
		<input type="radio" name="practice" value="y"> Yes<br>
		<input type="radio" name="practice" value="n"> No <br>
		
		Display Options <br>
		<input type="radio" name="pages" value="one">One Page<br>
		<input type="radio" name="pages" value="multiple">On Question per Page <br>
		
		Correction Options <br>
		<input type="radio" name="correction" value="immediate">Immediate Correction<br>
		<input type="radio" name="correction" value="delayed">Delayed Correction<br>
		
		<input type="submit" value = "Submit" >
	</form>


</body>
</html>