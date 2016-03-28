//
//  NSDateFormatter+Twitter.m
//  CrowdmixTwitter
//
//  Created by Appaji Tholeti on 28/03/2016.
//  Copyright © 2016 Tholeti. All rights reserved.
//

#import "NSDateFormatter+Twitter.h"

@implementation NSDateFormatter (Twitter)


+ (NSDateFormatter *)twitterDateFormatter
{
    static NSDateFormatter *formatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"eee MMM dd HH:mm:ss ZZZZ yyyy";
    });
    
    return formatter;
}

@end
