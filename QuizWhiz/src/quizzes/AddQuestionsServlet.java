package quizzes;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import main.MyDBInfo;

/**
 * Servlet implementation class AddQuestionsServlet
 */
@WebServlet("/AddQuestionsServlet")
public class AddQuestionsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AddQuestionsServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int quizId = Integer.valueOf(request.getParameter("quizId"));
		QuizManager quizManager = (QuizManager) request.getServletContext().getAttribute("quizManager");
		Quiz quiz = quizManager.getQuiz(quizId);
		//int quizId = quiz.getQuizID();
		QuizType quizType = quiz.getQuizType();
		
		
		
		if (request.getParameter("editing").equals("yes")) {
			//delete all previous responses
			quizManager.deleteQuizAnswers(quizId);
		}
		
		
		

		String questions[] = request.getParameterValues("question");
		String answers[] = request.getParameterValues("answer");

		for(int i = 0; i < questions.length; i++) {
			String question = questions[i].trim();
			String answer;
			int numAnswers = 0;

			if (quizType == QuizType.MultipleChoice) {
				 numAnswers = 4;
				 String[] questionAnswers = answers[i].trim().split("[|]+");
				 answer = questionAnswers[0];
					quizManager.addMultipleAnswerQuestion(quizId, i+1, question, answer, 1, questionAnswers, true);
			} 
			else 
				//one answer
				if (!answers[i].contains("|")) {
					answer = answers[i];
					numAnswers = 1;
					quizManager.addSingleAnswerQuestion(quizId, i+1, question, answer, 1);
				}
			//more than one answer
				else {
					//if the type is multiple choice, then this doesnt happen
					answer = "go to question_answers";
					String[] questionAnswers = answers[i].trim().split("[|]+");
					numAnswers = questionAnswers.length;
					quizManager.addMultipleAnswerQuestion(quizId, i+1, question, answer, 1, questionAnswers, false);
				}
		}
		
		String url = "quiz-summary-page.jsp?id="+quizId;
		RequestDispatcher d = request.getRequestDispatcher(url);
		d.forward(request, response); 
	}

}




