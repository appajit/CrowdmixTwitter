//
//  CrowdmixTweetHashTag.m
//  CrowdmixTwitter
//
//  Created by Appaji Tholeti on 28/03/2016.
//  Copyright © 2016 Tholeti. All rights reserved.
//

#import "CrowdmixTweetHashTag.h"

@implementation CrowdmixTweetHashTag

/* mapping from json to object properties */
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"text"   : @"text",
             @"indices" : @"indices"
             };
}

@end
