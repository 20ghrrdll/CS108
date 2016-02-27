package users;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class UserCreationServlet
 */
@WebServlet("/UserCreationServlet")
public class UserCreationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserCreationServlet() {
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
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		UserManager userManager = (UserManager) getServletContext().getAttribute("userManager");
		User matchingUser = userManager.getUser(username);
		if (matchingUser != null) {
			request.setAttribute("attempt", "invalid");
			RequestDispatcher dispatch = request.getRequestDispatcher("create-user.jsp");
			dispatch.forward(request, response);
		} else {
			String hashedPassword = userManager.generateHashedPassword(password);
			userManager.addUser(username, hashedPassword);
			// TODO: forward to user welcome homepage; add user somewhere else?
		}
	}

}