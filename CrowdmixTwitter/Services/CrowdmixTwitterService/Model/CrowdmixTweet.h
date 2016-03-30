//
//  CrowdmixTweet.h
//  CrowdmixTwitter
//
//  Created by Appaji Tholeti on 24/03/2016.
//  Copyright © 2016 Tholeti. All rights reserved.
//

#import <Mantle/Mantle.h>

@class CrowdmixTweetUser;
@class CrowdmixTweetEntities;

@interface CrowdmixTweet : MTLModel <MTLJSONSerializing>


@property (nonatomic,copy,readonly) NSNumber *tweetId;
/**
 *  tweet text
 */
@property (nonatomic, copy, readonly) NSString *text;

/**
 *  tweet posted date
 */
@property (nonatomic, copy, readonly) NSString *createdAt;

/**
 *  user of the tweet who posted it.
 */
@property (nonatomic,strong,readonly) CrowdmixTweetUser *tweetUser;


/**
 *  tweet entities such as hash tags etc.
 */
@property (nonatomic,strong,readonly) CrowdmixTweetEntities *entities;

@end
