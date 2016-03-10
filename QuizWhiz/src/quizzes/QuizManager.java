package quizzes;

import main.DBConnector;
import main.MyDBInfo;

import java.sql.*;
import java.util.ArrayList;

public class QuizManager {

	private static Connection con;
	private QuestionManager questionManager;

	public QuizManager() {
		con = DBConnector.getConnection();
		questionManager = new QuestionManager();
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
				Timestamp created = rs.getTimestamp("created");
				String creator = rs.getString("creatorId");
				QuizType type = QuizType.valueOf(rs.getString("type"));
				boolean practiceMode = rs.getBoolean("practiceMode");
				boolean multiplePages = rs.getBoolean("pages");
				boolean random = rs.getBoolean("random");
				boolean immediateCorrection = rs.getBoolean("correction");
				quiz = new Quiz(quizID, name, description, created, creator, type, practiceMode, multiplePages, random, immediateCorrection);
			}
		} catch (SQLException e) {
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
		try {
			Statement stmt = con.createStatement();
			String query = "SELECT * FROM " + MyDBInfo.QUESTION_TABLE +" WHERE quizId='" + quizId + "';";
			ResultSet rs = stmt.executeQuery(query);
			while (rs.next()) {
				int quizID = rs.getInt("quizId");
				int questionID = rs.getInt("questionId");
				String questionText = rs.getString("questionText");
				String correctAnswer = rs.getString("correctAnswer");
				int numAnswers = rs.getInt("numAnswers");
				ArrayList<String> correctAnswers;
				if(numAnswers > 1){
					correctAnswers = questionManager.getAllAnswers(Integer.toString(quizID), Integer.toString(questionID));
				}
				else correctAnswers = null;
				Question question = new Question(quizID, questionID, questionText, correctAnswer, numAnswers, correctAnswers);
				questions.add(question);
			}
		}
		catch(SQLException e){
			e.printStackTrace();

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
				Timestamp created = rs.getTimestamp("created");
				String creator = rs.getString("creatorId");
				QuizType type = QuizType.valueOf(rs.getString("type"));
				boolean practiceMode = rs.getBoolean("practiceMode");
				boolean multiplePages = rs.getBoolean("pages");
				boolean random = rs.getBoolean("random");
				boolean immediateCorrection = rs.getBoolean("correction");
				Quiz quiz = new Quiz(quizID, name, description, created, creator, type, practiceMode, multiplePages, random, immediateCorrection);
				quizzes.add(quiz);
			}
		} catch (SQLException e) {
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
				Timestamp created = rs.getTimestamp("created");
				String creator = rs.getString("creatorId");
				QuizType type = QuizType.valueOf(rs.getString("type"));
				boolean practiceMode = rs.getBoolean("practiceMode");
				boolean multiplePages = rs.getBoolean("pages");
				boolean random = rs.getBoolean("random");
				boolean immediateCorrection = rs.getBoolean("correction");
				Quiz quiz = new Quiz(quizID, name, description, created, creator, type, practiceMode, multiplePages, random, immediateCorrection);
				quizzes.add(quiz);
			}
		} catch (SQLException e) {
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
			Timestamp created = rs.getTimestamp("created");
			String creator = rs.getString("creatorId");
			QuizType type = QuizType.valueOf(rs.getString("type"));
			boolean practiceMode = rs.getBoolean("practiceMode");
			boolean multiplePages = rs.getBoolean("pages");
			boolean random = rs.getBoolean("random");
			boolean immediateCorrection = rs.getBoolean("correction");
			Quiz quiz = new Quiz(quizID, name, description, created, creator, type, practiceMode, multiplePages, random, immediateCorrection);
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
			Timestamp created = rs.getTimestamp("created");
			String creator = rs.getString("creatorId");
			QuizType type = QuizType.valueOf(rs.getString("type"));
			boolean practiceMode = rs.getBoolean("practiceMode");
			boolean multiplePages = rs.getBoolean("pages");
			boolean random = rs.getBoolean("random");
			boolean immediateCorrection = rs.getBoolean("correction");
			Quiz quiz = new Quiz(quizID, name, description, created, creator, type, practiceMode, multiplePages, random, immediateCorrection);
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
			Timestamp created = rs.getTimestamp("created");
			String creator = rs.getString("creatorId");
			QuizType type = QuizType.valueOf(rs.getString("type"));
			boolean practiceMode = rs.getBoolean("practiceMode");
			boolean multiplePages = rs.getBoolean("pages");
			boolean random = rs.getBoolean("random");
			boolean immediateCorrection = rs.getBoolean("correction");
			Quiz quiz = new Quiz(quizID, name, description, created, creator, type, practiceMode, multiplePages, random, immediateCorrection);
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

	public ArrayList<QuizPerformance> getMyRecentlyTakenQuizPerformance (String username, int quizId) throws SQLException {
		ArrayList<QuizPerformance> recentlyTaken = new ArrayList<QuizPerformance>();
		Statement stmt = con.createStatement();		
		String query = "SELECT * FROM " + MyDBInfo.QUIZ_RECORDS_TABLE +" WHERE quizId='" + quizId + "' AND userId='"+ username + "' ORDER BY end_time DESC;";
		System.out.println("got here");
		System.out.println(query);
		ResultSet rs = stmt.executeQuery(query);
		while (rs.next()) {
			String name = rs.getString("userId");
			int score = rs.getInt("score");
			Timestamp start_time = rs.getTimestamp("start_time");
			Timestamp end_time = rs.getTimestamp("end_time");

			recentlyTaken.add(new QuizPerformance(name, score, start_time, end_time));
		}

		return recentlyTaken;	
	}



	public ArrayList<QuizPerformance> getQuizHighScores(int quizId) throws SQLException {
		ArrayList<QuizPerformance> highScores = new ArrayList<QuizPerformance>();
		Statement stmt = con.createStatement();		
		String query = "SELECT * FROM " + MyDBInfo.QUIZ_RECORDS_TABLE +" WHERE quizId='" + quizId + "' ORDER BY score DESC;";

		System.out.println(query);
		ResultSet rs = stmt.executeQuery(query);
		while (rs.next()) {
			String name = rs.getString("userId");
			int score = rs.getInt("score");
			Timestamp start_time = rs.getTimestamp("start_time");
			Timestamp end_time = rs.getTimestamp("end_time");

			highScores.add(new QuizPerformance(name, score, start_time, end_time));
		}

		return highScores;
	} 

	public ArrayList<QuizPerformance> getQuizPerformances(int quizId) throws SQLException {
		ArrayList<QuizPerformance> highScores = new ArrayList<QuizPerformance>();
		Statement stmt = con.createStatement();		
		String query = "SELECT * FROM " + MyDBInfo.QUIZ_RECORDS_TABLE +" WHERE quizId='" + quizId + "' ORDER BY end_time DESC;";

		System.out.println(query);
		ResultSet rs = stmt.executeQuery(query);
		while (rs.next()) {
			String name = rs.getString("userId");
			int score = rs.getInt("score");
			Timestamp start_time = rs.getTimestamp("start_time");
			Timestamp end_time = rs.getTimestamp("end_time");

			highScores.add(new QuizPerformance(name, score, start_time, end_time));
		}

		return highScores;
	} 


	public void insertQuiz(Quiz quiz) {
		/* String query = "INSERT INTO " + MyDBInfo.QUIZ_TABLE + " (name, description, created, creatorId"
				+ ", practiceMode, pages, random, correction, type, amountTaken)" + 
				" VALUES ("+ '"+name+"' + ", " + description + ", " + created + ", " + creatorId + ", " + practice + ", " +
				pages + ", " + random + ", " + correction + ", " + quizType + ", 0);"; */
		String query = "INSERT INTO " + MyDBInfo.QUIZ_TABLE + " (name, description, created, creatorId"
				+ ", practiceMode, pages, random, correction, type, amountTaken)" + 
				" VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

		System.out.println(query);
		try {
			PreparedStatement s = con.prepareStatement(query);
			s.setString(1, quiz.getQuizName());
			s.setString(2, quiz.getQuizDescription());
			s.setTimestamp(3, quiz.getTimeCreated());
			s.setString(4, quiz.getQuizCreator());
			s.setBoolean(5, quiz.hasPracticeMode());
			s.setBoolean(6, quiz.displayMultiplePages());
			s.setBoolean(7, quiz.randomOrder());
			s.setBoolean(8, quiz.hasImmediateCorrection());
			s.setString(9, quiz.getQuizType().name());
			s.setInt(10, 0);
			System.out.println(s.toString());
			s.executeUpdate();
		} catch (SQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
	}

	public void closeConnection() {
		DBConnector.closeConnection();
	}

}
