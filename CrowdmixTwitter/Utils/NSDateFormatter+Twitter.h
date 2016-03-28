//
//  NSDateFormatter+Twitter.h
//  CrowdmixTwitter
//
//  Created by Appaji Tholeti on 28/03/2016.
//  Copyright © 2016 Tholeti. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDateFormatter (Twitter)

/*
 * AS creating nsdateformatter for every tweet is an expensive operation, it provides singleton
 * date formatter to convert date string received in each tweet.
 *
 *  @return twitterDateFormatter  nsdateformatter to convert tweet date string.
 *
 */
+ (NSDateFormatter *)twitterDateFormatter;

@end
