package administration;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class EditUserServlet
 */
@WebServlet("/EditUserServlet")
public class EditUserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EditUserServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		AdminManager adminManager = (AdminManager) getServletContext().getAttribute("adminManager");
		String usernames = request.getParameter("usernames");
		if(usernames.trim().isEmpty()) {
			response.sendRedirect("admin-page.jsp?invalidUsers=empty");
			return;
		}
		
		String action = request.getParameter("action");
		String[] usernamesList = usernames.split("\n");
		for (String username : usernamesList) {
			username = username.trim();
			if (action.equals("delete")) {
				adminManager.deleteUser(username);
			} else if (action.equals("admin")) {
				adminManager.makeAdmin(username);
			}
		}
		response.sendRedirect("admin-page.jsp?");
	}

}
