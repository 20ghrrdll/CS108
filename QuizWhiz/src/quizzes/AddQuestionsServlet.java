package quizzes;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.Statement;

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
		System.out.print("ID: " + quizId);
		QuizManager quizManager = (QuizManager) request.getServletContext().getAttribute("quizManager");
		Quiz quiz = quizManager.getQuiz(quizId);
		//int quizId = quiz.getQuizID();
		QuizType quizType = quiz.getQuizType();

		String questions[] = request.getParameterValues("question");
		String answers[] = request.getParameterValues("answer");

		for(int i = 0; i < questions.length; i++) {
			String question = questions[i].trim();
			String answer;
			int numAnswers = 0;

			if (quizType == QuizType.MultipleChoice) {

			} 
			else 
				//one answer
				if (!answers[i].contains("|")) {
					answer = answers[i];
					numAnswers = 1;
					quizManager.addSingleAnswerQuestion(quizId, i+1, question, answer, numAnswers);
				}
			//more than one answer
				else {
					//if the type is multiple choice, then this doesnt happen
					answer = "go to question_answers";
					String[] questionAnswers = answers[i].trim().split("[\\|\\s]+");
					numAnswers = questionAnswers.length;
					quizManager.addMultipleAnswerQuestion(quizId, i+1, question, answer, numAnswers, questionAnswers);
				}
		}
	}

}




