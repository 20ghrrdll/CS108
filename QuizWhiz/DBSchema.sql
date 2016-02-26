DROP TABLE IF EXISTS quiz;
DROP TABLE IF EXISTS quiz_records;
DROP TABLE IF EXISTS quiz_question;


/* Creating the Quiz table. This stores the summary info about the quizes
*/
CREATE TABLE IF NOT EXISTS quiz (
	quizId INT NOT NULL AUTO_INCREMENT,
	name VARCHAR(255) NOT NULL,
	description TEXT,
	created DATETIME NOT NULL,
	creatorId INT NOT NULL,
	practiceMode BOOLEAN DEFAULT false,
	pages BOOLEAN DEFAULT false,
	random BOOLEAN DEFAULT false,
	correction BOOLEAN DEFAULT false,
	type enum('FillIn', 'QuestionResponse'),
	PRIMARY KEY (quizId)
);
/* Creating the quiz_question table. This stores the question text and the correct answer
*/
CREATE TABLE IF NOT EXISTS quiz_question(
	quizId INT NOT NULL,
	userId INT NOT NULL,
	questionId INT NOT NULL AUTO_INCREMENT,
	questionText longblob NOT NULL,
	correctAnswer VARCHAR(255),
	PRIMARY KEY (questionId)
);
/* Creating the question answers table. This stores the answer associated with a question
*/
CREATE TABLE IF NOT EXISTS question_answers(
	questionId INT NOT NULL,
	answer VARCHAR(255) NOT NULL,
	PRIMARY KEY (questionId)
);
/* Creating the quiz records table. This stores the info about how a user did on a quiz
*/
CREATE TABLE IF NOT EXISTS quiz_records (
	quizId INT NOT NULL,
	userId INT NOT NULL,
	start_time DATETIME NOT NULL,
	end_time DATETIME NOT NULL,
	score SMALLINT NOT NULL
);
/* Creating the quiz_question_records table. This stores the info on how a user did on a particular question
*/
CREATE TABLE IF NOT EXISTS quiz_question_records (
	quizId INT NOT NULL,
	questionId INT NOT NULL,
	userId INT NOT NULL,
	response TEXT,
	correct BOOLEAN,
	answered BOOLEAN
);

