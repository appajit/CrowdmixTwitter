//
//  ServiceProvider.h
//  CrowdmixTwitter
//
//  Created by Appaji Tholeti on 24/03/2016.
//  Copyright © 2016 Tholeti. All rights reserved.
//


@protocol CrowdmixTwitterServicing;
@protocol ProfileImageDownloading;

@interface ServiceProvider : NSObject

/**
 *  creates singleton instance object to provide different service objects
 *
 *  @param sharedInstance shared instance to access the object across multiple modules
 *
 *  @return instance object
 */

+(ServiceProvider*) sharedInstance;

/**
 *  provides twitter service object to handle twitter specific functionality
 *
 *  @return crowdmixTwitterService twitter service object
 *
 */

-(id<CrowdmixTwitterServicing>) crowdmixTwitterService;

/**
 *  provides user profile image download service object  to download the image from the given URL
 *
 *  @return profileImageDownloadService user profile image download service
 *
 */

-(id<ProfileImageDownloading>) profileImageDownloadService;

@end
