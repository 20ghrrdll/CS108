DROP TABLE IF EXISTS quiz;
DROP TABLE IF EXISTS quiz_records;
DROP TABLE IF EXISTS quiz_question;
DROP TABLE IF EXISTS question_answers;
DROP TABLE IF EXISTS quiz_records;
DROP TABLE IF EXISTS quiz_question_records;
DROP TABLE IF EXISTS quiz_ratings;
DROP TABLE IF EXISTS reported_quizzes;

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
	category VARCHAR(255) DEFAULT 'UNCATEGORIZED',
	practiceMode BOOLEAN DEFAULT false,
	pages BOOLEAN DEFAULT false,
	random BOOLEAN DEFAULT false,
	correction BOOLEAN DEFAULT false,
	type enum('FillIn', 'QuestionResponse', 'MultipleChoice', 'PictureResponse') DEFAULT 'QuestionResponse',
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
	numAnswers INT
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
	score SMALLINT NOT NULL,
	possibleScore SMALLINT NOT NULL
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
	profilePrivacy enum('Everyone', 'MyFriends', 'NoOne') DEFAULT 'Everyone',
	friendPrivacy enum('Everyone', 'NoOne') DEFAULT 'Everyone',
	messagePrivacy enum('Everyone', 'MyFriends', 'NoOne') DEFAULT 'Everyone',
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
  established TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
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
  timeSent TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  unread BOOLEAN DEFAULT true,
  subject VARCHAR(8000) NOT NULL,
  body VARCHAR(8000) NOT NULL,
  quizId INT DEFAULT NULL,
  type enum('CHALLENGE','NOTE') NOT NULL,
  score VARCHAR(255) DEFAULT NULL,
  PRIMARY KEY (messageId)
);

CREATE TABLE IF NOT EXISTS quiz_ratings (
	quizId INT NOT NULL,
	userId VARCHAR(255) NOT NULL,
	created DATETIME NOT NULL,
	rating INT NOT NULL,
	review VARCHAR(8000) NOT NULL
);

CREATE TABLE IF NOT EXISTS reported_quizzes (
	quizId INT NOT NULL,
	reportedBy VARCHAR(255) NOT NULL,
	reportedDate DATETIME NOT NULL
);


/*  ----------------------------------
All tables loaded. Now we load initial quiz data
*/

INSERT INTO quiz (quizId, name, description, created, creatorId, amountTaken,pages, type) VALUES
('1','First Quiz', 'Our first quiz', '2016-02-27 13:41:00', 'Max', 10, 	FALSE, 'QuestionResponse'),
('2','The Preamble', 'How well do you know the first sentence of the constitution?', '2016-02-27 13:41:01', 'Max', 9,FALSE, 'FillIn'),
('3','Disney', 'Put your knowledge of childlike whimsy to the test!', '2016-02-27 13:41:02', 'Max', 8, FALSE, 'MultipleChoice'),
('4','Cute Animals', "Do you struggle to identify animals when they're cute? Practice here!", '2016-02-27 13:41:03', 'Max', 7, TRUE,'PictureResponse'),
('5','Math Problems', 'Really hard math problems', '2016-02-27 13:41:04', 'Max', 6, FALSE, 'QuestionResponse'),
('6','Sixth Quiz', 'Our 6th quiz', '2016-02-27 13:41:05', 'Max', 5,FALSE, 'QuestionResponse'),
('7','Seventh Quiz', 'Our 7th quiz', '2016-02-27 13:41:06', 'Max', 4, FALSE,'QuestionResponse'),
('8','Eighth Quiz', 'Our 8th quiz', '2016-02-27 13:41:07', 'Max', 3,FALSE, 'QuestionResponse');

/*
	type enum('FillIn', 'QuestionResponse') DEFAULT 'QuestionResponse',
*/

INSERT INTO quiz_question (quizId, questionId, questionText, correctAnswer, numAnswers) VALUES
(1, 1, 'How many knees do elephants have?', '2', 1),
(1, 2, 'Who has more neck vertabrae: humans, giraffes or they both have the same number?', 'they both have the same number', 1),
(3, 1, 'A classic silent Disney character shares a name with a planet. How many planets are there between that planet and the sun?', '8', 4),
(3, 2, "A winged character in Aladdin shares his name with a character from a Shakesperean Play. What is that play's name?", 'Othello', 3),
(3, 3, 'In the Little Mermaid, Ariel needs to convince the prince to marry her so she can stay with him on land. In the book that inspired
	this story, what will happen to her if she doesnt succeed?', 'She will turn into sea foam', 4),
(4, 1, "What kind of animal is this?|https://s-media-cache-ak0.pinimg.com/736x/7b/7b/7f/7b7b7fac88ead0c1b89573c781123b0f.jpg", "Giraffe", 1),
(4, 2, "What kind of animal is this?|http://www.pamperedpetz.net/wp-content/uploads/2015/09/Puppy1.jpg", "Dog", 1),
(4, 3, "What kind of animal is this?|http://cdn-img.people.com/emstag/i/2015/pets/news/150316/quokka-1024.jpg?ppl_tok=6c2950da2fa29610296cb843a46bf64b", "Quokka", 1),
(5, 1, '1+1', 2, 1),
(5, 2, '10+60', 70, 1),
(5, 3, '100%10', 10, 1),
(5, 4, '3+2', 5, 1),
(5, 5, '9*9', 81, 1),
(5, 6, 'Prove p=np', 'Let n=1, p=(1)p ==> p=p. Give me my nobel.', 1);




INSERT INTO question_answers (quizId, questionId, answer) VALUES
('3', '1', '8'),
('3', '1', '9'),
('3', '1', '7'),
('3', '1', '10'),
('3', '2', 'Othello'),
('3', '2', 'Romeo and Juliet'),
('3', '2', 'Macbeth'),
('3', '3', 'She will turn into sea foam'),
('3', '3', 'Her legs will turn back into fins'),
('3', '3', 'The witch will eat her'),
('3', '3', 'She will turn back into a pumpkin'),
(5, 1, 2),
(5, 2, 70),
(5, 3, 10),
(5, 4, 5),
(5, 5, 81),
(5, 6, 'Let n=1, p=(1)p ==> p=p. Give me my nobel.');


INSERT INTO user (username, password, joinDate, admin) VALUES
('Max', '40bd001563085fc35165329ea1ff5c5ecbdbbeef', '2016-03-01 19:41:00', TRUE),
('Carah', '40bd001563085fc35165329ea1ff5c5ecbdbbeef', '2016-03-01 19:41:00', TRUE),
('Regina', '40bd001563085fc35165329ea1ff5c5ecbdbbeef', '2016-03-01 19:41:00', TRUE),
('Neel', '40bd001563085fc35165329ea1ff5c5ecbdbbeef', '2016-03-01 19:41:00', TRUE);

INSERT INTO announcements (announcementId, userId, posted, subject, body) VALUES
('1', 'Max','2016-02-27 13:41:00', 'Super important!', 'First announcement woohoo!'),
('2', 'Neel','2016-02-27 13:41:00', 'Another Announcement', 'Second announcement woohoo!');

INSERT INTO quiz_records (quizId, userId, start_time, end_time, score, possibleScore) VALUES
('1', 'Max', '2016-03-01 19:41:00', '2016-03-01 19:50:00', '1', '2'),
('1', 'Max', '2016-03-01 13:25:17', '2016-03-01 18:20:05', '1', '2'),
('1', 'Max', '2016-03-06 19:41:00', '2016-03-06 19:50:00', '2', '2'),
('1', 'Max', '2016-03-01 19:41:00', '2016-03-01 19:50:00', '2', '2'),
('1', 'Carah', '2016-03-01 19:41:00', '2016-03-01 19:50:00', '1', '2'),
('1', 'Carah', '2016-03-01 19:41:00', '2016-03-01 19:50:00', '2', '2'),
('1', 'Carah', '2016-03-06 19:41:00', '2016-03-06 19:50:00', '2', '2'),
('1', 'Neel', '2016-03-01 19:41:00', '2016-03-01 19:50:00', '2', '2'),
('1', 'Neel', '2016-03-01 19:41:00', '2016-03-01 19:50:00', '2', '2'),
('1', 'Neel', '2016-03-06 19:41:00', '2016-03-06 19:50:00', '2', '2'),
('1', 'Neel', '2016-03-01 19:41:00', '2016-03-01 19:50:00', '2', '2'),
('1', 'Neel', '2016-03-01 19:41:00', '2016-03-01 19:50:00', '1', '2'),
('1', 'Regina', '2016-03-06 19:41:00', '2016-03-06 19:50:00', '0', '2'),
('1', 'Regina', '2016-03-01 19:41:00', '2016-03-01 19:50:00', '0', '2'),
('1', 'Regina', '2016-03-01 19:41:00', '2016-03-01 19:50:00', '1', '2'),
('1', 'Regina', '2016-03-01 19:41:00', '2016-03-01 19:50:00', '1', '2');

-- Inserting unread messages (notes)
INSERT INTO messages (messageId, senderId, recipientId, timeSent, subject, body, type) VALUES
('1', 'max', 'neel', '2016-03-05 15:41:00', 'A test message', 'interesting stuff', 'NOTE'),
('2', 'max', 'regina', '2016-03-05 15:42:00', 'A test message', 'interesting stuff', 'NOTE'),
('3', 'max', 'carah', '2016-03-05 15:43:00', 'A test message', 'interesting stuff', 'NOTE'),
('4', 'neel', 'max', '2016-03-05 15:44:00', 'A test message', 'interesting stuff', 'NOTE'),
('5', 'regina', 'neel', '2016-03-05 15:45:00', 'A test message', 'interesting stuff', 'NOTE');

-- Inserting challege messages
INSERT INTO messages (messageId, senderId, recipientId, timeSent, subject, body, quizId, type, score) VALUES
('6', 'max', 'neel', '2016-03-05 15:46:00', 'A test challenge', 'take this quiz!', 1,'CHALLENGE', '2/2'),
('7', 'max', 'regina', '2016-03-05 15:46:00', 'A test challenge', 'take this quiz!', 2, 'CHALLENGE', '2/2'),
('8', 'max', 'carah', '2016-03-05 15:46:00', 'A test challenge', 'take this quiz!', 3, 'CHALLENGE', '2/2'),
('9', 'carah', 'neel', '2016-03-05 15:46:00', 'A test challenge', 'take this quiz!', 4, 'CHALLENGE', '2/2'),
('10', 'regina', 'neel', '2016-03-05 15:46:00', 'A test challenge', 'take this quiz!', 5, 'CHALLENGE', '2/2'),
('11', 'neel', 'max', '2016-03-05 15:46:00', 'A test challenge', 'take this quiz!', 6 ,'CHALLENGE', '2/2');

-- Inserting read notes
INSERT INTO messages (messageId, senderId, recipientId, timeSent, subject, body, unread, type) VALUES
('12', 'max', 'neel', '2016-03-05 15:41:00', 'A read message', 'interesting stuff', 'false',  'NOTE'),
('13', 'max', 'regina', '2016-03-05 15:42:00', 'A read message', 'interesting stuff', 'false','NOTE'),
('14', 'max', 'carah', '2016-03-05 15:43:00', 'A read message', 'interesting stuff', 'false','NOTE'),
('15', 'neel', 'max', '2016-03-05 15:44:00', 'A read message', 'interesting stuff', 'false','NOTE'),
('16', 'regina', 'neel', '2016-03-05 15:45:00', 'A read message', 'interesting stuff', 'false','NOTE');

INSERT INTO friends (user1, user2, established) VALUES
('Max', 'Carah', '2016-03-04 20:45:00'),
('Max', 'Neel', '2016-03-04 20:45:00'),
('Max', 'Regina', '2016-03-04 20:45:00');

INSERT INTO achievements (userId, achievementId) VALUES
('Max', 'CREATE_1');

INSERT INTO quiz_ratings (quizId, userId, created, rating, review) VALUES 
('1', 'Regina', '2016-03-04 20:45:00', 4, 'Great');

INSERT INTO reported_quizzes(quizId, reportedBy, reportedDate) VALUES 
('1', 'Regina', '2016-03-04 20:45:00');