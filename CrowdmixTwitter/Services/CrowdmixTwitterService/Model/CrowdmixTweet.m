//
//  CrowdmixTweet.m
//  CrowdmixTwitter
//
//  Created by Appaji Tholeti on 24/03/2016.
//  Copyright © 2016 Tholeti. All rights reserved.
//

#import "CrowdmixTweet.h"
#import "CrowdmixTweetUser.h"
#import "NSDateFormatter+Twitter.h"

@implementation CrowdmixTweet

/* mapping from json to object properties */
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"tweetId"   : @"id",
             @"text"      : @"text",
             @"tweetUser" : @"user",
             @"createdAt" : @"created_at"
             };
}

/* transforms the tweet user info dictionary into CrowdmixTweetUser */
+ (NSValueTransformer *)tweetUserJSONTransformer
{
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:[CrowdmixTweetUser class]];
}

@end
