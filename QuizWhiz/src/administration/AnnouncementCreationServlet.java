package administration;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import messages.MessageManager;

/**
 * Servlet implementation class AnnouncementCreationServlet
 */
@WebServlet("/AnnouncementCreationServlet")
public class AnnouncementCreationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AnnouncementCreationServlet() {
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
		String subject = request.getParameter("subject");
		String body = request.getParameter("body");
		String username = request.getParameter("creator");
		
		if(subject.isEmpty()  || body.isEmpty()) {
			response.sendRedirect("admin-page.jsp?invalidAnnouncement=empty");
			return;
		}
		AdminManager adminManager = (AdminManager) getServletContext().getAttribute("adminManager");
		adminManager.createAnnouncement(username, subject, body);
		response.sendRedirect("admin-page.jsp?");		
	}

}
