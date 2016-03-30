//
//  CrowdmixTweetExtendedEntities.h
//  CrowdmixTwitter
//
//  Created by Appaji Tholeti on 30/03/2016.
//  Copyright © 2016 Tholeti. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface CrowdmixTweetExtendedEntities : MTLModel <MTLJSONSerializing>

@property (nonatomic,strong,readonly) NSArray *mediaArray;


@end
