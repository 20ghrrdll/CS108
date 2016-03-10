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
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		QuizManager manager = (QuizManager) request.getServletContext().getAttribute("quizManager");
		ArrayList<Question> questions;
		try {
			int quizId = (Integer)session.getAttribute("currQuizId");
			questions = manager.getQuestions(quizId);

			int score = 0;
			int maxScore = 0;
			String quizType = request.getParameter("quizType");

			int numQs = questions.size();
			if (!quizType.equals("FillIn")) {
				for (int a = 0; a < numQs; a++) {
					// Question currQ = questions.get(a);
					score+= oneAnswer(questions.get(a), request);
					maxScore++;
				}
			}
			else{
				for (int a = 0; a < numQs; a++) {
					Question currQ = questions.get(a);
					score += multiAnswer(currQ, request);
					maxScore+= currQ.getNumAnswers();
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

	public int oneAnswer(Question currQ, HttpServletRequest request) {

		String paramValue = request.getParameter(Integer.toString(currQ.getQuestionId()));
		System.out.println(paramValue);
		if (currQ.isCorrect(paramValue))
			return 1;
		return 0;
	}
	
	private int multiAnswer(Question currQ, HttpServletRequest request){
		
		int numCorrect = 0;
		int numAnswers = currQ.getNumAnswers();
		ArrayList<String> userAnswers = new ArrayList<String>(numAnswers);
		String qId = Integer.toString(currQ.getQuestionId());
		for(int a = 0; a < numAnswers; a++){
			String answerID = qId+"-"+Integer.toString(a);
			//System.out.println(answerID);
			String answer = request.getParameter(answerID);
			//System.out.println(answer);
			userAnswers.add(answer);
		}
		ArrayList<Boolean> results = currQ.areCorrect(userAnswers);
		for(int b = 0; b < results.size(); b++){
			if(results.get(b) == true) numCorrect++;
		}
		return numCorrect;
	}

}
