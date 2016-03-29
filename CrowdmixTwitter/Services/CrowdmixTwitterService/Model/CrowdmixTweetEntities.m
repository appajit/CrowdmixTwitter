//
//  CrowmixTweetEntities.m
//  CrowdmixTwitter
//
//  Created by Appaji Tholeti on 28/03/2016.
//  Copyright © 2016 Tholeti. All rights reserved.
//

#import "CrowdmixTweetEntities.h"
#import "CrowdmixTweetHashTag.h"
#import "CrowdmixTweetUrl.h"

@implementation CrowdmixTweetEntities

/* mapping from json to object properties */
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"hashTags"   : @"hashtags",
              @"urls"   : @"urls"
             };
}

/* transforms the tweet json hash tags  into CrowdmixTweetHashTag object array property */
+ (NSValueTransformer *)hashTagsJSONTransformer
{
    return [MTLJSONAdapter arrayTransformerWithModelClass:[CrowdmixTweetHashTag class]];
}

/* transforms the tweet json url  into CrowdmixTweetUrl object array property */
+ (NSValueTransformer *)urlsJSONTransformer
{
    return [MTLJSONAdapter arrayTransformerWithModelClass:[CrowdmixTweetUrl class]];
}



@end
