//
//  LoginContentPanelFactory.h
//  CrowdmixTwitter
//
//  Created by Appaji Tholeti on 28/03/2016.
//  Copyright © 2016 Tholeti. All rights reserved.
//


@interface LoginContentPanelFactory : NSObject

/*
 * Creates the home time line view controller by injecting all the required objects such as services
 *
 *  @param completionBlock block to notify when user logged in successfully
 *
 *  @return returns LoginViewController
 */
+(UIViewController*) contentPanelWithCompletionBlock:(void(^)()) completionBlock;

@end
