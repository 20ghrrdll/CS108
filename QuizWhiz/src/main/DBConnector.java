package main;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class DBConnector {
	
	private static final String MYSQL_USERNAME = MyDBInfo.MYSQL_USERNAME;
	private static final String MYSQL_PASSWORD  = MyDBInfo.MYSQL_PASSWORD;
	private static final String MYSQL_DATABASE_SERVER = MyDBInfo.MYSQL_DATABASE_SERVER;
	private static final String MYSQL_DATABASE_NAME = MyDBInfo.MYSQL_DATABASE_NAME;
	private static Connection con = null;
	
	public DBConnector(){
		
	}
	
	/**
	* Attempts to establish a connection the mysql database using the jdbc driver. Throws an exception
	* if failure. 
	* @return Connection with the database
	*/
	public static Connection getConnection() {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection
					( "jdbc:mysql://" + MYSQL_DATABASE_SERVER, MYSQL_USERNAME, MYSQL_PASSWORD);
			Statement stmt = con.createStatement();
			stmt.executeQuery("USE " + MYSQL_DATABASE_NAME);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		return con;
	}
	
	/**
	* Attempts to close the connection. This is called when the window is closed. Throws an exception
	* if failure. 
	*/
	public static void closeConnection() {
		try {
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
