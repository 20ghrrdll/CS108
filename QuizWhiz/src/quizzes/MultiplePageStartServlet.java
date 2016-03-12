package quizzes;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class MultiplePageServlet
 */
@WebServlet("/MultiplePageStartServlet")
public class MultiplePageStartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MultiplePageStartServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		int quizID = Integer.parseInt(request.getParameter("quizId"));
		QuizManager manager = (QuizManager) request.getServletContext().getAttribute("quizManager");
		MultiplePageQuiz multi = (MultiplePageQuiz) request.getServletContext().getAttribute("multiplePageQuiz");
		request.setAttribute("questionNum", new Integer(1));
		try {
			Quiz theQuiz = manager.getQuiz(quizID);
			QuizType type = theQuiz.getQuizType();
			ArrayList<Question> newQuestions = manager.getQuestions(quizID);
			multi.setQuestionList(newQuestions, theQuiz.randomOrder(), theQuiz.hasImmediateCorrection(), type.toString());
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		RequestDispatcher dispatch = request.getRequestDispatcher("multiple-pages-quiz.jsp");
		dispatch.forward(request, response);
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
