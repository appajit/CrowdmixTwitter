//
//  HomeTimeLineViewControllerTests.m
//  CrowdmixTwitter
//
//  Created by Appaji Tholeti on 28/03/2016.
//  Copyright © 2016 Tholeti. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "OCMock.h"
#import "HomeTimeLinePresenter.h"
#import "HomeTimeLineViewController.h"
#import "HomeTimeLineContentPanelFactory.h"
#import "HomeTimeLineTableViewCell.h"
#import "TweetViewModel.h"


@interface HomeTimeLineViewControllerTests : XCTestCase

@property (nonatomic,strong) id mockPresenter;
@property (nonatomic,strong) HomeTimeLineViewController *homeTimeLineViewController;


@end

@implementation HomeTimeLineViewControllerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
  
    self.mockPresenter = [OCMockObject niceMockForClass:[HomeTimeLinePresenter class]];
    UIStoryboard* storyBoard = [UIStoryboard storyboardWithName:@"Main"  bundle:nil];
    UINavigationController *timeLineNavigationController = (UINavigationController*)[storyBoard instantiateViewControllerWithIdentifier:@"HomeTimeLineNavigationController"];
    
    self.homeTimeLineViewController = (HomeTimeLineViewController*)timeLineNavigationController.topViewController;
    [self.homeTimeLineViewController injectPresenter:self.mockPresenter];
   
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}



- (void)testFetchHomeTimeLineCalledOnViewWillAppear
{
    [[self.mockPresenter expect] fetchHomeTimeLineDataWithCompletionHandler:OCMOCK_ANY];
 
    (void)self.homeTimeLineViewController.view;
    [self.homeTimeLineViewController viewWillAppear:NO];
    
    [self.mockPresenter verify];
}

-(void) testNumberOfRowsCalculatedCorrectly
{
    void (^proxyBlock)(NSInvocation *) = ^(NSInvocation *invocation)
    {
        void (^passedBlock)(NSArray *tweetViewModels,NSError *error);
        [invocation getArgument:&passedBlock atIndex:2];
      
        NSArray *tweetViewModels = @[[TweetViewModel new],[TweetViewModel new]];
        passedBlock(tweetViewModels, nil);
    };
    
    [[[self.mockPresenter stub] andDo:proxyBlock] fetchHomeTimeLineDataWithCompletionHandler:OCMOCK_ANY];
    
    (void)self.homeTimeLineViewController.view;
    [self.homeTimeLineViewController viewWillAppear:NO];
    
    id mockTableView = [OCMockObject niceMockForClass:[UITableView class]];
    NSUInteger rows =  [self.homeTimeLineViewController tableView:mockTableView numberOfRowsInSection:0];
    
    XCTAssertTrue(rows = 2,@"number of rows should 2");
}


-(void) testTimeLineTableViewCellDataConfiguredCorrectly
{
    void (^proxyBlock)(NSInvocation *) = ^(NSInvocation *invocation)
    {
        void (^passedBlock)(NSArray *tweetViewModels,NSError *error);
        [invocation getArgument:&passedBlock atIndex:2];

        TweetViewModel* viewModel1 = [TweetViewModel new];
        viewModel1.name = @"user1";
        viewModel1.screenName = @"@user1_screen_name";
        viewModel1.tweetText = [[NSAttributedString alloc] initWithString:@"user1_tweet_text"];
        
        TweetViewModel* viewModel2 = [TweetViewModel new];
        viewModel2.name = @"user2";
        viewModel2.screenName = @"@user2_screen_name";
        viewModel2.tweetText = [[NSAttributedString alloc] initWithString:@"user2_tweet_text"];;
        
        NSArray *tweetViewModels = @[viewModel1,viewModel2];
        passedBlock(tweetViewModels, nil);
    };
    
    [[[self.mockPresenter stub] andDo:proxyBlock] fetchHomeTimeLineDataWithCompletionHandler:OCMOCK_ANY];
    
    (void)self.homeTimeLineViewController.view;
    [self.homeTimeLineViewController viewWillAppear:NO];
    
    HomeTimeLineTableViewCell *cell;
    cell = (HomeTimeLineTableViewCell*) [self.homeTimeLineViewController tableView:self.homeTimeLineViewController.tableView
                                                                                        cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    XCTAssertTrue([cell.nameLabel.text isEqual:@"user1"],@"name label is incorrect");
    XCTAssertTrue([cell.screenNameLabel.text isEqual:@"@user1_screen_name"],@"screen name label is incorrect");
    XCTAssertTrue([cell.tweetTextView.text isEqual:@"user1_tweet_text"],@"screen name label is incorrect");
    
    
    cell = (HomeTimeLineTableViewCell*) [self.homeTimeLineViewController tableView:self.homeTimeLineViewController.tableView
                                                             cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    XCTAssertTrue([cell.nameLabel.text isEqual:@"user2"],@"name label is incorrect");
    XCTAssertTrue([cell.screenNameLabel.text isEqual:@"@user2_screen_name"],@"screen name label is incorrect");
    XCTAssertTrue([cell.tweetTextView.text isEqual:@"user2_tweet_text"],@"screen name label is incorrect");

}



@end
