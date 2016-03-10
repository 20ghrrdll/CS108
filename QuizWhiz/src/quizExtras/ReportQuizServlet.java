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
		QuizManager quizManager = (QuizManager) request.getServletContext().getAttribute("quizManager");
		String quizId = request.getParameter("quizId");
		String reporter = request.getParameter("reporter");
		if (!quizManager.addReportedQuiz(Integer.parseInt(quizId), reporter)) {
			request.setAttribute("error", 1);
		}
		response.sendRedirect("quiz-summary-page.jsp?id=" + quizId);
	}

}
