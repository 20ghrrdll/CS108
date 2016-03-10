package users;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import main.FinalConstants;

/**
 * Servlet implementation class FriendRequestServlet
 */
@WebServlet("/FriendRequestServlet")
public class FriendRequestServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FriendRequestServlet() {
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
		// TODO Auto-generated method stub
		UserManager userManager = (UserManager) getServletContext().getAttribute("userManager");
		if(request.getParameter("Accept") != null){
			System.out.println("Accept");
			System.out.println(request.getParameter("id"));
			userManager.handleFriendResponse(request.getParameter("id"), request.getParameter("userId"), true);
			if (userManager.getFriends(request.getParameter("userId")).size() == 10) {
				userManager.addAchievement(request.getParameter("userId"), FinalConstants.FRIENDS_10);
				request.setAttribute("achievement", FinalConstants.FRIENDS_10);
			}
			if (userManager.getFriends(request.getParameter("id")).size() == 10) {
				userManager.addAchievement(request.getParameter("id"), FinalConstants.FRIENDS_10);
			}
			
			response.sendRedirect("friends.jsp?");
			return;
		} else if(request.getParameter("Ignore") != null){
			System.out.println("Ignore");
			System.out.println(request.getParameter("id"));
			userManager.handleFriendResponse(request.getParameter("id"), request.getParameter("userId"), false);
			response.sendRedirect("friends.jsp?");
			return;
		} else {
			String user1 = request.getParameter("user1");
			String user2 = request.getParameter("user2");
			if (userManager.getUser(user2) != null) {
				userManager.sendFriendRequest(user1, user2);
				response.sendRedirect("user-profile.jsp?username="+user2);
				return;
			} else {
				request.setAttribute("error", 1);
				response.sendRedirect("index.jsp");
			}
		}
	}

}
