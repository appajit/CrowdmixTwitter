//
//  CrowdmixTweetUrl.h
//  CrowdmixTwitter
//
//  Created by Appaji Tholeti on 29/03/2016.
//  Copyright © 2016 Tholeti. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface CrowdmixTweetUrl : MTLModel <MTLJSONSerializing>

/* indices of url in the tweet text */
@property (nonatomic,strong,readonly) NSArray *indices;


@end
