package messages;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class MessageServlet
 */
@WebServlet("/MessageServlet")
public class MessageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MessageServlet() {
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
		MessageManager messageManager = (MessageManager) getServletContext().getAttribute("messageManager");
		//Marks a note as read
		if(request.getParameter("note") != null){
			messageManager.setAsRead(Integer.parseInt(request.getParameter("messageId")));
			response.sendRedirect("messages.jsp?");
			return;
		//Handles accepting a challenge
		} else if( request.getParameter("challenge") != null){
			messageManager.setAsRead(Integer.parseInt(request.getParameter("messageId")));
			response.sendRedirect("quiz-page.jsp?id="+request.getParameter("quizId"));
		//Handles sending a note to a user
		} else if(request.getParameter("sendNote") != null){
			System.out.println("Hello");
			if(!messageManager.sendMessage(request.getParameter("senderId"), request.getParameter("username"), request.getParameter("subject"), request.getParameter("body"))) {
				request.setAttribute("error", 1);
				response.sendRedirect("index.jsp");
			} else {
				if(request.getParameter("userProfile") != null){
					response.sendRedirect("user-profile.jsp?username="+request.getParameter("username"));
					return;
				}
				response.sendRedirect("messages.jsp?");
				return;
			}
		} else if(request.getParameter("sendChallenge") != null){
			System.out.println("got challenge!");
			response.sendRedirect("user-profile.jsp?username="+request.getParameter("username"));
			return;
		}
	}

}
