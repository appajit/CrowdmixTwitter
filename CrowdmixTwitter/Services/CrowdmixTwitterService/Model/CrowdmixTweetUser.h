//
//  CrowdmixTweetUser.h
//  CrowdmixTwitter
//
//  Created by Appaji Tholeti on 24/03/2016.
//  Copyright © 2016 Tholeti. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface CrowdmixTweetUser : MTLModel <MTLJSONSerializing>


/**
 *  tweet user name
 */
@property (nonatomic, copy, readonly) NSString *name;
/**
 *  tweet user screen name
 */
@property (nonatomic, copy, readonly) NSString *screenName;
/**
 *  tweet user profile image URL
 */
@property (nonatomic, copy, readonly) NSString *profileImageURL;

@end
