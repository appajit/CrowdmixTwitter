//
//  HomeTimeLineContentPanelFactory.h
//  CrowdmixTwitter
//
//  Created by Appaji Tholeti on 28/03/2016.
//  Copyright © 2016 Tholeti. All rights reserved.
//


@interface HomeTimeLineContentPanelFactory : NSObject

/*
 * Creates the home time line view controller by injecting all the required objects such as presenter and services.
 * @param  completionBlock block to notify when user logs out
 * @return returns HomeTimeLineViewController
 */
+(UIViewController*) contentPanelWithCompletionBlock:(void(^)()) completionBlock;

@end
