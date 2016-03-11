package main;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

import messages.MessageManager;
import quizzes.QuestionManager;
import quizzes.QuizManager;
import users.UserManager;
import administration.AdminManager;
import quizzes.MultiplePageQuiz;

/**
 * Application Lifecycle Listener implementation class SiteServletListener
 *
 */
@WebListener
public class SiteServletListener implements ServletContextListener {

    /**
     * Default constructor. 
     */
    public SiteServletListener() {
    }

	/**
     * @see ServletContextListener#contextDestroyed(ServletContextEvent)
     */
    public void contextDestroyed(ServletContextEvent arg0)  { 
    	ServletContext context = arg0.getServletContext();
    	AnnouncementManager announcementManager = (AnnouncementManager) context.getAttribute("announcementManager");
    	announcementManager.closeConnection();
    	UserManager userManager = (UserManager) context.getAttribute("userManager");
    	userManager.closeConnection();
    	QuizManager quizManager = (QuizManager) context.getAttribute("quizManager");
    	quizManager.closeConnection();
        MessageManager messageManager = (MessageManager) context.getAttribute("messageManager");
        messageManager.closeConnection();
        AdminManager adminManager = (AdminManager) context.getAttribute("adminManager");
        adminManager.closeConnection();
        QuestionManager questionManager = (QuestionManager) context.getAttribute("questionManager");
        questionManager.closeConnection();
    }

	/**
     * @see ServletContextListener#contextInitialized(ServletContextEvent)
     */
    public void contextInitialized(ServletContextEvent arg0)  { 
    	UserManager userManager = new UserManager();
    	AnnouncementManager announcementManager = new AnnouncementManager();
    	QuizManager quizManager = new QuizManager();
        MessageManager messageManager = new MessageManager();
        AdminManager adminManager = new AdminManager();
        QuestionManager questionManager = new QuestionManager();
        MultiplePageQuiz multiPage = new MultiplePageQuiz();
;    	ServletContext context = arg0.getServletContext();
    	context.setAttribute("userManager", userManager);
    	context.setAttribute("announcementManager", announcementManager);
    	context.setAttribute("quizManager", quizManager);
        context.setAttribute("messageManager", messageManager);
        context.setAttribute("adminManager", adminManager);
        context.setAttribute("questionManager", questionManager);
        context.setAttribute("multiplePageQuiz", multiPage);
        context.setAttribute("ctx", context.getContextPath());
    }
	
}
