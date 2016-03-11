# CS108 Quiz Website

#Required
##Quizes
Users can take and create four different types of quizzes.
1. Question-Response—This is a standard text question with an appropriate text response. For example: Who was President during the Bay of Pigs fiasco?
2. Fill in the Blank—This is similar to standard Question-Response, except a blank can go anywhere within a question. For example: “One of President Lincoln’s most famous speeches was the __________ Address.”
3. Multiple Choice—Allow the user to select from one of a number of possible provided answers. Please present multiple-choice questions using radio buttons—this should not be treated as a Question-Response question where the user enters an “A”, “B”, or “C” into a blank textfield.
4. Picture-Response Questions—In a picture response question, the system will display an image, and the user will provide a text response to the image. Here are some examples of picture-response questions. The system displays an image of a bird, the user responds with the name of the bird species; the system displays an image of a US President, the user responds with the name of the president; the system displays a chemical structure of a molecule, the user responds with the name of the molecule.

###Quiz Properties
In addition to the type of quiz, a quiz creator can determine a few additional properties.
1. Random Questions—Allow the creator to set the quiz to either randomize the order of the questions or to always present them in the same order.
2. One Page vs. Multiple Pages—Allow the quiz writer to determine if all the questions should appear on a single webpage, with a single submit button, or if the quiz should display a single question allow the user to submit the answer, then display another question. The one-question-per-page approach will work well for a flash-card style quiz, where the website flashes up an image or photograph and asks for a response, followed by a new page with a new image. Single-page quizzes will be good for most other quiz types.
3. Immediate Correction—For multiple page quizzes, this setting determines whether the user will receive immediate feedback on an answer, or if the quiz will only be graded once all the questions have been seen and responded to. The immediate correction option will work in conjunction with picture-response questions to create a flash- card type quiz. The computer will bring up a flash card (i.e., a picture) the user will respond with the answer and the computer will immediately provide feedback on whether the answer was correct or not.

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


