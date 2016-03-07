DROP TABLE IF EXISTS quiz;
DROP TABLE IF EXISTS quiz_records;
DROP TABLE IF EXISTS quiz_question;
DROP TABLE IF EXISTS question_answers;
DROP TABLE IF EXISTS quiz_records;
DROP TABLE IF EXISTS quiz_question_records;

DROP TABLE IF EXISTS user;

DROP TABLE IF EXISTS achievements;

DROP TABLE IF EXISTS announcements;

DROP TABLE IF EXISTS friends;

DROP TABLE IF EXISTS friend_requests;

DROP TABLE IF EXISTS messages;



/* Creating the Quiz table. This stores the summary info about the quizes
*/
CREATE TABLE IF NOT EXISTS quiz (
	quizId INT NOT NULL AUTO_INCREMENT,
	name VARCHAR(255) NOT NULL,
	description TEXT,
	created DATETIME NOT NULL,
	creatorId VARCHAR(255) NOT NULL,
	practiceMode BOOLEAN DEFAULT false,
	pages BOOLEAN DEFAULT false,
	random BOOLEAN DEFAULT false,
	correction BOOLEAN DEFAULT false,
	type enum('FillIn', 'QuestionResponse') DEFAULT 'QuestionResponse',
	amountTaken INT,
	PRIMARY KEY (quizId)
);
/* Creating the quiz_question table. This stores the question text and the correct answer
*/
CREATE TABLE IF NOT EXISTS quiz_question(
	quizId INT NOT NULL,
	questionId INT NOT NULL,
	questionText VARCHAR(8000) NOT NULL,
	correctAnswer VARCHAR(255) NOT NULL,
	questionOrder INT
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
	userId VARCHAR(255) NOT NULL,
	start_time DATETIME NOT NULL,
	end_time DATETIME NOT NULL,
	score SMALLINT NOT NULL
);
/* Creating the quiz_question_records table. This stores the info on how a user did on a particular question
*/
CREATE TABLE IF NOT EXISTS quiz_question_records (
	quizId INT NOT NULL,
	questionId INT NOT NULL,
	userId VARCHAR(255) NOT NULL,
	response TEXT,
	correct BOOLEAN,
	answered BOOLEAN
);

CREATE TABLE IF NOT EXISTS user (
	username VARCHAR(255) NOT NULL,
	password VARCHAR(255) NOT NULL,
	admin BOOLEAN DEFAULT false,
	joinDate DATETIME NOT NULL,
	cookie VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS achievements (
	userId VARCHAR(255) NOT NULL,
	achievementId VARCHAR(255) NOT NULL,
	timeAchieved DATETIME NOT NULL
);

CREATE TABLE IF NOT EXISTS announcements (
  announcementId INT NOT NULL AUTO_INCREMENT,
  userId VARCHAR(255) NOT NULL,
  posted datetime NOT NULL,
  subject VARCHAR(8000) NOT NULL,
  body VARCHAR(8000) NOT NULL,
  PRIMARY KEY (announcementId)

);

CREATE TABLE IF NOT EXISTS friends(
  user1 VARCHAR(255) NOT NULL,
  user2 VARCHAR(255) NOT NULL,
  established datetime NOT NULL,
  UNIQUE KEY user1 (user1,user2),
  UNIQUE KEY user2 (user2,user1)
); 

CREATE TABLE IF NOT EXISTS friend_requests (
  userToId VARCHAR(255) NOT NULL,
  userFromId VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS messages (
  messageId INT NOT NULL AUTO_INCREMENT,
  senderId VARCHAR(255) NOT NULL,
  recipientId VARCHAR(255) NOT NULL,
  timeSent datetime NOT NULL,
  unread BOOLEAN DEFAULT true,
  subject VARCHAR(8000) NOT NULL,
  body VARCHAR(8000) NOT NULL,
  quizId INT DEFAULT NULL,
  type enum('CHALLENGE','NOTE') NOT NULL,
  PRIMARY KEY (messageId)
)  ;


/*  ----------------------------------
All tables loaded. Now we load initial quiz data
*/

INSERT INTO quiz (quizId, name, description, created, creatorId, amountTaken) VALUES
('1','First Quiz', 'Our first quiz', '2016-02-27 13:41:00', 'Max', 10),
('2','Second Quiz', 'Our 2nd quiz', '2016-02-27 13:41:01', 'Max', 9),
('3','Third Quiz', 'Our 3rd quiz', '2016-02-27 13:41:02', 'Max', 8),
('4','Fourth Quiz', 'Our 4th  quiz', '2016-02-27 13:41:03', 'Max', 7),
('5','Fifth Quiz', 'Our 5th quiz', '2016-02-27 13:41:04', 'Max', 6),
('6','Sixth Quiz', 'Our 6th quiz', '2016-02-27 13:41:05', 'Max', 5),
('7','Seventh Quiz', 'Our 7th quiz', '2016-02-27 13:41:06', 'Max', 4),
('8','Eighth Quiz', 'Our 8th quiz', '2016-02-27 13:41:07', 'Max', 3);

INSERT INTO quiz_question (quizId, questionId, questionText, correctAnswer, questionOrder) VALUES
(1, 1, 'How many knees do elephants have?', '2', 1),
(1, 2, 'Who has more neck vertabrae: humans, giraffes or they both have the same number?', 'they both have the same number', 0),
(2, 1, 'We the | in order to form a more | union', 'go to question_answers', 0),
(2, 2, 'Establish |, ensure domestic |', 'go to question_answers', 0),
(2, 3, 'Provide for the commmon |, promote the general |', 'go to question_answers', 0),
(2, 4, ' and ensure the blessings of | to ourselves and |,', 'go to question_answers', 0),
(2, 5, ' do | and | this constitution for the United States of America.', 'go to question_answers', 0);



INSERT INTO question_answers (quizId, questionId, answer) VALUES
('1', '1', 'Yes'),
('1', '1', 'No');

INSERT INTO user (username, password, joinDate) VALUES
('Max', '40bd001563085fc35165329ea1ff5c5ecbdbbeef', '2016-03-01 19:41:00'),
('Carah', '40bd001563085fc35165329ea1ff5c5ecbdbbeef', '2016-03-01 19:41:00'),
('Regina', '40bd001563085fc35165329ea1ff5c5ecbdbbeef', '2016-03-01 19:41:00'),
('Neel', '40bd001563085fc35165329ea1ff5c5ecbdbbeef', '2016-03-01 19:41:00');

INSERT INTO announcements (announcementId, userId, posted, subject, body) VALUES
('1', 'Max','2016-02-27 13:41:00', 'Super important!', 'First announcement woohoo!'),
('2', 'Neel','2016-02-27 13:41:00', 'Another Announcement', 'Second announcement woohoo!');

INSERT INTO quiz_records (quizId, userId, start_time, end_time, score) VALUES
('1', 'Max', '2016-03-01 19:41:00', '2016-03-01 19:50:00', '10'),
('1', 'Max', '2016-03-01 13:25:17', '2016-03-01 18:20:05', '100'),
('1', 'Max', '2016-03-06 19:41:00', '2016-03-06 19:50:00', '20'),
('1', 'Max', '2016-03-01 19:41:00', '2016-03-01 19:50:00', '55'),
('1', 'Carah', '2016-03-01 19:41:00', '2016-03-01 19:50:00', '70'),
('1', 'Carah', '2016-03-01 19:41:00', '2016-03-01 19:50:00', '60'),
('1', 'Carah', '2016-03-06 19:41:00', '2016-03-06 19:50:00', '50'),
('1', 'Neel', '2016-03-01 19:41:00', '2016-03-01 19:50:00', '95'),
('1', 'Neel', '2016-03-01 19:41:00', '2016-03-01 19:50:00', '88'),
('1', 'Neel', '2016-03-06 19:41:00', '2016-03-06 19:50:00', '70'),
('1', 'Neel', '2016-03-01 19:41:00', '2016-03-01 19:50:00', '44'),
('1', 'Neel', '2016-03-01 19:41:00', '2016-03-01 19:50:00', '30'),
('1', 'Regina', '2016-03-06 19:41:00', '2016-03-06 19:50:00', '80'),
('1', 'Regina', '2016-03-01 19:41:00', '2016-03-01 19:50:00', '90'),
('1', 'Regina', '2016-03-01 19:41:00', '2016-03-01 19:50:00', '25'),
('1', 'Regina', '2016-03-01 19:41:00', '2016-03-01 19:50:00', '99');




INSERT INTO achievements (userId, achievementId) VALUES 
('Max', 'CREATE_1');

-- Inserting unread messages (notes)
INSERT INTO messages (messageId, senderId, recipientId, timeSent, subject, body, type) VALUES
('1', 'max', 'neel', '2016-03-05 15:41:00', 'A test message', 'interesting stuff', 'NOTE'),
('2', 'max', 'regina', '2016-03-05 15:42:00', 'A test message', 'interesting stuff', 'NOTE'),
('3', 'max', 'carah', '2016-03-05 15:43:00', 'A test message', 'interesting stuff', 'NOTE'),
('4', 'neel', 'max', '2016-03-05 15:44:00', 'A test message', 'interesting stuff', 'NOTE'),
('5', 'regina', 'neel', '2016-03-05 15:45:00', 'A test message', 'interesting stuff', 'NOTE');

-- Inserting challege messages
INSERT INTO messages (messageId, senderId, recipientId, timeSent, subject, body, quizId, type) VALUES
('6', 'max', 'neel', '2016-03-05 15:46:00', 'A test challenge', 'take this quiz!', 1,'CHALLENGE'),
('7', 'max', 'regina', '2016-03-05 15:46:00', 'A test challenge', 'take this quiz!', 2, 'CHALLENGE'),
('8', 'max', 'carah', '2016-03-05 15:46:00', 'A test challenge', 'take this quiz!', 3, 'CHALLENGE'),
('9', 'carah', 'neel', '2016-03-05 15:46:00', 'A test challenge', 'take this quiz!', 4, 'CHALLENGE'),
('10', 'regina', 'neel', '2016-03-05 15:46:00', 'A test challenge', 'take this quiz!', 5, 'CHALLENGE'),
('11', 'neel', 'max', '2016-03-05 15:46:00', 'A test challenge', 'take this quiz!', 6 ,'CHALLENGE');

-- Inserting read notes
INSERT INTO messages (messageId, senderId, recipientId, timeSent, subject, body, unread, type) VALUES
('12', 'max', 'neel', '2016-03-05 15:41:00', 'A read message', 'interesting stuff', 'false',  'NOTE'),
('13', 'max', 'regina', '2016-03-05 15:42:00', 'A test message', 'interesting stuff', 'false','NOTE'),
('14', 'max', 'carah', '2016-03-05 15:43:00', 'A test message', 'interesting stuff', 'false','NOTE'),
('15', 'neel', 'max', '2016-03-05 15:44:00', 'A test message', 'interesting stuff', 'false','NOTE'),
('16', 'regina', 'neel', '2016-03-05 15:45:00', 'A test message', 'interesting stuff', 'false','NOTE');
