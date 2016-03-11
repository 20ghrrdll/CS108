<%@ page language="java" contentType="text/html; charset=UTF-8"
import="java.util.*, quizzes.*, users.*, main.*, messages.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href=”bootstrap/css/bootstrap.min.css” rel=”stylesheet” type=”text/css” />
<script type=”text/javascript” src=”bootstrap/js/bootstrap.min.js”></script>
<title>Make Quiz</title>

<%@include file="navigation-bar.jsp" %>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="bootstrap/js/bootstrap.min.js"></script>


</head>
<body>

<div class="container-fluid">
<div class="col-md-12"><div class="panel panel-default">
<div class="panel-heading"><h1>Make Quiz</h1></div>
<div class="panel-body">

	<form action="QuizMakerServlet" method="post">
		<h4>Quiz Name:</h4> <input type="text" name="quizName"> <br>
		<h4>Quiz Description:</h4> 
		<textarea class="form-control" rows="5" name="quizDescription" id="quizDescription"></textarea>
		
		<br><h5>Quiz Type:</h5> 
		<input type="radio" name="quizType" value="QuestionResponse"> Question Response<br>
		<input type="radio" name="quizType" value="FillIn"> Fill in the Blank <br>
		<input type="radio" name="quizType" value="MultipleChoice"> Multiple Choice <br>
		<input type="radio" name="quizType" value="PictureResponse"> Picture-Response <br>
		
		<br><h5>Allow Randomized Order?</h5> 
		<input type="radio" name="randomOrder" value="y"> Yes<br>
		<input type="radio" name="randomOrder" value="n"> No <br>
		
		<br><h5>Allow Practice Mode?</h5> 
		<input type="radio" name="practice" value="y"> Yes<br>
		<input type="radio" name="practice" value="n"> No <br>
		
		<br><h5>Display Options</h5> 
		<input type="radio" name="pages" value="one"> One Page<br>
		<input type="radio" name="pages" value="multiple"> One Question per Page <br>
		
		<br><h5>Correction Options</h5> 
		<input type="radio" name="correction" value="immediate"> Immediate Correction<br>
		<input type="radio" name="correction" value="delayed"> Delayed Correction<br>
		
		<br>
		<button type="submit" class="btn btn-default" value="submit">Create</button>
		
	</form>
</div></div></div></div>

</body>
</html>