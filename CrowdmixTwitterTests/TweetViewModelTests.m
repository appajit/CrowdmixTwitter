//
//  TweetViewModelTests.m
//  CrowdmixTwitter
//
//  Created by Appaji Tholeti on 28/03/2016.
//  Copyright © 2016 Tholeti. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "OCMock.h"
#import "CrowdmixTweet.h"
#import "CrowdmixTweetUser.h"
#import "CrowdmixTweetEntities.h"
#import "CrowdmixTweetHashTag.h"
#import "TweetViewModel.h"

@interface TweetViewModelTests : XCTestCase

@end

@implementation TweetViewModelTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testViewDataConfiguredCorrectly
{
    NSDictionary*tweetJsonDictionary = @{@"created_at": @"Sun Mar 27 18:01:25 +0000 2016",
                                         @"id": @11,
                                         @"text": @"user1_#hashTagText",
                                         @"user": @{
                                                 @"name": @"user1",
                                                 @"screen_name": @"user1_screename",
                                                 @"profile_image_url_https": @"user1_screename.png"},
                                         @"user": @{
                                                 @"name": @"user1",
                                                 @"screen_name": @"user1_screename",
                                                 @"profile_image_url_https": @"user1_screename.png"},
                                         @"entities": @{
                                             @"hashtags": @[
                                                     @{@"text" : @"hashTagText",
                                                       @"indices" : @[@6,@17]}]}
                                         };
    
    NSError* error;
    CrowdmixTweet *tweet = [MTLJSONAdapter modelOfClass:[CrowdmixTweet class]
                                     fromJSONDictionary:tweetJsonDictionary
                                                  error:&error];
    
    TweetViewModel *viewModel = [TweetViewModel viewModelFromCrowdmixTweet:tweet];
}



@end
