//
//  CrowmixTweetEntities.h
//  CrowdmixTwitter
//
//  Created by Appaji Tholeti on 28/03/2016.
//  Copyright © 2016 Tholeti. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface CrowdmixTweetEntities : MTLModel <MTLJSONSerializing>

/* hash tag items */
@property (nonatomic,strong,readonly) NSArray *hashTags;

/* urla */
@property (nonatomic,strong,readonly) NSArray *urls;

@end
