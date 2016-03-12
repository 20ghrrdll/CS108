package administration;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class AdminEditQuizServlet
 */
@WebServlet("/AdminEditQuizServlet")
public class AdminEditQuizServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminEditQuizServlet() {
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
		AdminManager adminManager = (AdminManager) getServletContext().getAttribute("adminManager");
		String quizIDs = request.getParameter("quizIDs");
		String buttonAction = request.getParameter("buttonAction");
		if(quizIDs.trim().isEmpty()) {
			response.sendRedirect("admin-page.jsp?invalidQuizzes=empty");
			return;
		}
		
		String[] quizIDList = quizIDs.split("\n");
		for (String quiz : quizIDList) {
			int quizId = Integer.parseInt(quiz.trim());
			if (buttonAction.equals("delete")) {
				if (!adminManager.deleteQuiz(quizId)) {
					response.sendRedirect("admin-page.jsp?error=1");
					return;
				}
			} else if (buttonAction.equals("clearHistory")) {
				if (!adminManager.clearQuizHistory(quizId)) {
					response.sendRedirect("admin-page.jsp?error=1");
					return;
				}
			}
		}
		response.sendRedirect("admin-page.jsp?");
	}

}
