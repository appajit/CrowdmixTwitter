//
//  CrowdmixTwitterServicing.h
//  CrowdmixTwitter
//
//  Created by Appaji Tholeti on 28/03/2016.
//  Copyright © 2016 Tholeti. All rights reserved.
//

typedef void(^TwitterLoginCompletionBlock)(BOOL success,NSError *error);
typedef void(^DownloadHomeTimelineCompletionBlock)(NSArray *tweets,NSError *error);
typedef void(^ComposeTweetCompletionBlock)();


@protocol CrowdmixTwitterServicing <NSObject>

/**
 *  Provides user log in status
 *
 *  @return user log in status
 */

-(BOOL) isUserLoggedIn;

/**
 *   This method will present webview based UI to allow the user to log in if there are no saved Twitter login  credentials.
 *
 *  @param completionBlock The completion block will be called after authentication is successful or if there is an error.
 *
 */
-(void) loginWithCompletionBlock:(TwitterLoginCompletionBlock)completionBlock;

/**
 *  Clears the local user twitter session.This will not remove the system Twitter account nor make a network request to invalidate the session.
 *
 */
-(void) logout;

/**
 *  Downloads the user home time line data from the server
 *
 *  @param completionBlock completion bloc to notify downloaded user time line data
 *
 */

-(void) downloadHomeTimeLineWithCompletionBlock:(DownloadHomeTimelineCompletionBlock) completionBlock;

/**
 *  Presents the composer, with an optional completion handler from the specified view controller.
 *
 *  @param viewController The controller in which to present the composer from.
 *
 * @param completionBlock  The completion block to notify when composition is completed.
 *
 */
-(void) composeTweetFromViewController:(UIViewController*) viewController
                   withCompletionBlock:(ComposeTweetCompletionBlock) completionBlock;
@end
