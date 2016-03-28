//
//  CrowdmixTwitterTests.m
//  CrowdmixTwitter
//
//  Created by Appaji Tholeti on 28/03/2016.
//  Copyright © 2016 Tholeti. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "OCMock.h"
#import "TwitterKitAPI.h"
#import <TwitterKit/TwitterKit.h>
#import "CrowdmixTwitterService.h"
#import "CrowdmixTweet.h"
#import "CrowdmixTweetUser.h"

@interface CrowdmixTwitterTests : XCTestCase

@property (nonatomic,strong) id mockTwitterKitAPI;
@property (nonatomic,strong) id mockTwitterKitSessionStore;
@property (nonatomic,strong) id mockTwitterKitSession;
@property (nonatomic,strong) id mockTwitter;
@property (nonatomic,strong) id mockTwitterClient;
@property (nonatomic,strong) id mockTwitterComposer;
@property (nonatomic,strong) CrowdmixTwitterService *crowdmixTwitterService;


@end

@implementation CrowdmixTwitterTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.mockTwitterKitAPI = [OCMockObject niceMockForClass:[TwitterKitAPI class]];
    self.mockTwitterKitSessionStore = [OCMockObject niceMockForClass:[TWTRSessionStore class]];
    self.mockTwitterKitSession = [OCMockObject niceMockForProtocol:@protocol(TWTRAuthSession)];
    self.mockTwitter = [OCMockObject niceMockForClass:[Twitter class]];
    self.mockTwitterClient = [OCMockObject niceMockForClass:[TWTRAPIClient class]];
    self.mockTwitterComposer = [OCMockObject niceMockForClass:[TWTRComposer class]];
    
    [[[self.mockTwitterKitAPI stub] andReturn:self.mockTwitter] twitter];
    [[[self.mockTwitterKitAPI stub] andReturn:self.mockTwitterClient] twitterClient];
    [[[self.mockTwitterKitAPI stub] andReturn:self.mockTwitterComposer] twitterComposer];
    [[[self.mockTwitter stub] andReturn:self.mockTwitterKitSessionStore] sessionStore];
   
    self.crowdmixTwitterService = [[CrowdmixTwitterService alloc] initTwitterKitAPI:self.mockTwitterKitAPI];

}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    self.mockTwitterKitAPI = nil;
    self.mockTwitterKitSessionStore = nil;
    self.mockTwitterKitSession = nil;
    self.mockTwitter = nil;
    self.mockTwitterClient = nil;
    self.mockTwitterComposer = nil;
}

- (void)testIsUserNotLoggedIn
{
    [[[self.mockTwitterKitSessionStore stub] andReturn:nil] session];
    [[[self.mockTwitterKitSession stub] andReturn:@"test123"] userID];
    BOOL isUserLoggedIn =  [self.crowdmixTwitterService isUserLoggedIn];
    XCTAssertTrue(isUserLoggedIn == NO, @"user login status should be NO");
}

- (void)testIsUserLoggedIn
{
    [[[self.mockTwitterKitSessionStore stub] andReturn:self.mockTwitterKitSession] session];
    [[[self.mockTwitterKitSession stub] andReturn:@"test123"] userID];
    BOOL isUserLoggedIn =  [self.crowdmixTwitterService isUserLoggedIn];
    XCTAssertTrue(isUserLoggedIn == YES, @"user login status should be NO");
}

-(void) testLoginSuccessfully
{
    void (^proxyBlock)(NSInvocation *) = ^(NSInvocation *invocation)
    {
        void (^passedBlock)(TWTRSession * _Nullable session, NSError * _Nullable error);
        [invocation getArgument:&passedBlock atIndex:2];
        passedBlock(self.mockTwitterKitSession, nil);
    };
    
    __block BOOL isFinished = NO;
    __block BOOL loginSuccess = NO;
    [[[self.mockTwitter stub] andDo:proxyBlock] logInWithCompletion:[OCMArg any]];
    
    [self.crowdmixTwitterService loginWithCompletionBlock:^(BOOL success, NSError *error)
    {
        loginSuccess = success;
        isFinished = YES;
    }];
    
    while(!isFinished)
    {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        [NSThread sleepForTimeInterval:0.1];
    }
    
    XCTAssertTrue(loginSuccess == YES,@"login should be successfull");
    
}

-(void) testLoginFailed
{
    void (^proxyBlock)(NSInvocation *) = ^(NSInvocation *invocation)
    {
        void (^passedBlock)(TWTRSession * _Nullable session, NSError * _Nullable error);
        [invocation getArgument:&passedBlock atIndex:2];
        passedBlock(nil, nil);
    };
    
    __block BOOL isFinished = NO;
    __block BOOL loginSuccess = NO;
    [[[self.mockTwitter stub] andDo:proxyBlock] logInWithCompletion:[OCMArg any]];
    
    [self.crowdmixTwitterService loginWithCompletionBlock:^(BOOL success, NSError *error)
     {
         loginSuccess = success;
         isFinished = YES;
     }];
    
    while(!isFinished)
    {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        [NSThread sleepForTimeInterval:0.1];
    }
    
    XCTAssertTrue(loginSuccess == NO,@"login should be failed");
    
}

-(void) testFetchHomeTimeLineSuccessfully
{
    [[[self.mockTwitterClient stub] andReturn:OCMOCK_ANY] URLRequestWithMethod:OCMOCK_ANY URL:OCMOCK_ANY parameters:OCMOCK_ANY error:[OCMArg anyObjectRef]];
    
    
    id mockUrlResponse = [OCMockObject mockForClass:[NSHTTPURLResponse class]];
    [[[mockUrlResponse stub] andReturnValue:OCMOCK_VALUE(200)] statusCode];

    void (^proxyBlock)(NSInvocation *) = ^(NSInvocation *invocation)
    {
        void (^passedBlock)(NSURLResponse *response, NSData *data, NSError *connectionError);
        [invocation getArgument:&passedBlock atIndex:3];
        NSString *filePath = [[[NSBundle bundleForClass:[self class]] resourcePath] stringByAppendingPathComponent:@"test_hometimeline.json"];
        
        NSData* jsonData = [NSData dataWithContentsOfFile:filePath];

        passedBlock(mockUrlResponse,jsonData,nil);
    };
    
    [[[self.mockTwitterClient stub] andDo:proxyBlock] sendTwitterRequest:OCMOCK_ANY completion:OCMOCK_ANY];
    
    __block BOOL isFinished = NO;
    __block NSArray *timelineTweets;
    
    [self.crowdmixTwitterService downloadHomeTimeLineWithCompletionBlock:^(NSArray *tweets, NSError *error)
    {
        timelineTweets = tweets;
        isFinished = YES;
    }];
    
    while(!isFinished)
    {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        [NSThread sleepForTimeInterval:0.1];
    }
    
    CrowdmixTweet *tweet = timelineTweets[0];
    CrowdmixTweetUser *user = tweet.tweetUser;
    XCTAssertTrue(timelineTweets.count == 20,@"number of tweets should be 20");
    XCTAssertTrue([user.screenName isEqualToString:@"RailMinIndia"],@"Incorrect screen name");
    XCTAssertTrue([user.name isEqualToString:@"Ministry of Railways"],@"Incorrect name");
    XCTAssertTrue([user.profileImageURL isEqualToString:@"https://pbs.twimg.com/profile_images/485049154880536576/ZoQ3rXKw_normal.png"],@"Incorrect profile image URL");
    NSString *tweetText = @"RT @narendramodi: What a match! Proud of our team. Great innings @imVkohli &amp; exemplary leadership @msdhoni.";
    
    XCTAssertTrue([tweet.text isEqualToString:tweetText],@"Incorrect tweet text");
    
}


-(void) testFetchHomeTimeLineFailed
{
    [[[self.mockTwitterClient stub] andReturn:OCMOCK_ANY] URLRequestWithMethod:OCMOCK_ANY URL:OCMOCK_ANY parameters:OCMOCK_ANY error:[OCMArg anyObjectRef]];
    
    
    id mockUrlResponse = [OCMockObject mockForClass:[NSHTTPURLResponse class]];
    [[[mockUrlResponse stub] andReturnValue:OCMOCK_VALUE(400)] statusCode];

    void (^proxyBlock)(NSInvocation *) = ^(NSInvocation *invocation)
    {
        void (^passedBlock)(NSURLResponse *response, NSData *data, NSError *connectionError);
        [invocation getArgument:&passedBlock atIndex:3];
        passedBlock(mockUrlResponse,nil,nil);
    };
    
    [[[self.mockTwitterClient stub] andDo:proxyBlock] sendTwitterRequest:OCMOCK_ANY completion:OCMOCK_ANY];
    
    __block BOOL isFinished = NO;
    __block NSArray *timelineTweets;
    [self.crowdmixTwitterService downloadHomeTimeLineWithCompletionBlock:^(NSArray *tweets, NSError *error)
     {
         timelineTweets = tweets;
         isFinished = YES;
     }];
    
    while(!isFinished)
    {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        [NSThread sleepForTimeInterval:0.1];
    }
    
    XCTAssertTrue(timelineTweets.count == 0,@"number of tweets should be 0");
    
    
}



@end
