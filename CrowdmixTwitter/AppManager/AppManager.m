//
//  AppManager.m
//  CrowdmixTwitter
//
//  Created by Appaji Tholeti on 24/03/2016.
//  Copyright © 2016 Tholeti. All rights reserved.
//

#import "AppManager.h"
#import "CrowdmixTwitterServicing.h"
#import "LoginContentPanelFactory.h"
#import "HomeTimeLineContentPanelFactory.h"


@interface AppManager()

@property (nonatomic,weak) id<CrowdmixTwitterServicing> crowdMixTwitterService;
@property (nonatomic,strong) UIWindow *window;

@end


@implementation AppManager


+(AppManager*) sharedManager
{
    static AppManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,
                  ^{
                      sharedManager = [AppManager new];
                  });
    
    return sharedManager;
}

-(void) prepareAppContentWithWindow:(UIWindow*) window
             crowdmixTwitterService:(id<CrowdmixTwitterServicing>) crowdMixTwitterService
{
    self.window = window;
    self.crowdMixTwitterService = crowdMixTwitterService;
    
    /* if user is already logged in, display the home time line screen with latest tweets */
    if([self.crowdMixTwitterService isUserLoggedIn] == YES)
    {
        [self showHomeTimeLine];
    }
    /* if user is not logged in, display the login screen to allow user to login */
    else
    {
        [self showLogin];
    }
}

-(void) showLogin
{
    __weak typeof(self)weakSelf = self;
    UIViewController *loginViewController = [LoginContentPanelFactory contentPanelWithCompletionBlock:^
                                             {
                                                 AppManager *strongSelf = weakSelf;
                                                 if(strongSelf)
                                                 {
                                                     [strongSelf showHomeTimeLine];
                                                 }
                                             }];
    
    self.window.rootViewController = loginViewController;
}


-(void) showHomeTimeLine
{
    __weak typeof(self)weakSelf = self;
    UIViewController *homeTimeLineViewController = [HomeTimeLineContentPanelFactory contentPanelWithCompletionBlock:^
    {
        AppManager *strongSelf = weakSelf;
        if(strongSelf)
        {
            [strongSelf showLogin];
        }
    }];
    
    self.window.rootViewController = homeTimeLineViewController;
}

@end

