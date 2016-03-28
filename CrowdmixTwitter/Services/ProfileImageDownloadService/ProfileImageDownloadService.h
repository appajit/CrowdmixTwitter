//
//  ProfileImageDownloadService.h
//  CrowdmixTwitter
//
//  Created by Appaji Tholeti on 28/03/2016.
//  Copyright (c) 2014 Appaji Tholeti. All rights reserved.
//

#import "ProfileImageDownloading.h"


@interface ProfileImageDownloadService : NSObject<ProfileImageDownloading>

/**
 *   Instance method with the dependency injection of NSURLSession object.By injecting the dependency object
 *   ,it will help to mock the url session object as part of unit testing of download API.
 *
 *  @param urlSession  url session object which enables the caching of the URL data, to avoid downloading the
 *                     same data from the server, and also limits the concurrent downloads to 5 for efficient
                       memory usage.
 *
 */
-(instancetype) initWithUrlSession:(NSURLSession*) urlSession;

@end
