package quizzes;

import java.io.*;
import java.sql.SQLException;
import java.util.*;
import users.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class QuizResultServlet
 */
@WebServlet("/QuizResultServlet")
public class QuizResultServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public QuizResultServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * Creds to
	 * http://www.java2s.com/Tutorials/Java/JSP/0090__JSP_Form_Processing.htm
	 * for the info on how to read all form parameters
	 * 
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		QuizManager manager = (QuizManager) request.getServletContext().getAttribute("quizManager");
		ArrayList<Question> questions;
		try {
			questions = manager.getQuestions(Integer.valueOf("1"));

			int score = 0;
			int maxScore = 0;
			String quizType = request.getParameter("quizType");

			int numQs = questions.size();
			if (!quizType.equals("FillIn")) {
				for (int a = 0; a < numQs; a++) {
					// Question currQ = questions.get(a);
					score += oneAnswer(questions.get(a), request);
					maxScore++;
				}
			}
			else{
				for (int a = 0; a < numQs; a++) {
					// Question currQ = questions.get(a);
					score += oneAnswer(questions.get(a), request);
					maxScore++;
				}
				
			}

			session.setAttribute("score", score);
			session.setAttribute("maxScore", maxScore);
			// int quizId = (Integer)session.getAttribute("quizId");
			User user = (User) session.getAttribute("currentUser");
			if (user != null) {
				// add info to quiz record table
			}

			RequestDispatcher dispatch = request.getRequestDispatcher("quiz-results.jsp");
			dispatch.forward(request, response);
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	private int oneAnswer(Question currQ, HttpServletRequest request) {

		String paramValue = request.getParameter(Integer.toString(currQ.getQuestionId()));
		if (currQ.isCorrect(paramValue))
			return 1;
		return 0;
	}
	
	private int multiAnswer(Question currQ, HttpServletRequest request){
		
		int numAnswers = currQ.
		return 0;
	}

}
