package quizzes;

import main.DBConnector;
import main.MyDBInfo;
import quizExtras.*;
import java.sql.*;
import java.util.ArrayList;

import javax.print.attribute.SetOfIntegerSyntax;

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
				String category = rs.getString("category");
				Timestamp created = rs.getTimestamp("created");
				String creator = rs.getString("creatorId");
				QuizType type = QuizType.valueOf(rs.getString("type"));
				boolean practiceMode = rs.getBoolean("practiceMode");
				boolean multiplePages = rs.getBoolean("pages");
				boolean random = rs.getBoolean("random");
				boolean immediateCorrection = rs.getBoolean("correction");
				quiz = new Quiz(quizID, name, description, category, created, creator, type, practiceMode, multiplePages, random, immediateCorrection);
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
				
				//for (int i = 0; i < correctAnswers.l)
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
				String category = rs.getString("category");

				Timestamp created = rs.getTimestamp("created");
				String creator = rs.getString("creatorId");
				QuizType type = QuizType.valueOf(rs.getString("type"));
				boolean practiceMode = rs.getBoolean("practiceMode");
				boolean multiplePages = rs.getBoolean("pages");
				boolean random = rs.getBoolean("random");
				boolean immediateCorrection = rs.getBoolean("correction");
				Quiz quiz = new Quiz(quizID, name, description, category, created, creator, type, practiceMode, multiplePages, random, immediateCorrection);
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
				String category = rs.getString("category");
				Timestamp created = rs.getTimestamp("created");
				String creator = rs.getString("creatorId");
				QuizType type = QuizType.valueOf(rs.getString("type"));
				boolean practiceMode = rs.getBoolean("practiceMode");
				boolean multiplePages = rs.getBoolean("pages");
				boolean random = rs.getBoolean("random");
				boolean immediateCorrection = rs.getBoolean("correction");
				Quiz quiz = new Quiz(quizID, name, description, category, created, creator, type, practiceMode, multiplePages, random, immediateCorrection);
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
	public ArrayList<Quiz> getRecentlyCreatedQuizzes() {
		ArrayList<Quiz> quizzes = new ArrayList<Quiz>();
		try {
			Statement stmt = con.createStatement();		
			String query = "SELECT * FROM " + MyDBInfo.QUIZ_TABLE +" ORDER BY created DESC;";
			ResultSet rs = stmt.executeQuery(query);
	
			while (rs.next()) {
				int quizID = rs.getInt("quizID");
				String name = rs.getString("name");
				String description = rs.getString("description");
				String category = rs.getString("category");
				Timestamp created = rs.getTimestamp("created");
				String creator = rs.getString("creatorId");
				QuizType type = QuizType.valueOf(rs.getString("type"));
				boolean practiceMode = rs.getBoolean("practiceMode");
				boolean multiplePages = rs.getBoolean("pages");
				boolean random = rs.getBoolean("random");
				boolean immediateCorrection = rs.getBoolean("correction");
				Quiz quiz = new Quiz(quizID, name, description, category, created, creator, type, practiceMode, multiplePages, random, immediateCorrection);
				quizzes.add(quiz);
			}
		} catch (SQLException e) {
		}
		return quizzes;
	}


	/**
	 * Returns a list of quizzes that have been recently taken by users
	 * @return ArrayList of recently taken quizzes
	 * @throws SQLException
	 */
	public ArrayList<Quiz> getRecentlyTakenQuizzes() {
		ArrayList<Quiz> quizzes = new ArrayList<Quiz>();
		try {
			Statement stmt = con.createStatement();		
			String query = "SELECT * FROM " + MyDBInfo.QUIZ_RECORDS_TABLE +" ORDER BY end_time DESC;";
			ResultSet rs = stmt.executeQuery(query);
	
			while (rs.next()) {
				int quizID = rs.getInt("quizID");
				Quiz quiz = getQuiz(quizID);
				quizzes.add(quiz);
			}
		} catch (SQLException e) {
		}
		return quizzes;
	}


	/**
	 * Returns a list of quizzes created by a given user
	 * @param username
	 * @return ArrayList of quizzes created by a given user
	 * @throws SQLException
	 */
	public ArrayList<Quiz> getMyQuizzes(String username)  {
		ArrayList<Quiz> quizzes = new ArrayList<Quiz>();
		try {
			Statement stmt = con.createStatement();
			String query = "SELECT * FROM " + MyDBInfo.QUIZ_TABLE +" WHERE creatorId='"+username +"';";
			ResultSet rs = stmt.executeQuery(query);
	
			while (rs.next()) {
				int quizID = rs.getInt("quizID");
				String name = rs.getString("name");
				String description = rs.getString("description");
				String category = rs.getString("category");
				Timestamp created = rs.getTimestamp("created");
				String creator = rs.getString("creatorId");
				QuizType type = QuizType.valueOf(rs.getString("type"));
				boolean practiceMode = rs.getBoolean("practiceMode");
				boolean multiplePages = rs.getBoolean("pages");
				boolean random = rs.getBoolean("random");
				boolean immediateCorrection = rs.getBoolean("correction");
				Quiz quiz = new Quiz(quizID, name, description, category, created, creator, type, practiceMode, multiplePages, random, immediateCorrection);
				quizzes.add(quiz);
			}
		} catch (SQLException e) {
		}
		return quizzes;
	}

	public ArrayList<Quiz> getMyRecentQuizzes(String username) {
		ArrayList<Quiz> quizzes = new ArrayList<Quiz>();
		try {
			Statement stmt = con.createStatement();		
			String query = "SELECT * FROM " + MyDBInfo.QUIZ_TABLE +" WHERE creatorId='"+username +"' ORDER BY 'end_time' DESC;";
			ResultSet rs = stmt.executeQuery(query);
	
			while (rs.next()) {
				int quizID = rs.getInt("quizID");
				String name = rs.getString("name");
				String description = rs.getString("description");
				String category = rs.getString("category");
				Timestamp created = rs.getTimestamp("created");
				String creator = rs.getString("creatorId");
				QuizType type = QuizType.valueOf(rs.getString("type"));
				boolean practiceMode = rs.getBoolean("practiceMode");
				boolean multiplePages = rs.getBoolean("pages");
				boolean random = rs.getBoolean("random");
				boolean immediateCorrection = rs.getBoolean("correction");
				Quiz quiz = new Quiz(quizID, name, description, category, created, creator, type, practiceMode, multiplePages, random, immediateCorrection);
				quizzes.add(quiz);
			}
		} catch (SQLException e) {
		}
		return quizzes;
	}

	public ArrayList<Quiz> getMyRecentlyTakenQuizzes(String username) {
		ArrayList<Quiz> quizzes = new ArrayList<Quiz>();
		try {
			Statement stmt = con.createStatement();		
			String query = "SELECT * FROM " + MyDBInfo.QUIZ_RECORDS_TABLE +" WHERE userId='" + username + "' ORDER BY end_time DESC;";
			ResultSet rs = stmt.executeQuery(query);
	
			while (rs.next()) {
				int quizID = rs.getInt("quizID");
				Quiz quiz = getQuiz(quizID);
				quizzes.add(quiz);
			}
		} catch (SQLException e) {
		}
		return quizzes;
	}
	
	public ArrayList<QuizPerformance> getRecentlyTakenQuizzesScore(String username) {
		ArrayList<QuizPerformance> quizzes = new ArrayList<QuizPerformance>();
		try {
			Statement stmt = con.createStatement();		
			String query = "SELECT * FROM " + MyDBInfo.QUIZ_RECORDS_TABLE +" WHERE userId='"+ username + "' ORDER BY end_time DESC;";
			ResultSet rs = stmt.executeQuery(query);
			while (rs.next()) {
				String name = rs.getString("userId");
				int score = rs.getInt("score");
				Timestamp start_time = rs.getTimestamp("start_time");
				Timestamp end_time = rs.getTimestamp("end_time");
				Quiz quiz = getQuiz(rs.getInt("quizId"));
				int possibleScore = rs.getInt("possibleScore");

				if(quiz != null){
					quizzes.add(new QuizPerformance(name, score, possibleScore, start_time, end_time, rs.getInt("quizId"), quiz.getQuizName()));
				}
			}
		} catch (SQLException e) {
		}
		return quizzes;
	}

	public ArrayList<QuizPerformance> getMyRecentlyTakenQuizPerformance (String username, int quizId) {
		ArrayList<QuizPerformance> recentlyTaken = new ArrayList<QuizPerformance>();
		try {
			Statement stmt = con.createStatement();		
			String query = "SELECT * FROM " + MyDBInfo.QUIZ_RECORDS_TABLE +" WHERE quizId='" + quizId + "' AND userId='"+ username + "' ORDER BY end_time DESC;";
			ResultSet rs = stmt.executeQuery(query);
			while (rs.next()) {
				String name = rs.getString("userId");
				int score = rs.getInt("score");
				int possibleScore = rs.getInt("possibleScore");
				Timestamp start_time = rs.getTimestamp("start_time");
				Timestamp end_time = rs.getTimestamp("end_time");
	
				recentlyTaken.add(new QuizPerformance(name, score, possibleScore, start_time, end_time, quizId));
			}
		} catch (SQLException e) {
		}
		return recentlyTaken;	
	}



	public ArrayList<QuizPerformance> getQuizHighScores(int quizId) {
		ArrayList<QuizPerformance> highScores = new ArrayList<QuizPerformance>();
		try {
			Statement stmt = con.createStatement();		
			String query = "SELECT * FROM " + MyDBInfo.QUIZ_RECORDS_TABLE +" WHERE quizId='" + quizId + "' ORDER BY score DESC;";
	
			ResultSet rs = stmt.executeQuery(query);
			while (rs.next()) {
				String name = rs.getString("userId");
				int score = rs.getInt("score");
				int possibleScore = rs.getInt("possibleScore");
				Timestamp start_time = rs.getTimestamp("start_time");
				Timestamp end_time = rs.getTimestamp("end_time");
	
				highScores.add(new QuizPerformance(name, score, possibleScore, start_time, end_time, quizId));
			}
		} catch (SQLException e) {
		}
		return highScores;
	} 

	public ArrayList<QuizPerformance> getQuizPerformances(int quizId) {
		ArrayList<QuizPerformance> highScores = new ArrayList<QuizPerformance>();
		try {
			Statement stmt = con.createStatement();		
			String query = "SELECT * FROM " + MyDBInfo.QUIZ_RECORDS_TABLE +" WHERE quizId='" + quizId + "' ORDER BY end_time DESC;";
	
			ResultSet rs = stmt.executeQuery(query);
			while (rs.next()) {
				String name = rs.getString("userId");
				int score = rs.getInt("score");
				int possibleScore = rs.getInt("possibleScore");
				Timestamp start_time = rs.getTimestamp("start_time");
				Timestamp end_time = rs.getTimestamp("end_time");
				highScores.add(new QuizPerformance(name, score, possibleScore, start_time, end_time, quizId));
			}
		} catch (SQLException e) {
		}
		return highScores;
	} 


	public int insertQuiz(Quiz quiz) {
		/* String query = "INSERT INTO " + MyDBInfo.QUIZ_TABLE + " (name, description, created, creatorId"
				+ ", practiceMode, pages, random, correction, type, amountTaken)" + 
				" VALUES ("+ '"+name+"' + ", " + description + ", " + created + ", " + creatorId + ", " + practice + ", " +
				pages + ", " + random + ", " + correction + ", " + quizType + ", 0);"; */
		String query = "INSERT INTO " + MyDBInfo.QUIZ_TABLE + " (name, description, created, creatorId"
				+ ", practiceMode, pages, random, correction, type, amountTaken, category)" + 
				" VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

		int quizId = 0;
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
			s.setString(11, quiz.getQuizCategory());
			s.executeUpdate();

			
			query = "SELECT * FROM " + MyDBInfo.QUIZ_TABLE +" WHERE name='" + quiz.getQuizName() + "' ORDER BY created ASC;";
			Statement stmt = con.createStatement();		
			ResultSet rs = stmt.executeQuery(query);
			while (rs.next()) {
				quizId = rs.getInt("quizId");
			}
			//quizId = rs.getInt("quizId");
			

		} catch (SQLException e1) {
			e1.printStackTrace();
			return -1;
		}
		return quizId;

		
	}
	
	public void addSingleAnswerQuestion(int quizId, int questionId, String question, String answer, int numAnswers) {
		String query = "INSERT INTO " + MyDBInfo.QUESTION_TABLE + " (quizId, questionId, questionText, correctAnswer"
				+ ", numAnswers)" + 
				" VALUES (?, ?, ?, ?, ?)";
		
		try {
			PreparedStatement s = con.prepareStatement(query);
			s.setInt(1, quizId);
			s.setInt(2, questionId);
			s.setString(3, question);
			s.setString(4, answer);
			s.setInt(5, numAnswers);
			s.executeUpdate();
		} catch (SQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
	}
	
	public void addMultipleAnswerQuestion(int quizId, int questionId, String question, String answer, int numAnswers, String[] questionAnswers, boolean mcQuestion) {
		addSingleAnswerQuestion(quizId, questionId, question, answer, numAnswers);
		
		for (int i = 0; i < questionAnswers.length; i++) {
			String query = "INSERT INTO " + MyDBInfo.ANSWERS_TABLE + " (quizId, questionId, answer)" + 
					" VALUES (?, ?, ?)";
			
			try {
				PreparedStatement s = con.prepareStatement(query);
				s.setInt(1, quizId);
				s.setInt(2, questionId);
				s.setString(3, questionAnswers[i]);
				s.executeUpdate();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
		}
	}
	
	public void deleteQuizAnswers(int quizId) {
		String query1 = "DELETE FROM " + MyDBInfo.QUESTION_TABLE + " WHERE quizId=" + quizId + ";";
		String query2 = "DELETE FROM " + MyDBInfo.ANSWERS_TABLE + " WHERE quizId=" + quizId + ";";
		try {
			Statement stmt = con.createStatement();
			stmt.execute(query1);
			stmt.execute(query2);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	/*
	public void addMultipleChoiceQuestion(int quizId, int questionId, String question, String answer, int numAnswers, String[] questionAnswers) {
		addSingleAnswerQuestion(quizId, questionId, question, answer, numAnswers);
		
	} */

	
	public ArrayList<Quiz> getCategorizedQuizzes(String category) {
		ArrayList<Quiz> quizzes = new ArrayList<Quiz>();
		try {
			Statement stmt = con.createStatement();
			String query = "SELECT * FROM " + MyDBInfo.QUIZ_TABLE +" WHERE category='" + category + "';";
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
				Quiz quiz = new Quiz(quizID, name, description, category, created, creator, type, practiceMode, multiplePages, random, immediateCorrection);
				quizzes.add(quiz);
			}
		} catch (SQLException e) {
		}
		return quizzes;
	}
	
	
	public ArrayList<Review> getReviews(int quizId) {
		ArrayList<Review> reviews = new ArrayList<Review>();
		try {
			Statement stmt = con.createStatement();		
			ResultSet rs = stmt.executeQuery("SELECT * FROM " + MyDBInfo.QUIZ_RATINGS +" WHERE quizId='" + quizId + "' ORDER BY created DESC;");
			while (rs.next()) {
				Review r = new Review(rs.getInt("quizId"), rs.getString("userId"), rs.getInt("rating"), rs.getString("review"), rs.getTimestamp("created"));
				reviews.add(r);
			}
		} catch (SQLException e1) {
		}
		
		return reviews;
	}
	
	
	public boolean addReview(String quizId, String userId, String rating, String review) {
		try {
			java.util.Date dt = new java.util.Date();
			java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String created = sdf.format(dt);
			Statement stmt = con.createStatement();		
			stmt.executeUpdate("INSERT INTO " + MyDBInfo.QUIZ_RATINGS + " VALUES('" + quizId + "', '" + userId + "', '" + created + "', '" + rating + "', '" + review + "');");
		} catch (SQLException e1) {
			return false;
		}
		
		return true;
	}

	
	public boolean addReportedQuiz(int quizId, String reporter) {
		try { 
			java.util.Date dt = new java.util.Date();
			java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String created = sdf.format(dt);
			Statement stmt = con.createStatement();
			stmt.executeUpdate("INSERT INTO " + MyDBInfo.REPORTED_QUIZZES + " VALUES('" + quizId + "', '" + reporter + "', '" + created + "');");
		} catch (SQLException e1) {
			return false;
		}
		return true;
	}
	
	
	public double getAverageRating(int quizId) {
		double total = 0;
		double numRatings = 0;
		try {
			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery("SELECT * FROM " + MyDBInfo.QUIZ_RATINGS + " WHERE quizId='" + quizId + "';");
			while (rs.next()) {
				numRatings++;
				total += rs.getDouble("rating");
			}
		} catch (SQLException e1) {
		}
		
		if (numRatings == 0) return 0;
		return total / numRatings;
	}
	
	
	public boolean addQuizRecord(int quizId, String userId, Date start_time, Date end_time, int score, int possibleScore){
		try{
			java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String formattedStartTime = sdf.format(start_time);
			String formattedEndTime = sdf.format(end_time);
			Statement stmt = con.createStatement();
			stmt.executeUpdate("INSERT INTO " + MyDBInfo.QUIZ_RECORDS_TABLE + " VALUES('" + quizId + "', '" + userId + "', '" + 
			formattedStartTime +"', '"+ formattedEndTime+"', '"+score+"', '"+possibleScore+"');");
		}catch (SQLException e1){
			return false;
		}
		return true;
	}
	
	
	
	public void closeConnection() {
		DBConnector.closeConnection();
	}

}
