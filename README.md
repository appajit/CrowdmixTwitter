1.	Summary of  Implementation:

2.	Registered this App with Twitter Apps using the following link to get consumer and secret key to access Twitter API.
  2.1.	App registration URL: https://apps.twitter.com.
3.	Implemented UI modules using storyboards and auto layouts.
4.	Used VIPER based  and MVC design patterns and blocks across the App.
5.	Followed dependency injection across the App to facilitate the unit tests. 
6.	Implemented unit tests using XCTestCase and OCMock.
7.	Used NSURLSession for network operations.
8.	Implemented JSON parser using Mantle framework.
9.	Login-Twitter API:
  9.1.	As the social framework requires switching to the Settings screen to enter login details, TwitterKit framework, implemented by Twitter Inc, is used to allow the user to enter the login detail   within the App.
  9.2.	As implementing Twitter xAuth(exchange username and password) is restricted and requires approval from Twitter, Login screen with username and password is not implemented. Rather, TwitterKit login API is used where it  opens the web view to allow the user to enter the login details inside the App.
  9.3.	As TwitterKit API logout API doesn’t delete the twitter account from the system, it  requires manual deletion from the settings screen for switching between users. However, it clears the local Twitter session on logout.

10.	 Post tweet -Twitter API:
  10.1.	Used TwitterKit compose UI module(TWRComposer), which displays composer to enter and send the tweet text. It is recommended to user framework provided composer. As sending of the tweet to the server takes some time, the home time line will be refreshed 5 seconds after the tweet is posted.

11.	Home Time Line -Twitter API:
  11.1.	Implemented UI modules using TwitterKit API  to demonstrate the data flow-using VIPER based architecture even though TwitterKit provides  TimeLineTableViewController and TimeLineTableViewCell UI components.

12.	Due to time limitations, I couldn’t mimic the complete Twitter UI look and feel.
13.	Added refresh and log out options.
14.	Provided Doxygen based API documentation.


