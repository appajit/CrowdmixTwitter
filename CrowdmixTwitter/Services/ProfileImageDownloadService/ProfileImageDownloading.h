//
//  ProfileImageDownloading.h
//  CrowdmixTwitter
//
//  Created by Appaji Tholeti on 28/03/2016.
//  Copyright (c) 2014 Appaji Tholeti. All rights reserved.
//


typedef void(^ProfileImageDownloadCompletionBlock)(NSData *imageData);

@protocol ProfileImageDownloading <NSObject>

/**
 *  downloads the image data from the given image URL
 *
 *  @param imageURL       image URL to download
 *  @param completionBlock completion block to notify the downloaded image data
 */

-(void) downloadProfileImageFromURL:(NSString *) imageURL
                withCompletionBlock:(ProfileImageDownloadCompletionBlock) completionBlock;

@end
