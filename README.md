Summary of  Implementation:

1.	Registered this App with Twitter Apps using the below link to get consumer and secret key for accessing Twitter API.
a.	App registration URL: https://apps.twitter.com
2.	Implemented UI modules using storyboards and auto layouts.
3.	Used VIPER based  and MVC design patterns and blocks across the App.
4.	Followed dependency injection across the App to facilitate the unit tests. 
5.	Implemented unit tests using XCTestCase and OCMock.
6.	Used NSURLSession for network operations.
7.	Implemented JSON parser using Mantle framework.
8.	Login-Twitter API:
a.	As the social framework requires switching to the Settings screen to enter login details, TwitterKit framework, implemented by Twitter Inc, is used to allow the user to enter the login detail   within the App.
b.	As implementing Twitter xAuth(exchange username and password) is restricted and requires approval from Twitter, Login screen with username and password is not implemented. Rather, TwitterKit login API is used where it  opens the web view to allow the user to enter the login details inside the App.
c.	As TwitterKit API logout API doesn’t delete the twitter account from the system, it  requires deleting it manually from the settings screen for switching between the users. However, it clears the local Twitter session on logout.

9.	 Post tweet -Twitter API:
a.	Used TwitterKit compose UI module(TWRComposer), which displays composer to enter and send the tweet text. It is recommended to user framework provided composer. As sending of the tweet to the server takes some time, the home time line will be refreshed 5 seconds after the tweet is posted.

10.	Home Time Line -Twitter API:
a.	Implemented UI modules using TwitterKit API  to demonstrate the data flow-using VIPER based architecture even though TwitterKit provides  TimeLineTableViewController and TimeLineTableViewCell UI components.

11.	Due to time limitations, I couldn’t mimic the complete Twitter UI look and feel.
12.	Added refresh and log out options.
13.	Provided Doxygen based API documentation.
