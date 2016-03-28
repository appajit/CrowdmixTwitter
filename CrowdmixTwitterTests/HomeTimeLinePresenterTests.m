//
//  HomeTimeLinePresenterTests.m
//  CrowdmixTwitter
//
//  Created by Appaji Tholeti on 28/03/2016.
//  Copyright © 2016 Tholeti. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "OCMock.h"
#import "CrowdmixTwitterServicing.h"
#import "ProfileImageDownloadService.h"
#import "CrowdmixTweet.h"
#import "CrowdmixTweetUser.h"
#import "HomeTimeLinePresenter.h"
#import "TweetViewModel.h"
#import "NSDateFormatter+Twitter.h"

@interface HomeTimeLinePresenterTests : XCTestCase

@property (nonatomic,strong) id mockCrowdmixTwitterService;
@property (nonatomic,strong) id mockProfileImageDownloadService;
@property (nonatomic,strong) HomeTimeLinePresenter *homeTimeLinePresenter;


@end

@implementation HomeTimeLinePresenterTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.mockCrowdmixTwitterService = [OCMockObject niceMockForProtocol:@protocol(CrowdmixTwitterServicing)];
    self.mockProfileImageDownloadService = [OCMockObject niceMockForProtocol:@protocol(ProfileImageDownloading)];
    self.homeTimeLinePresenter = [[HomeTimeLinePresenter alloc] initWithCrowdmixTwitterService:self.mockCrowdmixTwitterService
                                                                         profileImageDownlader:self.mockProfileImageDownloadService
                                                                               completionBlock:nil];
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    self.mockCrowdmixTwitterService = nil;
    self.mockProfileImageDownloadService = nil;
    self.homeTimeLinePresenter = nil;
}

- (void)testFetchHomeTimeLineDataSuccesfully
{
    void (^proxyBlock)(NSInvocation *) = ^(NSInvocation *invocation)
    {
        void (^passedBlock)(NSArray *tweets,NSError *error);
        [invocation getArgument:&passedBlock atIndex:2];
       
        NSString *tweetDateString = [[NSDateFormatter twitterDateFormatter] stringFromDate:[[NSDate date]  dateByAddingTimeInterval:-60*15]];
        
        NSArray * tweetsJsonArray = @[@{@"created_at": tweetDateString,
                                   @"id": @11,
                                   @"text": @"user1_tweet_text",
                                   @"user": @{
                                       @"name": @"user1",
                                       @"screen_name": @"user1_screename",
                                       @"profile_image_url_https": @"user1_screename.png"}
                                   },
                                 @{@"created_at": tweetDateString,
                                   @"id": @22,
                                   @"text": @"user2_tweet_text",
                                   @"user": @{
                                           @"name": @"user2",
                                           @"screen_name": @"user2_screename",
                                           @"profile_image_url_https": @"user2_screename.png"}
                                   }
                                 ];
        
        NSError *error;
        NSArray* tweets = [MTLJSONAdapter modelsOfClass:[CrowdmixTweet class]
                                          fromJSONArray:tweetsJsonArray
                                                  error:&error];
        
        passedBlock(tweets,nil);
    };
   
    [[[self.mockCrowdmixTwitterService stub] andDo:proxyBlock] downloadHomeTimeLineWithCompletionBlock:OCMOCK_ANY];
    
    __block BOOL isFinished = NO;
    __block NSArray *timeLineTweetViewModels;
    
    [self.homeTimeLinePresenter fetchHomeTimeLineDataWithCompletionHandler:^(NSArray *tweetViewModels, NSError *error)
    {
        isFinished = YES;
        timeLineTweetViewModels = [tweetViewModels copy];
    }];
    
    while(!isFinished)
    {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        [NSThread sleepForTimeInterval:0.1];
    }
    
    TweetViewModel *tweetViewModel = timeLineTweetViewModels[0];
    TweetViewModel *tweetViewModel1 = timeLineTweetViewModels[1];
    XCTAssertTrue(timeLineTweetViewModels.count == 2,@"number of tweet view models should be 2");
    XCTAssertTrue([tweetViewModel.name isEqualToString:@"user1"],@"incorrect tweet user name");
    XCTAssertTrue([tweetViewModel.screenName isEqualToString:@"@user1_screename"],@"incorrect tweet user screen name");
    XCTAssertTrue([tweetViewModel.tweetText isEqualToString:@"user1_tweet_text"],@"incorrect tweet text");
    XCTAssertTrue([tweetViewModel.tweetAge isEqualToString:@"15m"],@"incorrect tweet text");
    XCTAssertTrue([tweetViewModel1.name isEqualToString:@"user2"],@"incorrect tweet user name");
    
}


- (void)testFetchProfileImageFromURLSuccesfully
{
    void (^homeTimeLineProxyBlock)(NSInvocation *) = ^(NSInvocation *invocation)
    {
        void (^passedBlock)(NSArray *tweets,NSError *error);
        [invocation getArgument:&passedBlock atIndex:2];
        
        NSArray * tweetsJsonArray = @[@{@"created_at": @"Sun Mar 27 18:01:25 +0000 2016",
                                        @"id": @11,
                                        @"text": @"user1_tweet_text",
                                        @"user": @{
                                                @"name": @"user1",
                                                @"screen_name": @"user1_screename",
                                                @"profile_image_url_https": @"user1_screename.png"}
                                        }
                                      ];
        
        NSError *error;
        NSArray* tweets = [MTLJSONAdapter modelsOfClass:[CrowdmixTweet class]
                                          fromJSONArray:tweetsJsonArray
                                                  error:&error];
        
        passedBlock(tweets,nil);
    };
    
    [[[self.mockCrowdmixTwitterService stub] andDo:homeTimeLineProxyBlock] downloadHomeTimeLineWithCompletionBlock:OCMOCK_ANY];
    
    __block NSString *imageURL;
    void (^imageDownloadProxyBlock)(NSInvocation *) = ^(NSInvocation *invocation)
    {
        void (^passedBlock)(NSData *imageData);
        [invocation getArgument:&passedBlock atIndex:3];
        
        [invocation getArgument:&imageURL atIndex:2];
        NSString *filePath = [[[NSBundle bundleForClass:[self class]] resourcePath] stringByAppendingPathComponent:@"tweet_profile_image.png"];
        
        NSData* imageData = [NSData dataWithContentsOfFile:filePath];
        passedBlock(imageData);
    };
    [[[self.mockProfileImageDownloadService stub] andDo:imageDownloadProxyBlock] downloadProfileImageFromURL:OCMOCK_ANY withCompletionBlock:OCMOCK_ANY];
    
    
    __block BOOL isFinished = NO;
    __block TweetViewModel *viewModel;
    __weak typeof(self)weakSelf = self;
    
    [self.homeTimeLinePresenter fetchHomeTimeLineDataWithCompletionHandler:^(NSArray *tweetViewModels, NSError *error)
     {
         viewModel = tweetViewModels[0];
         
         [weakSelf.homeTimeLinePresenter fetchProfileImageForViewModel:viewModel
                                                 withCompletionHandler:^
         {
             isFinished = YES;
             
         }];
     }];
    
    while(!isFinished)
    {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        [NSThread sleepForTimeInterval:0.1];
    }
    
    XCTAssertTrue([imageURL isEqualToString:@"user1_screename.png"],@"incorrect image url ");
    XCTAssertNotNil(viewModel.profileImage,@"profile image should not be nil");
}


-(void) testComposeTweet
{
    void (^proxyBlock)(NSInvocation *) = ^(NSInvocation *invocation)
    {
        void (^passedBlock)();
        [invocation getArgument:&passedBlock atIndex:3];
        passedBlock();
    };
    
    [[[self.mockCrowdmixTwitterService stub] andDo:proxyBlock] composeTweetFromViewController:OCMOCK_ANY withCompletionBlock:OCMOCK_ANY];
    
    UIViewController *viewController = [UIViewController new];
    __block BOOL isFinished = NO;
    __block BOOL isCompletionBlockCalled = NO;
    [self.homeTimeLinePresenter composeTweetFromViewController:viewController withCompletionHandler:^
    {
        isFinished = YES;
        isCompletionBlockCalled = YES;
    }];
    
    while(!isFinished)
    {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        [NSThread sleepForTimeInterval:0.1];
    }
    
    XCTAssertTrue(isCompletionBlockCalled, @"competion block is not called");
    
}

@end
