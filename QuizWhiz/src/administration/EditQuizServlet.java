package administration;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class EditQuizServelt
 */
@WebServlet("/EditQuizServelt")
public class EditQuizServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EditQuizServlet() {
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
		AdminManager adminManager = (AdminManager) getServletContext().getAttribute("adminManager");
		String quizIDs = request.getParameter("quizIDs");
		String buttonAction = request.getParameter("buttonAction");
		if(quizIDs.trim().isEmpty()) {
			response.sendRedirect("admin-page.jsp?invalidQuizzes=empty");
			return;
		}
		
		String[] quizIDList = buttonAction.split("\n");
		for (String quiz : quizIDList) {
			int quizId = Integer.parseInt(quiz.trim());
			if (buttonAction.equals("delete")) {
				adminManager.deleteQuiz(quizId);
			} else if (buttonAction.equals("clearHistory")) {
				adminManager.clearQuizHistory(quizId);
			}
		}
		response.sendRedirect("admin-page.jsp?");
	}

}
