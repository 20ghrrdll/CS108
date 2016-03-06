package main;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

import messages.MessageManager;
import quizzes.QuizManager;
import users.UserManager;

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
    }

	/**
     * @see ServletContextListener#contextInitialized(ServletContextEvent)
     */
    public void contextInitialized(ServletContextEvent arg0)  { 
    	UserManager userManager = new UserManager();
    	AnnouncementManager announcementManager = new AnnouncementManager();
    	QuizManager quizManager = new QuizManager();
        MessageManager messageManager = new MessageManager();
    	ServletContext context = arg0.getServletContext();
    	context.setAttribute("userManager", userManager);
    	context.setAttribute("announcementManager", announcementManager);
    	context.setAttribute("quizManager", quizManager);
        context.setAttribute("messageManager", messageManager);
        context.setAttribute("ctx", context.getContextPath());
    }
	
}
