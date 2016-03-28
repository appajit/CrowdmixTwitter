//
//  CrowdmixTweetUser.m
//  CrowdmixTwitter
//
//  Created by Appaji Tholeti on 24/03/2016.
//  Copyright © 2016 Tholeti. All rights reserved.
//

#import "CrowdmixTweetUser.h"


@implementation CrowdmixTweetUser

/* mapping from json to object properties */
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"name"            : @"name",
             @"profileImageURL" : @"profile_image_url_https",
             @"screenName"      :@"screen_name"
             };
}

@end
