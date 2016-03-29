//
//  CrowdmixTwitterService.m
//  CrowdmixTwitter
//
//  Created by Appaji Tholeti on 28/03/2016.
//  Copyright © 2016 Tholeti. All rights reserved.
//

#import <Mantle/MTLJSONAdapter.h>
#import <TwitterKit/TwitterKit.h>
#import "CrowdmixTwitterService.h"
#import "CrowdmixTweet.h"
#import "TwitterKitAPI.h"


/* TwitterKit requires to register  the App with Twitter Apps to get consumer key and secret keys in order to access
 * TwitterKit API. site to register: https://apps.twitter.com
 */
static NSString * const kConsumerKey = @"J9l68t9hz1yxcuHIa4oLhPEL9";
static NSString * const kConsumerSecret = @"CJl5d7BTay0I1ceZraUIAtOCrYNo1MFopSJ71LjU27KbxnEKCt";
static NSString * const kHomeTimeLinesURL = @"https://api.twitter.com/1.1/statuses/home_timeline.json";
static NSUInteger const kMaxTweets = 20;

@interface CrowdmixTwitterService ()

@property (nonatomic,strong) TwitterKitAPI *twitterKitAPI;

@end

@implementation CrowdmixTwitterService


-(instancetype) initTwitterKitAPI:(TwitterKitAPI*) twitterKitAPI
{
    
    self = [super init];
    if(self)
    {
        _twitterKitAPI = twitterKitAPI;
        [self.twitterKitAPI.twitter startWithConsumerKey:kConsumerKey
                                          consumerSecret:kConsumerSecret];
    }
    
    return self;
    
}

-(BOOL) isUserLoggedIn
{
    return (self.twitterKitAPI.twitter.sessionStore.session) ? YES : NO;
}

-(void) loginWithCompletionBlock:(TwitterLoginCompletionBlock)completionBlock
{
    [self.twitterKitAPI.twitter logInWithCompletion:^(TWTRSession * _Nullable session, NSError * _Nullable error)
     {
         if(completionBlock)
         {
             completionBlock((session ? YES :NO),error);
         }
     }];
}

-(void) downloadHomeTimeLineWithCompletionBlock:(DownloadHomeTimelineCompletionBlock) completionBlock
{
    TWTRAPIClient *twitterClient = self.twitterKitAPI.twitterClient;
    
    NSError *clientError;
    
    /* configure the maximum number of tweets to fetch */
    NSDictionary *params  = @{@"count": [NSString stringWithFormat:@"%ld",kMaxTweets]};
    
    NSURLRequest *request = [twitterClient URLRequestWithMethod:@"GET"
                                                            URL:kHomeTimeLinesURL
                                                     parameters:params
                                                          error:&clientError];
    
    [twitterClient sendTwitterRequest:request
                           completion:^(NSURLResponse *response, NSData *data, NSError *connectionError)
     {
         NSInteger statuscode = [((NSHTTPURLResponse*)response) statusCode];
         if (statuscode == 200 && data)
         {
             NSArray *tweetsJsonArray;
             NSError* jsonError;
             tweetsJsonArray = [NSJSONSerialization JSONObjectWithData:data
                                                               options:NSJSONReadingAllowFragments
                                                                 error:&jsonError];
             
             /* if server sends more than 20 tweets, trim it to 20 */
              NSMutableArray *mutableTweetsJsonArray = [NSMutableArray arrayWithArray:tweetsJsonArray];
             if(tweetsJsonArray.count > kMaxTweets)
             {
                 [mutableTweetsJsonArray removeObjectsInRange:NSMakeRange(kMaxTweets, tweetsJsonArray.count-kMaxTweets)];
             }
             if(jsonError == nil)
             {
                 id responseObject = [MTLJSONAdapter modelsOfClass:[CrowdmixTweet class]
                                                  fromJSONArray:mutableTweetsJsonArray
                                                          error:&jsonError];
                 if(completionBlock)
                 {
                     completionBlock(responseObject,nil);
                 }
             }
             else
             {
                 if(completionBlock)
                 {
                     completionBlock(nil,jsonError);
                 }
             }
             
         }
         else
         {
             if(completionBlock)
             {
                 completionBlock(nil,connectionError);
             }
         }
     }];
}


-(void) composeTweetFromViewController:(UIViewController*) viewController
                   withCompletionBlock:(ComposeTweetCompletionBlock) completionBlock
{
    TWTRComposer *composer = self.twitterKitAPI.twitterComposer;
    
    // Called from a UIViewController
    [composer showFromViewController:viewController completion:^(TWTRComposerResult result)
     {
         if(completionBlock)
         {
             completionBlock();
         }
     }];
}

-(void) logout
{
    Twitter *twitter = self.twitterKitAPI.twitter;
    [twitter.sessionStore logOutUserID:twitter.sessionStore.session.userID];
}


@end
