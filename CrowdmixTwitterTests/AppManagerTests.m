//
//  AppManagerTests.m
//  CrowdmixTwitter
//
//  Created by Appaji Tholeti on 24/03/2016.
//  Copyright © 2016 Tholeti. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "OCMock.h"
#import "CrowdmixTwitterServicing.h"
#import "AppManager.h"
#import "LoginViewController.h"
#import "HomeTimeLineViewController.h"

@interface AppManagerTests : XCTestCase

@property (nonatomic,strong) id mockCrowdmixTwitterService;
@property (nonatomic,strong) AppManager *appManager;

@end

@implementation AppManagerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.mockCrowdmixTwitterService = [OCMockObject niceMockForProtocol:@protocol(CrowdmixTwitterServicing)];
    self.appManager = [AppManager sharedManager];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void) testLoginScreenShownWhenUserIsNotLoggedIn
{
    [[[self.mockCrowdmixTwitterService stub] andReturnValue:OCMOCK_VALUE(NO)] isUserLoggedIn];
    
    UIWindow *window =  [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.appManager prepareAppContentWithWindow:window
                          crowdmixTwitterService:self.mockCrowdmixTwitterService];
    
    
    BOOL isLoginScreen = [window.rootViewController isMemberOfClass:[LoginViewController class]];
    
    XCTAssertTrue(isLoginScreen == YES,@"login screen should be shown");
}

-(void) testTimeLineScreenShownWhenUserIsLoggedIn
{
    [[[self.mockCrowdmixTwitterService stub] andReturnValue:OCMOCK_VALUE(YES)] isUserLoggedIn];
    
    UIWindow *window =  [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.appManager prepareAppContentWithWindow:window
                          crowdmixTwitterService:self.mockCrowdmixTwitterService];
    
    UINavigationController *navigationController = (UINavigationController*)window.rootViewController;
    BOOL isTimeLineScreen = [navigationController.topViewController isMemberOfClass:[HomeTimeLineViewController class]];
    
    XCTAssertTrue(isTimeLineScreen == YES,@"home timeline screen should be shown");
}

@end
