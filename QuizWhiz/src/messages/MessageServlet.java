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
		// TODO Auto-generated method stub
//		 MyClass myClass = new MyClass();
//
//	        if (request.getParameter("button1") != null) {
//	            myClass.method1();
//	        } else if (request.getParameter("button2") != null) {
//	            myClass.method2();
//	        } else if (request.getParameter("button3") != null) {
//	            myClass.method3();
//	        } else {
//	            // ???
//	        }
		MessageManager messageManager = (MessageManager) getServletContext().getAttribute("messageManager");
		
		if(request.getParameter("note") != null){
			messageManager.setAsRead(Integer.parseInt(request.getParameter("messageId")));
			response.sendRedirect("messages.jsp?");
			return;
		} else if( request.getParameter("challenge") != null){
			messageManager.setAsRead(Integer.parseInt(request.getParameter("messageId")));
			response.sendRedirect("quiz-page.jsp?quizId="+request.getParameter("quizId"));

		} else if(request.getParameter("username") != null){
			
			System.out.println(request.getParameter("username"));
			System.out.println(request.getParameter("subject"));
			System.out.println(request.getParameter("body"));
			response.sendRedirect("messages.jsp?");

		}
	}

}
