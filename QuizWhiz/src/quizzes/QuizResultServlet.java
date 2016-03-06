package quizzes;

import java.io.*;
import java.util.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


/**
 * Servlet implementation class QuizResultServlet
 */
@WebServlet("/QuizResultServlet")
public class QuizResultServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public QuizResultServlet() {
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
	 * Creds to http://www.java2s.com/Tutorials/Java/JSP/0090__JSP_Form_Processing.htm for the info on how to read
	 * all form parameters
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 Enumeration paramNames = request.getParameterNames();
		 HttpSession session = request.getSession();
		 ArrayList<Question> questions = (ArrayList<Question>)session.getAttribute("questions");
		 int score = 0;
		 int maxScore = 0;
		 
		 int numQs = questions.size();
		   while(paramNames.hasMoreElements()) {
		      String paramName = (String)paramNames.nextElement();
		      //out.print("<b>" + paramName + ":</b>\n");
		      String paramValue = request.getHeader(paramName);
		      //out.println(paramValue);
		      for(int a = 0; a < numQs; a++){
		    	  Question currQ = questions.get(a);
		    	  if(currQ.getQuestionId() == Integer.parseInt(paramName)){
		    		  if(currQ.isCorrect(paramValue)) score ++;
		    	  }
		      }
		      maxScore++;
		   }
		   
		   request.setAttribute("score", score);
		   request.setAttribute("maxScore", maxScore);

		   RequestDispatcher dispatch =
				   request.getRequestDispatcher("quiz-results.jsp");
				   dispatch.forward(request, response);
	}

}
