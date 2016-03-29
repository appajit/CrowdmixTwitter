**Summary of implementation details:**

1)  Registered this App with Twitter Apps using the following link to
    get consumer and secret key to access Twitter API.

    a.  App registration URL: https://apps.twitter.com.

2)  Main focus on implementing right architecture, design patterns and
    performance of the App.

3)  Implemented UI modules using storyboards and auto layouts.

4)  Followed VIPER based architecture and MVC design patterns.

5)  Used dependency injection across the App to facilitate the unit
    testing of the classes.

6)  Implemented lazy loading of the images in the table view for better
    performance of the App.

7)  Implemented unit tests using XCTestCase and OCMock.

8)  Used NSURLSession for network operations.

9)  Used Mantle framework for parsing JSON data.

10) Login-Twitter API:

    a.  As the social framework requires switching to the Settings
        screen to enter login details, TwitterKit framework, implemented
        by Twitter Inc, is used to allow the user to enter the login
        detail within the App.

    b.  As implementing Twitter xAuth(exchange username and password) is
        restricted and requires approval from Twitter, Login screen with
        username and password is not implemented. Rather, TwitterKit
        login API is used where it opens the web view to allow the user
        to enter the login details inside the App.

    c.  As TwitterKit API logout API doesn’t delete the twitter account
        from the system, it requires manual deletion from the settings
        screen for switching between users. However, it clears the local
        Twitter session on logout.

11) Post tweet -Twitter API:

    a.  Used TwitterKit compose UI module(TWRComposer), which displays
        composer to enter and send the tweet text. It is recommended to
        user framework provided composer. As sending of the tweet to the
        server takes some time, the home time line will be refreshed 5
        seconds after the tweet is posted.

12) Home Time Line -Twitter API:

    a.  Implemented UI modules using TwitterKit API to demonstrate the
        data flow-using VIPER based architecture even though TwitterKit
        provides TimeLineTableViewController and TimeLineTableViewCell
        UI components.

13) Added refresh and log out options.

14) Provided Doxygen based API documentation.
