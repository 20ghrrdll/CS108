package main;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
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
    	// TODO: close connection
    }

	/**
     * @see ServletContextListener#contextInitialized(ServletContextEvent)
     */
    public void contextInitialized(ServletContextEvent arg0)  { 
    	UserManager userManager = new UserManager();
    	AnnouncementManager announcementManager = new AnnouncementManager();
    	ServletContext context = arg0.getServletContext();
    	context.setAttribute("userManager", userManager);
    	context.setAttribute("announcementManager", announcementManager);
        context.setAttribute("ctx", context.getContextPath());

    }
	
}
