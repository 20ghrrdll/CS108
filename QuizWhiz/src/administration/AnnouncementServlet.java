package administration;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class AnnouncementServlet
 */
@WebServlet("/AnnouncementServlet")
public class AnnouncementServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AnnouncementServlet() {
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
		String buttonAction = request.getParameter("buttonAction");
		AdminManager adminManager = (AdminManager) getServletContext().getAttribute("adminManager");

		if (buttonAction.equals("create")) {
			String subject = request.getParameter("subject");
			String body = request.getParameter("body");
			String username = request.getParameter("creator");
			System.out.println("servlet body: " + body);
			System.out.println("Servlet body: " + java.net.URLDecoder.decode(body, "utf-8"));
			
			if(subject.isEmpty()  || body.isEmpty()) {
				response.sendRedirect("admin-page.jsp?invalidAnnouncement=empty");
				return;
			}
			if (!adminManager.createAnnouncement(username, subject, body)) {
				request.setAttribute("error", 1);
			}
		} else if (buttonAction.equals("delete")) {
			String announcementId = request.getParameter("announcementId");
			if (!adminManager.deleteAnnouncement(Integer.parseInt(announcementId))) {
				request.setAttribute("error", 1);
			}
		}
		
		response.sendRedirect("index.jsp?");
	}

}
