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
			response.sendRedirect("messages.jsp?");
			return;
		} else if( request.getParameter("challenge") != null){
			System.out.println("challenge");
		} else {
			System.out.println("nada");
		}
	}

}
