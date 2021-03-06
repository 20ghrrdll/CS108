package users;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import main.FinalConstants;

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
		if(username.isEmpty()  || password.isEmpty()) {
			response.sendRedirect("create-user.jsp?invalid=empty");
			return;
		}
		UserManager userManager = (UserManager) getServletContext().getAttribute("userManager");
		User matchingUser = userManager.getUser(username);
		if (matchingUser != null) {
			response.sendRedirect("create-user.jsp?invalid=exists");
			return;
		} else {
			if (userManager.addUser(username, password)) {
				//request.getSession().setAttribute("currentUser", userManager.getUser(username));
				Cookie userCookie = new Cookie("CurrentUsername", matchingUser.getUsername());
				userCookie.setMaxAge(60*60);
				response.addCookie(userCookie);
				response.sendRedirect("index.jsp");
			} else {
				request.setAttribute("error", 1);
				response.sendRedirect("create-user.jsp");

			}
		}
	}

}
