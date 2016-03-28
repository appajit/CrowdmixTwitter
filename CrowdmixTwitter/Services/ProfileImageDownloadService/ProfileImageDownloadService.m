//
//  ProfileImageDownloadService.m
//  CrowdmixTwitter
//
//  Created by Appaji Tholeti on 28/03/2016.
//  Copyright (c) 2014 Appaji Tholeti. All rights reserved.
//

#import "ProfileImageDownloadService.h"
#import "CrowdmixTweet.h"
#import "CrowdmixTweetUser.h"


@interface ProfileImageDownloadService ()

@property (nonatomic, strong) NSURLSession  *urlSession;

@end


@implementation ProfileImageDownloadService

-(instancetype) initWithUrlSession:(NSURLSession*) urlSession;
{
    self = [super init];
    if(self)
    {
        _urlSession = urlSession;
    }
    
    return  self;
}


-(void) downloadProfileImageFromURL:(NSString *) imageURL
                withCompletionBlock:(ProfileImageDownloadCompletionBlock) completionBlock
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:imageURL]];
    
    // create an session data task to obtain and download the app icon
    [[self.urlSession dataTaskWithRequest:request
                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
      {
          if (completionBlock != nil)
          {
              completionBlock(data);
          }
          
      }] resume];
}

@end
