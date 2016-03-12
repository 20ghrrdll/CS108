package users;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class UserPrivacyServlet
 */
@WebServlet("/UserPrivacyServlet")
public class UserPrivacyServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserPrivacyServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String profile = request.getParameter("profile");
		System.out.println(profile);
		String friend = request.getParameter("friend");
		UserManager userManager = (UserManager) request.getServletContext().getAttribute("userManager");
		userManager.setPrivacy("profilePrivacy", request.getParameter("username"), profile);
		userManager.setPrivacy("friendPrivacy", request.getParameter("username"), friend);	
		
		response.sendRedirect("privacy.jsp?updated=true");

		//add a message saying usccessfully updated
	}

}
