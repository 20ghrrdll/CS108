package users;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
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
		
		if(username.isEmpty()  || password.isEmpty()) {
			response.sendRedirect("login-page.jsp?invalid=empty");
			return;
		}
		UserManager userManager = (UserManager) getServletContext().getAttribute("userManager");
		User matchingUser = userManager.getUser(username);
		String hashedPassword = userManager.generateHashedPassword(password);
		if (matchingUser == null || !matchingUser.getPassword().equals(hashedPassword)) {
			response.sendRedirect("login-page.jsp?invalid=fail");
			return;
		} else {
			request.setAttribute("currentUser", matchingUser);
			// TODO: go to user homepage
		}
		
	}

}
