//
//  CrowdmixTweetHashTag.h
//  CrowdmixTwitter
//
//  Created by Appaji Tholeti on 28/03/2016.
//  Copyright © 2016 Tholeti. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface CrowdmixTweetHashTag : MTLModel <MTLJSONSerializing>

@property (nonatomic,copy,readonly) NSString *text;
@property (nonatomic,copy,readonly) NSArray *indices;

@end
