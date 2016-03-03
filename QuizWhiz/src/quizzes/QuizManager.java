package quizzes;

import main.DBConnector;
import main.MyDBInfo;

import java.sql.*;
import java.util.ArrayList;

public class QuizManager {

	private static Connection con;;
	
	public QuizManager() {
		con = DBConnector.getConnection();
	}
	
	/**
	 * Returns a Quiz with the given quizId
	 * @return Quiz
	 */
	public Quiz getQuiz(int quizId){
		Quiz quiz = null;
		try {
			Statement stmt = con.createStatement();
			String query = "SELECT * FROM " + MyDBInfo.QUIZ_TABLE + " WHERE quizId='" + quizId + "';";
			ResultSet rs = stmt.executeQuery(query);
			while (rs.next()) {
				int quizID = rs.getInt("quizID");
				String name = rs.getString("name");
				String description = rs.getString("description");
				String creator = rs.getString("creatorId");
				String type = rs.getString("type");
				boolean practiceMode = rs.getBoolean("practiceMode");
				boolean multiplePages = rs.getBoolean("pages");
				boolean random = rs.getBoolean("random");
				boolean immediateCorrection = rs.getBoolean("correction");
				quiz = new Quiz(quizID, name, description, creator, type, practiceMode, multiplePages, random, immediateCorrection);
			}
		} catch (SQLException e) {
			e.printStackTrace(); // TODO: what to do here
		}
		return quiz;
	}
	
	
	/**
	 * Returns an ArrayList of questions associated with the given quizId
	 * @param quizId
	 * @return ArrayList of Question objects
	 */
	public ArrayList<Question> getQuestions(int quizId) throws SQLException{
		ArrayList<Question> questions = new ArrayList<Question>();
		Statement stmt = con.createStatement();
		String query = "SELECT * FROM " + MyDBInfo.QUESTION_TABLE +" WHERE quizId='" + quizId + "';";
		ResultSet rs = stmt.executeQuery(query);
		while (rs.next()) {
			int quizID = rs.getInt("quizId");
			int questionId = rs.getInt("questionId");
			String questionText = rs.getString("questionText");
			String correctAnswer = rs.getString("correctAnswer");
			int order = rs.getInt("questionOrder");
			Question question = new Question(quizID, questionId, questionText, correctAnswer, order);
			questions.add(question);
		}
		return questions;
	}
	
	
	/**
	 * Returns Quiz objects for every quiz currently stored in the database.
	 * @return ArrayList of Quiz objects
	 */
	public ArrayList<Quiz> getAllQuizzes() {
		ArrayList<Quiz> quizzes = new ArrayList<Quiz>();
		try {
			Statement stmt = con.createStatement();
			String query = "SELECT * FROM " + MyDBInfo.QUIZ_TABLE +";";
			ResultSet rs = stmt.executeQuery(query);
			
			while (rs.next()) {
				int quizID = rs.getInt("quizID");
				String name = rs.getString("name");
				String description = rs.getString("description");
				String creator = rs.getString("creatorId");
				String type = rs.getString("type");
				boolean practiceMode = rs.getBoolean("practiceMode");
				boolean multiplePages = rs.getBoolean("pages");
				boolean random = rs.getBoolean("random");
				boolean immediateCorrection = rs.getBoolean("correction");
				Quiz quiz = new Quiz(quizID, name, description, creator, type, practiceMode, multiplePages, random, immediateCorrection);
				quizzes.add(quiz);
			}
		} catch (SQLException e) {
			e.printStackTrace(); // TODO: what to do here
		}
		return quizzes;
	}
	
	
	/**
	 * Returns an array list of the most popular quizes
	 * @return ArrayList of Quiz objects
	 */
	public ArrayList<Quiz> getPopularQuizzes(){
		ArrayList<Quiz> quizzes = new ArrayList<Quiz>();
		try {
			Statement stmt = con.createStatement();		
			String query = "SELECT * FROM " + MyDBInfo.QUIZ_TABLE +" ORDER BY amountTaken DESC;";
			ResultSet rs = stmt.executeQuery(query);
			
			while (rs.next()) {
				int quizID = rs.getInt("quizID");
				String name = rs.getString("name");
				String description = rs.getString("description");
				String creator = rs.getString("creatorId");
				String type = rs.getString("type");
				boolean practiceMode = rs.getBoolean("practiceMode");
				boolean multiplePages = rs.getBoolean("pages");
				boolean random = rs.getBoolean("random");
				boolean immediateCorrection = rs.getBoolean("correction");
				Quiz quiz = new Quiz(quizID, name, description, creator, type, practiceMode, multiplePages, random, immediateCorrection);
				quizzes.add(quiz);
			}
		} catch (SQLException e) {
			e.printStackTrace(); // TODO: what to do here
		}
		
		return quizzes;
	}
	
	
	/**
	 * Returns a list of recently created quizzes.
	 * @return ArrayList of recently created quizzes
	 * @throws SQLException
	 */
	public ArrayList<Quiz> getRecentlyCreatedQuizzes() throws SQLException {
		ArrayList<Quiz> quizzes = new ArrayList<Quiz>();
			Statement stmt = con.createStatement();		
			String query = "SELECT * FROM " + MyDBInfo.QUIZ_TABLE +" ORDER BY created DESC;";
			ResultSet rs = stmt.executeQuery(query);
			
			while (rs.next()) {
				int quizID = rs.getInt("quizID");
				String name = rs.getString("name");
				String description = rs.getString("description");
				String creator = rs.getString("creatorId");
				String type = rs.getString("type");
				boolean practiceMode = rs.getBoolean("practiceMode");
				boolean multiplePages = rs.getBoolean("pages");
				boolean random = rs.getBoolean("random");
				boolean immediateCorrection = rs.getBoolean("correction");
				Quiz quiz = new Quiz(quizID, name, description, creator, type, practiceMode, multiplePages, random, immediateCorrection);
				quizzes.add(quiz);
			}
		return quizzes;
	}
	
	
	/**
	 * Returns a list of quizzes that have been recently taken by users
	 * @return ArrayList of recently taken quizzes
	 * @throws SQLException
	 */
	public ArrayList<Quiz> getRecentlyTakenQuizzes() throws SQLException {
		ArrayList<Quiz> quizzes = new ArrayList<Quiz>();
			Statement stmt = con.createStatement();		
			String query = "SELECT * FROM " + MyDBInfo.QUIZ_RECORDS_TABLE +" ORDER BY end_time DESC;";
			ResultSet rs = stmt.executeQuery(query);
			
			while (rs.next()) {
				int quizID = rs.getInt("quizID");
				Quiz quiz = getQuiz(quizID);
				quizzes.add(quiz);
			}
		return quizzes;
	}
	
	
	/**
	 * Returns a list of quizzes created by a given user
	 * @param username
	 * @return ArrayList of quizzes created by a given user
	 * @throws SQLException
	 */
	public ArrayList<Quiz> getMyQuizzes(String username) throws SQLException {
		ArrayList<Quiz> quizzes = new ArrayList<Quiz>();
			Statement stmt = con.createStatement();
			String query = "SELECT * FROM " + MyDBInfo.QUIZ_TABLE +" WHERE creatorId='"+username +"';";
			ResultSet rs = stmt.executeQuery(query);
			
			while (rs.next()) {
				int quizID = rs.getInt("quizID");
				String name = rs.getString("name");
				String description = rs.getString("description");
				String creator = rs.getString("creatorId");
				String type = rs.getString("type");
				boolean practiceMode = rs.getBoolean("practiceMode");
				boolean multiplePages = rs.getBoolean("pages");
				boolean random = rs.getBoolean("random");
				boolean immediateCorrection = rs.getBoolean("correction");
				Quiz quiz = new Quiz(quizID, name, description, creator, type, practiceMode, multiplePages, random, immediateCorrection);
				quizzes.add(quiz);
			}
		return quizzes;
	}
	
	public ArrayList<Quiz> getMyRecentQuizzes(String username) throws SQLException {
		ArrayList<Quiz> quizzes = new ArrayList<Quiz>();
			Statement stmt = con.createStatement();		
			String query = "SELECT * FROM " + MyDBInfo.QUIZ_TABLE +" WHERE creatorId='"+username +"' ORDER BY 'end_time' DESC;";
			ResultSet rs = stmt.executeQuery(query);
			
			while (rs.next()) {
				int quizID = rs.getInt("quizID");
				String name = rs.getString("name");
				String description = rs.getString("description");
				String creator = rs.getString("creatorId");
				String type = rs.getString("type");
				boolean practiceMode = rs.getBoolean("practiceMode");
				boolean multiplePages = rs.getBoolean("pages");
				boolean random = rs.getBoolean("random");
				boolean immediateCorrection = rs.getBoolean("correction");
				Quiz quiz = new Quiz(quizID, name, description, creator, type, practiceMode, multiplePages, random, immediateCorrection);
				quizzes.add(quiz);
			}
		return quizzes;
	}
	
	public ArrayList<Quiz> getMyRecentlyTakenQuizzes(String username) throws SQLException {
		ArrayList<Quiz> quizzes = new ArrayList<Quiz>();
			Statement stmt = con.createStatement();		
			String query = "SELECT * FROM " + MyDBInfo.QUIZ_RECORDS_TABLE +" WHERE userId='" + username + "' ORDER BY end_time DESC;";
			ResultSet rs = stmt.executeQuery(query);
			
			while (rs.next()) {
				int quizID = rs.getInt("quizID");
				Quiz quiz = getQuiz(quizID);
				quizzes.add(quiz);
			}
		return quizzes;
	}
	
	
	
	
	
	public void closeConnection() {
		DBConnector.closeConnection();
	}
	
}
