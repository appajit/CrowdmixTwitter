//
//  CrowmixTweetEntities.m
//  CrowdmixTwitter
//
//  Created by Appaji Tholeti on 28/03/2016.
//  Copyright © 2016 Tholeti. All rights reserved.
//

#import "CrowdmixTweetEntities.h"
#import "CrowdmixTweetHashTag.h"

@implementation CrowdmixTweetEntities

/* mapping from json to object properties */
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"hashTags"   : @"hashtags"
             };
}

/* transforms the tweet json hash tags  into CrowdmixTweetHashTag object array property */
+ (NSValueTransformer *)hashTagsJSONTransformer
{
    return [MTLJSONAdapter arrayTransformerWithModelClass:[CrowdmixTweetHashTag class]];
}



@end
