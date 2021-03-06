package quizExtras;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import quizzes.QuizManager;

/**
 * Servlet implementation class ReportQuizServlet
 */
@WebServlet("/ReportQuizServlet")
public class ReportQuizServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReportQuizServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		QuizManager quizManager = (QuizManager) request.getServletContext().getAttribute("quizManager");
		String quizId = request.getParameter("quizId");
		String reporter = request.getParameter("reporter");
		if (!quizManager.addReportedQuiz(Integer.parseInt(quizId), reporter)) {
			response.sendRedirect("quiz-summary-page.jsp?id=" + quizId + "&error=1");
			return;
		} else {
			response.sendRedirect("quiz-summary-page.jsp?id=" + quizId + "&reported=1");
			return;
		}
	}

}
