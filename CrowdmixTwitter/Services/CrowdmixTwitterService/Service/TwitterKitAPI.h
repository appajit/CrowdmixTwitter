//
//  TwitterKitAPI.h
//  CrowdmixTwitter
//
//  Created by Appaji Tholeti on 28/03/2016.
//  Copyright © 2016 Tholeti. All rights reserved.
//

@class Twitter;
@class TWTRAPIClient;
@class TWTRComposer;

/* This object contains all the required TWitterKit objects to acheive different fucntionality of the twitter API. By collecting all the dependent objects into a single object, it will help to mock all the APIs as part of unit testing.
 */
@interface TwitterKitAPI : NSObject

/* twiiter object for login functionality */
@property (nonatomic,strong) Twitter *twitter;

/*twitterClient object to fetch home time line or any ther statuses */
@property (nonatomic,strong) TWTRAPIClient  *twitterClient;

/* twitterComposer object to provide the tweet composition functionality */
@property (nonatomic,strong) TWTRComposer *twitterComposer;
@end
