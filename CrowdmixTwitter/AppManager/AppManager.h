//
//  AppManager.h
//  CrowdmixTwitter
//
//  Created by Appaji Tholeti on 24/03/2016.
//  Copyright © 2016 Tholeti. All rights reserved.
//


@protocol CrowdmixTwitterServicing;

@interface AppManager : NSObject
/**
 *  creates singleton instance object
 *
 *  @param sharedManager App Manager to control the App content to show
 *
 *  @return instance object
 */

+(AppManager*) sharedManager;

/**
 *  Decides What App UI to show basing upon the user actions
 *
 *  @param window  UI mainwindow to set the different UI screens
 *
 *  @param crowdMixTwitterService twitter service to handle twitters specific functionality
 */

-(void) prepareAppContentWithWindow:(UIWindow*) window
             crowdmixTwitterService:(id<CrowdmixTwitterServicing>) crowdMixTwitterService;

@end
