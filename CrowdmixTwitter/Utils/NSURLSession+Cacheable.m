//
//  NSURLSession+Cacheable.m
//  CrowdmixTwitter
//
//  Created by Appaji Tholeti on 28/03/2016.
//  Copyright © 2016 Tholeti. All rights reserved.
//

#import "NSURLSession+Cacheable.h"

@implementation NSURLSession (Cacheable)

+(instancetype) cacheableUrlSession
{
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    sessionConfig.HTTPMaximumConnectionsPerHost = 5;
    sessionConfig.requestCachePolicy = NSURLRequestReturnCacheDataElseLoad;
    return [NSURLSession sessionWithConfiguration:sessionConfig];
}


@end
