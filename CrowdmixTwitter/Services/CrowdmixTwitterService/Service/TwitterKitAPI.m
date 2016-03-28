//
//  TwitterKitAPI.m
//  CrowdmixTwitter
//
//  Created by Appaji Tholeti on 28/03/2016.
//  Copyright © 2016 Tholeti. All rights reserved.
//

#import "TwitterKitAPI.h"
#import <TwitterKit/TwitterKit.h>


@implementation TwitterKitAPI


-(Twitter*) twitter
{
    if(!_twitter)
    {
        _twitter = [Twitter sharedInstance];
    }
    
    return _twitter;
}

-(TWTRAPIClient*) twitterClient
{
    if(!_twitterClient)
    {
        _twitterClient = [TWTRAPIClient  clientWithCurrentUser];
    }
    
    return _twitterClient;
}

-(TWTRComposer*) twitterComposer
{
    if(!_twitterComposer)
    {
        _twitterComposer = [TWTRComposer new];
    }
    
    return _twitterComposer;
}

@end
