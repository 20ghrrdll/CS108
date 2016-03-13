package quizzes;

import java.io.IOException;
import java.util.ArrayList;

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

		request.setCharacterEncoding("UTF-8");
		
	
		long end_num = System.currentTimeMillis();
		int questionNum = Integer.parseInt(request.getParameter("questionNum"));
		//request.setAttribute("questionNum", questionNum+1);
		int questionId = Integer.parseInt(request.getParameter("questionId"));
		MultiplePageQuiz multiQuiz = (MultiplePageQuiz) request.getServletContext()
				.getAttribute("multiplePageQuiz");
		String answer;
		if(multiQuiz.getQuizType() == "FillIn")
			answer = request.getParameter(Integer.toString(questionId)+"-0");
		else
			answer = request.getParameter(Integer.toString(questionId));
		
		//request.setAttribute("QuizType", request.getAttribute("QuizType"));
		
		RequestDispatcher dispatch;
		String username = "Carah";
		//String username = ((User) request.getSession().getAttribute("currentUser")).getUsername();
		QuestionManager manager = (QuestionManager) request.getServletContext().getAttribute("questionManager");
		
		String action = request.getParameter("checkWork");
		if(action != null){
			Question currQuestion = multiQuiz.getQuestion();
			
			boolean correct;
			if(multiQuiz.getQuizType() != "MultipleChoice"){
			 correct = currQuestion.isCorrect(answer, username, true, manager);
			}
			else{
				ArrayList<String> answers = new ArrayList<String>(1);
				answers.add(answer);
				correct = ((ArrayList<Boolean>)currQuestion.areCorrect(answers, username, true, manager)).get(0);
			}
			request.setAttribute("isCorrect", correct);
			request.setAttribute("prevAnswer", answer);
			dispatch = request.getRequestDispatcher("multiple-pages-quiz.jsp");
			
		}
		else{
			multiQuiz.addUserAnswer(questionNum-1, answer);
			multiQuiz.incrementCurrQuestionNum();
			if (request.getParameter("nextQuestion") != null)
				dispatch = request.getRequestDispatcher("multiple-pages-quiz.jsp");
			else{
				long start_num = multiQuiz.getStartTime();
				long quizTime = end_num - start_num;
				request.setAttribute("quizTime", quizTime);
				request.setAttribute("currQuizId", request.getParameter("quizId"));
		
				
				//User user  = (User)request.getSession().getAttribute("currentUser");
				//QuestionManager qManager = (QuestionManager) request.getServletContext().getAttribute("questionManager");
				int score = multiQuiz.getScore(username, manager);
				request.setAttribute("score", score);
				
				request.setAttribute("maxScore", multiQuiz.getNumQuestions());
				request.setAttribute("allUserAnswers", multiQuiz.getUserAnswers());
				request.setAttribute("questions", multiQuiz.getAllQuestions());
				request.setAttribute("isAnswerCorrect", multiQuiz.getIsCorrect());
				
				dispatch = request.getRequestDispatcher("quiz-results.jsp");
			}
		}
		dispatch.forward(request, response);
		doGet(request, response);
	}

}
