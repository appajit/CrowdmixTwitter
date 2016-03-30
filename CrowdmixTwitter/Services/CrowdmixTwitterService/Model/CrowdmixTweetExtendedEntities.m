//
//  CrowdmixTweetExtendedEntities.m
//  CrowdmixTwitter
//
//  Created by Appaji Tholeti on 30/03/2016.
//  Copyright © 2016 Tholeti. All rights reserved.
//

#import "CrowdmixTweetExtendedEntities.h"
#import "CrowdmixTweetMedia.h"

@implementation CrowdmixTweetExtendedEntities


/* mapping from json to object properties */
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"mediaArray"   : @"media"
             };
}

/* transforms the tweet json url  into CrowdmixTweetUrl object array property */
+ (NSValueTransformer *)mediaArrayJSONTransformer
{
    return [MTLJSONAdapter arrayTransformerWithModelClass:[CrowdmixTweetMedia class]];
}

@end
