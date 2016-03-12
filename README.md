# CS108 Quiz Website
Max Freundlich, Regina Nguyen, Neel Ramachandran, Carah Alexander
#Required
##Quizes
Users can take and create four different types of quizzes.
- Question-Response—This is a standard text question with an appropriate text response. For example: Who was President during the Bay of Pigs fiasco?
- Fill in the Blank—This is similar to standard Question-Response, except a blank can go anywhere within a question. For example: “One of President Lincoln’s most famous speeches was the __________ Address.”
- Multiple Choice—Allow the user to select from one of a number of possible provided answers. Please present multiple-choice questions using radio buttons—this should not be treated as a Question-Response question where the user enters an “A”, “B”, or “C” into a blank textfield.
- Picture-Response Questions—In a picture response question, the system will display an image, and the user will provide a text response to the image. Here are some examples of picture-response questions. The system displays an image of a bird, the user responds with the name of the bird species; the system displays an image of a US President, the user responds with the name of the president; the system displays a chemical structure of a molecule, the user responds with the name of the molecule.

###Quiz Properties
In addition to the type of quiz, a quiz creator can determine a few additional properties.
- Random Questions—Allow the creator to set the quiz to either randomize the order of the questions or to always present them in the same order.
- One Page vs. Multiple Pages—Allow the quiz writer to determine if all the questions should appear on a single webpage, with a single submit button, or if the quiz should display a single question allow the user to submit the answer, then display another question. The one-question-per-page approach will work well for a flash-card style quiz, where the website flashes up an image or photograph and asks for a response, followed by a new page with a new image. Single-page quizzes will be good for most other quiz types.
- Immediate Correction—For multiple page quizzes, this setting determines whether the user will receive immediate feedback on an answer, or if the quiz will only be graded once all the questions have been seen and responded to. The immediate correction option will work in conjunction with picture-response questions to create a flash- card type quiz. The computer will bring up a flash card (i.e., a picture) the user will respond with the answer and the computer will immediately provide feedback on whether the answer was correct or not.

###Scoring
Scoring
Quizzes will be scored on the basis of how many questions a user got right. They should also keep track of how long a user took to complete the quiz. For multi-answer questions, treat each blank as a separate answer for grading purposes. For example if the multi-answer question was “List the five largest cities in the US” it would count as 5 separate answers for grading purposes, and a user could receive anywhere from 1-5 points for the question depending on their answers.

##Users
###User profile
Every user has their own profile page. On this page their recent activity is shown as well a list of achievements they have earned. There are options to message the user, add them s a friend, and if you have admin status you may delete the user. 
###Friends
Users can search and add friends to there friends list. There is a friends page that displays a list of friends as well as pending freind requests
###Messages
Once friends with someone on the site, you can interact in two ways. You can send a direct note to them, or challenge them to take a quiz that you have recently taken or just completed. These messages show up in their inbox. 

###History
All users have access to a page that displays their quiz taking history. This page has links to the quizzes as well as displays their past scores.

###Achievements
Users can accomplish achievements by taking quizzes, creating quizzes, and performing other activities on the site. These are all displayed in the user profile. 

##Administration
We have included an administration feature. Auser may be granted admin status by an existed admin and get access to the following features:
- Create announcements which will show up on the homepage.
- Remove user accounts.
-  Remove quizzes.
-   Clear all history information for a particular quiz.
-   Promote user accounts to administration accounts.
-   See site statistics. These should include number of users and number of quizzes taken.

#Pages of the site
###Login/Create
If not logged in, the user is prompted to log in or create an account if one does not exist
###Homepage
Once the user logs in they are directed to a homepage that displayes the following information
- An Announcements section highlighting any items put up by the website administrators.
- A list of popular quizzes.
- A list of recently created quizzes.
- A list of their own recent quiz taking activities.
- An indication of all achievements they’ve earned.
- An indication if they’ve received any messages with a link to view the messages/all messages
- A list of friend’s recent activities including quizzes taken or created and achievements earned.

###Quiz Summary Page
If a user clicks a link to quiz, they are directed to a quiz summary page. This page includes
- The text description of the quiz.
- The creator of the quiz (hot linked to the creator’s user page).
- A list of the user’s past performance on this specific quiz. 
- A list of the highest performers of all time.
- A list of top performers in the last day.
- A list showing the performance of recent test takers (both good and bad).
- Summary statistics on how well all users have performed on the quiz.
- A way to initiate taking the quiz.
- A way to start editing the quiz, if the user is the quiz owner.

###Quiz Results Page
After completing a quiz, the user is directed to a results page. Here the user can see all their answers as well as the actual solutions. Their score is displayed as well as an option to take the quiz again or to challenge a friend to beat their score.

###Friends
A page to view all friends. On this page a users friends are listed as well as any pending friend requests. In addition to this, users can also search for friends here by username.

###Messages
Here users can view all the messages they have recieved. Messages are challenges or notes, to which they can accept/reply/ignore. They can also send a message to any of their friends here.

###Admin Portal
This is where admins are able to perform all of the actions outlined in the administration section above.

#Extensions
- ### Improved error handling for faulty login, account creation,searching for non existing user, and malformed inputs
- ### Quiz review and rating system
    here we allow users to "Rate" a quiz. We use a 5 star rating system. They are also able to leave comments along with their rating. these reviews show up on the quiz summary page
- ### Administration
- ### Achievements
-   achievements include
    - Perfect Score
    - 10 friends
    - popular quiz
    - Created 1,5,10 quizzes
    - Took 1, 10 quizzes
    - Highest Score
    - Challenger
- ### Look and feel
- ### Reporting Quizzes
  Users can report quizzes that they deem malformed or innapropriate. Admins get a list of all reported quizzes to review.
- ### Categories
  Quizzes are categorized. 
- ### Edit Quiz
  If a user is the creator, they have the option to edit a quiz. Here they can add, remove, and edit questions. 
