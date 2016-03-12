package administration;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import quizzes.QuizManager;

/**
 * Servlet implementation class HandleReportedQuizServlet
 */
@WebServlet("/HandleReportedQuizServlet")
public class HandleReportedQuizServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public HandleReportedQuizServlet() {
        super();
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
		AdminManager adminManager = (AdminManager) request.getServletContext().getAttribute("adminManager");
		String buttonAction = request.getParameter("buttonAction");
		int quizId = Integer.parseInt(request.getParameter("quizId"));
		
		if (buttonAction.equals("delete")) {
			if (!adminManager.deleteReportedQuiz(quizId)) {
				response.sendRedirect("admin-page.jsp?error=1");
				return;
			}
		} else if (buttonAction.equals("ignore")) {
			if (!adminManager.ignoreReportedQuiz(quizId)) {
				response.sendRedirect("admin-page.jsp?error=1");
				return;
			}
		}
		response.sendRedirect("admin-page.jsp?");		
	}

}
