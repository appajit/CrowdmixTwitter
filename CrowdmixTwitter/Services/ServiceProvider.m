//
//  ServiceProvider.m
//  CrowdmixTwitter
//
//  Created by Appaji Tholeti on 24/03/2016.
//  Copyright © 2016 Tholeti. All rights reserved.
//

#import "ServiceProvider.h"
#import "CrowdmixTwitterService.h"
#import "ProfileImageDownloadService.h"
#import "TwitterKitAPI.h"
#import "NSURLSession+Cacheable.h"

@interface ServiceProvider ()
{
    CrowdmixTwitterService      *_crowdmixTwitterService;
    ProfileImageDownloadService *_profileImageDownloadService;
}

@end

@implementation ServiceProvider


+(ServiceProvider*) sharedInstance
{
    static ServiceProvider *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,
                  ^{
                      sharedInstance = [ServiceProvider new];
                  });
    
    return sharedInstance;
}



-(id<CrowdmixTwitterServicing>) crowdmixTwitterService
{
    /* lazy loading of the service object */
    if(!_crowdmixTwitterService)
    {
        _crowdmixTwitterService = [[CrowdmixTwitterService alloc] initTwitterKitAPI:[TwitterKitAPI new]];
    }
    
    return _crowdmixTwitterService;
}

-(id<ProfileImageDownloading>) profileImageDownloadService
{
    /* lazy loading of the service object */
    if(!_profileImageDownloadService)
    {
        _profileImageDownloadService = [[ProfileImageDownloadService alloc] initWithUrlSession:[NSURLSession cacheableUrlSession]];
    }
    
    return _profileImageDownloadService;
}


@end
