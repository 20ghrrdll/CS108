package quizzes;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class ReviewServlet
 */
@WebServlet("/ReviewServlet")
public class ReviewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReviewServlet() {
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
		String reviewer = request.getParameter("reviewer");
		String quizId = request.getParameter("quizId");
		String rating = request.getParameter("rating");
		String review = request.getParameter("review");
		QuizManager quizManager = (QuizManager) request.getServletContext().getAttribute("quizManager");

		if (!quizManager.addReview(quizId, reviewer, rating, review)) {
			request.setAttribute("error", 1);
		}
		
		response.sendRedirect("quiz-summary-page.jsp?id=" + quizId);

	}

}
