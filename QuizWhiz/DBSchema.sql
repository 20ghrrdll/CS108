DROP TABLE IF EXISTS quiz;
DROP TABLE IF EXISTS quiz_records;
DROP TABLE IF EXISTS quiz_question;
DROP TABLE IF EXISTS question_answers;
DROP TABLE IF EXISTS quiz_records;
DROP TABLE IF EXISTS quiz_question_records;


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
	type enum('FillIn', 'QuestionResponse') DEFAULT 'QuestionResponse',
	PRIMARY KEY (quizId)
);
/* Creating the quiz_question table. This stores the question text and the correct answer
*/
CREATE TABLE IF NOT EXISTS quiz_question(
	quizId INT NOT NULL,
	userId INT NOT NULL,
	questionId INT NOT NULL,
	questionText VARCHAR(8000) NOT NULL,
	correctAnswer VARCHAR(255) NOT NULL,
	PRIMARY KEY (quizId)
);
/* Creating the question answers table. This stores the answer associated with a question
*/
CREATE TABLE IF NOT EXISTS question_answers(
	quizId INT NOT NULL,
	questionId INT NOT NULL,
	answer VARCHAR(255) NOT NULL
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


/*  ----------------------------------
All tables loaded. Now we load initial quiz data
*/

INSERT INTO quiz (quizId, name, description, created, creatorId) VALUES
('1','First Quiz', 'Our first quiz', '2016-02-27 13:41:00', '1');

INSERT INTO quiz_question (quizId, userId, questionId, questionText, correctAnswer) VALUES
('1', '1', '1', 'Does this work?', 'Yes');

INSERT INTO question_answers (quizId, questionId, answer) VALUES
('1', '1', 'Yes'),
('1', '1', 'No');

