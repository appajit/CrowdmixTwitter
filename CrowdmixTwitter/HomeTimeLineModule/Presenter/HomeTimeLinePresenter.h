//
//  HomeTimeLinePresenter.h
//  CrowdmixTwitter
//
//  Created by Appaji Tholeti on 28/03/2016.
//  Copyright © 2016 Tholeti. All rights reserved.
//

@protocol CrowdmixTwitterServicing;
@protocol ProfileImageDownloading;
@class TweetViewModel;


typedef void(^FetchDataCompletionHandler)(NSArray *tweetViewModels,NSError *error);
typedef void(^FetchProfileImageCompletionHandler)();
typedef void(^HomeTimeLineCompletionBlock)();
typedef void(^ComposeTweetCompletionHandler)();


/*
 * The Presenter class acts as a single point of contact to its view controller by abstracting
 * all the required services in the backgorund.It uses the respective service basing upon the view controller
 * request and provides the singel view model object by consuming different server data models.
 */

@interface HomeTimeLinePresenter : NSObject

/* 
 * instance method with all the required dependency service objects
 *
 * @param crowdMixTwitterService   twitter service object
 * 
 * @param profileImageDownloadService   profile image download service
 *
 * @param completionBlock  completion block to notify when user logs out
 */

-(instancetype) initWithCrowdmixTwitterService:(id<CrowdmixTwitterServicing>) crowdMixTwitterService
                         profileImageDownlader:(id<ProfileImageDownloading>) profileImageDownloadService
                               completionBlock:(HomeTimeLineCompletionBlock) completionBlock;


/*
 * fetches user home time line data after login
 *
 * @param completionHandler completion block to notify when data is available
 *
 */
-(void) fetchHomeTimeLineDataWithCompletionHandler:(FetchDataCompletionHandler) completionHandler;



/*
 * fetches user profile image data from the given image URL
 *
 * @param completionHandler completion block to notify when data is available
 *
 */
-(void) fetchProfileImageForViewModel:(TweetViewModel*) viewModel
                withCompletionHandler:(FetchProfileImageCompletionHandler) competionHandler;

/*
 * Provides the tweet composer UI to allow the user to type and sent the text.
 *
 * @param viewController view controller on which the composer UI to be presented.
 *
 * @param completionHandler completion block to notify when tweet is sent
 */
-(void) composeTweetFromViewController:(UIViewController*) viewController
                 withCompletionHandler:(ComposeTweetCompletionHandler) completionHandler;

/*
 * log out the user from the current twitter session
 */

-(void) logout;


@end
