//
//  HomeTimeLineContentPanelFactory.m
//  CrowdmixTwitter
//
//  Created by Appaji Tholeti on 28/03/2016.
//  Copyright © 2016 Tholeti. All rights reserved.
//

#import "HomeTimeLineContentPanelFactory.h"
#import "HomeTimeLineViewController.h"
#import "HomeTimeLinePresenter.h"
#import "ServiceProvider.h"

@implementation HomeTimeLineContentPanelFactory


+(UIViewController*) contentPanelWithCompletionBlock:(void(^)()) completionblock
{
    UIStoryboard* storyBoard = [UIStoryboard storyboardWithName:@"Main"  bundle:nil];
    UINavigationController *timeLineNavigationController = (UINavigationController*)[storyBoard instantiateViewControllerWithIdentifier:@"HomeTimeLineNavigationController"];
    
    HomeTimeLineViewController* timeLineViewController = (HomeTimeLineViewController*)timeLineNavigationController.topViewController;
    
    ServiceProvider *serviceProvider = [ServiceProvider sharedInstance];
    
    // create and confiure the presenter by injecting all the required objects
    HomeTimeLinePresenter *presenter;
    presenter = [[HomeTimeLinePresenter alloc] initWithCrowdmixTwitterService:[serviceProvider crowdmixTwitterService]
                                                        profileImageDownlader:[serviceProvider profileImageDownloadService]
                                                              completionBlock:completionblock];
    //inject the presenter
    [timeLineViewController injectPresenter:presenter];
    
    return timeLineNavigationController;
}

@end
