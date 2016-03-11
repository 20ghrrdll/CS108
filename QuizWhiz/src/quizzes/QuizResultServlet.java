package quizzes;

import java.io.*;
import java.sql.Date;
import java.sql.SQLException;
import java.util.*;
import users.*;
import main.FinalConstants;

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
	public ArrayList<String> allUserAnswers;
	public ArrayList<String> allCorrectAnswers;
	public ArrayList<Boolean> isAnswerCorrect;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public QuizResultServlet() {
		super();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		Date end_time = new Date(System.currentTimeMillis());
		allUserAnswers = new ArrayList<String>();
		HttpSession session = request.getSession();
		QuizManager manager = (QuizManager) request.getServletContext().getAttribute("quizManager");
		UserManager userManager = (UserManager) request.getServletContext().getAttribute("userManager");
		QuestionManager questionManager = (QuestionManager)request.getServletContext().getAttribute("questionManager");
		ArrayList<Question> questions;
		isAnswerCorrect = new ArrayList<Boolean>();
		try {
			//get quiz and question parameters
			int quizId = (Integer)session.getAttribute("currQuizId");
			User user = (User)session.getAttribute("currentUser");
			String userId = user.getUsername();
			questions = manager.getQuestions(quizId);
			String practiceModeBool = request.getParameter("practiceMode");
			boolean practiceMode;
			if(practiceModeBool.equals("false")){
				practiceMode = false;
			}
			else practiceMode = true;
			

			int score = 0;
			int maxScore = 0;
			String quizType = request.getParameter("quizType");

			int numQs = questions.size();
			if (!quizType.equals("FillIn")) {
				for (int a = 0; a < numQs; a++) {
					score+= oneAnswer(questions.get(a), request, questionManager,userId, practiceMode);
					maxScore++;
				}
			}
			else{
				for (int a = 0; a < numQs; a++) {
					Question currQ = questions.get(a);
					score += multiAnswer(currQ, questionManager, practiceMode, userId, request);
					maxScore+= currQ.getNumAnswers();
				}
				
			}

			request.setAttribute("score", score);
			request.setAttribute("maxScore", maxScore);
			request.setAttribute("allUserAnswers", allUserAnswers);
			request.setAttribute("questions", questions);
			request.setAttribute("isAnswerCorrect", isAnswerCorrect);
			
			/*** NOTE THAT THERE IS CURRENTLY NO WAY TO INDICATE THAT THIS QUIZ IS BEING TAKEN IN PRACTICE MODE***/
			//if (practiceMode) {
				long start_num = (Long)session.getAttribute("startTime");
				Date start_time = new Date(start_num);
				manager.addQuizRecord(quizId, userId, start_time, end_time, score, maxScore);
				ArrayList<Quiz> quizzesTaken = manager.getMyQuizzes(userId);
				if (quizzesTaken.size() == 1) {
					userManager.addAchievement(userId, FinalConstants.TOOK_1);
				} else if (quizzesTaken.size() == 10) {
					userManager.addAchievement(userId, FinalConstants.TOOK_10);
				}
				//}

			RequestDispatcher dispatch = request.getRequestDispatcher("quiz-results.jsp");
			dispatch.forward(request, response);
		} catch (NumberFormatException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}

	}

	public int oneAnswer(Question currQ, HttpServletRequest request, QuestionManager manager, String userID, boolean practiceMode) {

		String answer = request.getParameter(Integer.toString(currQ.getQuestionId()));
		this.allUserAnswers.add(answer);
		if (currQ.isCorrect(answer,userID, practiceMode, manager)){
			isAnswerCorrect.add(true);
			return 1;
		}
		else isAnswerCorrect.add(false);
		return 0;
	}
	
	private int multiAnswer(Question currQ, QuestionManager manager, boolean practiceMode, String userID, HttpServletRequest request){
		
		//note that practice needs to be passed in in reality.
		int numCorrect = 0;
		int numAnswers = currQ.getNumAnswers();
		ArrayList<String> userAnswers = new ArrayList<String>(numAnswers);
		String qId = Integer.toString(currQ.getQuestionId());
		for(int a = 0; a < numAnswers; a++){
			String answerID = qId+"-"+Integer.toString(a);
			String answer = request.getParameter(answerID);
			userAnswers.add(answer);
		}
		ArrayList<Boolean> results = currQ.areCorrect(userAnswers, userID, practiceMode, manager);
		boolean allCorrect = true;
		for(int b = 0; b < results.size(); b++){
			if(results.get(b) == true) numCorrect++;
			else allCorrect = false;
		}
		if(allCorrect) isAnswerCorrect.add(true);
		else isAnswerCorrect.add(false);
		this.allUserAnswers.addAll(userAnswers);
		return numCorrect;
	}

}
