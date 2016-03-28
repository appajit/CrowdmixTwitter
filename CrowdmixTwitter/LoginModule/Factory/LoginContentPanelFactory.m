//
//  LoginContentPanelFactory.m
//  CrowdmixTwitter
//
//  Created by Appaji Tholeti on 28/03/2016.
//  Copyright © 2016 Tholeti. All rights reserved.
//

#import "LoginContentPanelFactory.h"
#import "LoginViewController.h"
#import "ServiceProvider.h"

@implementation LoginContentPanelFactory

+(UIViewController*) contentPanelWithCompletionBlock:(void(^)()) completionBlock
{
    UIStoryboard* storyBoard = [UIStoryboard storyboardWithName:@"Main"  bundle:nil];
    LoginViewController *viewController = (LoginViewController*)[storyBoard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    
    [viewController injectCrowdmixTwitterService:[[ServiceProvider sharedInstance] crowdmixTwitterService]
                                 completionBlock:completionBlock];
    return viewController;
}

@end
