package quizzes;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import users.User;

/**
 * Servlet implementation class NextQuestionPageServlet
 */
@WebServlet("/NextQuestionPageServlet")
public class NextQuestionPageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public NextQuestionPageServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		long end_num = System.currentTimeMillis();
		int questionNum = Integer.parseInt(request.getParameter("questionNum"));
		//request.setAttribute("questionNum", questionNum+1);
		int questionId = Integer.parseInt(request.getParameter("questionId"));
		String answer = request.getParameter(Integer.toString(questionId));
		MultiplePageQuiz multiQuiz = (MultiplePageQuiz) request.getServletContext()
				.getAttribute("multiplePageQuiz");
		
		multiQuiz.addUserAnswer(questionNum-1, answer);
		//request.setAttribute("QuizType", request.getAttribute("QuizType"));
		
		RequestDispatcher dispatch;
		if(questionNum < multiQuiz.getNumQuestions()){
			multiQuiz.incrementCurrQuestionNum();
			dispatch = request.getRequestDispatcher("multiple-pages-quiz.jsp?");
		}
		else{
			long start_num = multiQuiz.getStartTime();
			long quizTime = end_num - start_num;
			request.setAttribute("quizTime", quizTime);
			request.setAttribute("currQuizId", request.getParameter("quizId"));
	
			
			User user  = (User)request.getSession().getAttribute("currentUser");
			QuestionManager qManager = (QuestionManager) request.getServletContext().getAttribute("questionManager");
			int score = multiQuiz.getScore(user.getUsername(), qManager);
			request.setAttribute("score", score);
			
			request.setAttribute("maxScore", multiQuiz.getNumQuestions());
			request.setAttribute("allUserAnswers", multiQuiz.getUserAnswers());
			request.setAttribute("questions", multiQuiz.getAllQuestions());
			request.setAttribute("isAnswerCorrect", multiQuiz.getIsCorrect());
			
			dispatch = request.getRequestDispatcher("quiz-results.jsp");
		}
		dispatch.forward(request, response);
		doGet(request, response);
	}

}
