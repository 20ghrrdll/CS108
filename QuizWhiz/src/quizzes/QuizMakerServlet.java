package quizzes;

import java.io.IOException;
import java.sql.*;
import java.util.Calendar;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import users.User;
import users.UserManager;
import main.FinalConstants;

/**
 * Servlet implementation class QuizMakerServlet
 */
@WebServlet("/QuizMakerServlet")
public class QuizMakerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public QuizMakerServlet() {
		super();
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
		java.util.Date date = new java.util.Date();
		Timestamp created = new Timestamp(date.getTime());

		String quizName = request.getParameter("quizName");
		String quizDescription = request.getParameter("quizDescription");
		String category = request.getParameter("quizCategory");


		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("currentUser");
		String quizCreator = user.getUsername();

		QuizType quizType = null;
		//TODO: Expand to all quiz types
		if (request.getParameter("quizType").equals("QuestionResponse")) quizType = QuizType.QuestionResponse;
		if (request.getParameter("quizType").equals("FillIn")) quizType = QuizType.FillIn;
		if (request.getParameter("quizType").equals("MultipleChoice")) quizType = QuizType.MultipleChoice;
		if (request.getParameter("quizType").equals("PictureResponse")) quizType = QuizType.PictureResponse;


		boolean hasPracticeMode = false;
		if (request.getParameter("practice").equals("y")) hasPracticeMode = true;
		boolean hasMultiplePages = false;
		if (request.getParameter("pages").equals("multiple")) hasMultiplePages = true;
		boolean hasRandomOrder = false;
		if (request.getParameter("randomOrder").equals("y")) hasRandomOrder = true;
		boolean hasImmediateCorrection = false;
		if (request.getParameter("correction").equals("immediate")) hasImmediateCorrection = true;

		QuizManager quizManager = (QuizManager) request.getServletContext().getAttribute("quizManager");
		Quiz quiz = new Quiz(quizName, quizDescription, category, created, quizCreator, quizType, hasPracticeMode, hasMultiplePages, hasRandomOrder, hasImmediateCorrection);

		int quizId = quizManager.insertQuiz(quiz);
		if (quizId == -1) {
			request.setAttribute("error", 1);
			response.sendRedirect("admin-page.jsp?");
		} else {
			quiz.setQuizId(quizId);


			UserManager userManager = (UserManager) request.getServletContext().getAttribute("userManager");
			if (quizManager.getMyQuizzes(quizCreator).size() == 1) {
				userManager.addAchievement(quizCreator, FinalConstants.CREATE_1);
			} else if (quizManager.getMyQuizzes(quizCreator).size() == 5) {
				userManager.addAchievement(quizCreator, FinalConstants.CREATE_5);
			} else if (quizManager.getMyQuizzes(quizCreator).size() == 10) {
				userManager.addAchievement(quizCreator, FinalConstants.CREATE_10);
			}

			request.setAttribute("quiz", quiz);
			RequestDispatcher d = request.getRequestDispatcher("add-questions.jsp");
			d.forward(request, response); 
		}

	}




}
