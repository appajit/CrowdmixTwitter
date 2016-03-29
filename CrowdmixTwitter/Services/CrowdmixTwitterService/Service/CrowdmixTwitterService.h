//
//  CrowdmixTwitterService.h
//  CrowdmixTwitter
//
//  Created by Appaji Tholeti on 28/03/2016.
//  Copyright © 2016 Tholeti. All rights reserved.
//

#import "CrowdmixTwitterServicing.h"

@class TwitterKitAPI;

@interface CrowdmixTwitterService : NSObject<CrowdmixTwitterServicing>

/**
*   Instance method with the dependency injection of TwitterKitAPI object.By injecting all TwitterKit object  dependencies,it will be easy to unit test all service APIs with the mocked TwitterKit objects.As there are more than one TwitterKi objects are required, all those depencies are passed as a single object.
*
*  @param twitterKitAPI  object which contains all TwitterKit dependecy objects such as   
                         Twitter,TWTRAPIClient,TWTRComposer.
*
*/
-(instancetype) initTwitterKitAPI:(TwitterKitAPI*) twitterKitAPI;

@end
