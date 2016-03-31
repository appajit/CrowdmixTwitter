//
//  TweetViewModel.m
//  CrowdmixTwitter
//
//  Created by Appaji Tholeti on 28/03/2016.
//  Copyright © 2016 Tholeti. All rights reserved.
//

#import "TweetViewModel.h"
#import "CrowdmixTweet.h"
#import "CrowdmixTweetUser.h"
#import "UIImage+Utils.h"
#import "NSDateFormatter+Twitter.h"
#import "CrowdmixTweetEntities.h"
#import "CrowdmixTweetHashTag.h"
#import "CrowdmixTweetUrl.h"


static NSUInteger const kRoundedCornerSize = 5;

@implementation TweetViewModel

+(instancetype) viewModelFromCrowdmixTweet:(CrowdmixTweet*) crowdmixTweet
{
    TweetViewModel* viewModel = [TweetViewModel new];
    
    /* By default the profile image is set with placeholder image untill it is downloaded. */
    UIImage *profileImage   = [UIImage imageNamed:@"loading_image"];
    viewModel.profileImage  = [profileImage imageWithRoundedCornersSize:kRoundedCornerSize];
    
    /* apply hash tags to the tweet text by changing the hash tag text color in the tweet*/
    viewModel.tweetText     = [self tweetTextWithTappableHashTagsAndUrlsIfAny:crowdmixTweet];
    
    viewModel.name          = crowdmixTweet.tweetUser.name;
    
    /* prepare the tweet age from the created date */
    viewModel.tweetAge      = [self tweetAgeFromDateString:crowdmixTweet.createdAt];
    
    /* append '@' to the screen name */
    viewModel.screenName    = [NSString stringWithFormat:@"@%@",crowdmixTweet.tweetUser.screenName];
    
    viewModel.tweetId       = crowdmixTweet.tweetId;
    
    return viewModel;
}

/* converts hashtags and url into  tappable links */
+(NSAttributedString*) tweetTextWithTappableHashTagsAndUrlsIfAny:(CrowdmixTweet*) tweet
{
    NSMutableAttributedString *tweetAttributedString = [[NSMutableAttributedString alloc] initWithString:tweet.text];
    
    //convert all hash tags into tappable links
    for (CrowdmixTweetHashTag *hashTag in tweet.entities.hashTags)
    {
        NSRange hashTagRange = [self rangeFromIndices:hashTag.indices];
        if(hashTagRange.location != NSNotFound)
        {
            [tweetAttributedString addAttribute: NSLinkAttributeName
                                          value:hashTag.text
                                          range:hashTagRange];
        }
    }
    
    
    //convert allurls into tappable links
    for (CrowdmixTweetUrl *url in tweet.entities.urls)
    {
        
        [self configureDisplayUrlForTweetUrl:url
                               inTweetString:tweetAttributedString];
    }
    
    return tweetAttributedString;
}

//Replaces the url with the tappable display url link
+(void) configureDisplayUrlForTweetUrl:(CrowdmixTweetUrl*) tweetUrl
                         inTweetString:(NSMutableAttributedString*) tweetAttributedString
{
    NSRange urlRange = [self rangeFromIndices:tweetUrl.indices];
    
    if(urlRange.location != NSNotFound)
    {
        NSDictionary *displayUrlAttributes = @{NSLinkAttributeName:tweetUrl.displayUrl};
        NSAttributedString *attributedDisplayUrl = [[NSAttributedString alloc] initWithString:tweetUrl.displayUrl
                                                                                   attributes:displayUrlAttributes];
        
        if((urlRange.location + urlRange.length) <= tweetAttributedString.length)
        {
            [tweetAttributedString replaceCharactersInRange:urlRange
                                       withAttributedString:attributedDisplayUrl];
        }
    }
}

//prepares the range from the indices
+(NSRange) rangeFromIndices:(NSArray*) indices
{
    NSRange range;
    if(indices.count == 2)
    {
        NSInteger indices0 = ((NSNumber*)indices[0]).integerValue;
        NSInteger indices1 = ((NSNumber*)indices[1]).integerValue;
        
        NSInteger location  = indices0;
        NSUInteger length   = indices1-indices0;
        range = NSMakeRange(location,length);
    }
    
    return range;
}


//Prepares the age the of the tweet from the created date of the tweet
+(NSString*) tweetAgeFromDateString:(NSString*) dateString
{
    NSDateFormatter *dateFormatter = [NSDateFormatter twitterDateFormatter];
    
    NSInteger seconds = [[NSDate date] timeIntervalSinceDate:[dateFormatter dateFromString:dateString]];
    NSInteger hours   = (int)seconds / 3600;
    NSInteger minutes = (seconds - (hours*3600)) / 60;
    NSInteger days    = (((seconds/60)/60)/24);
    
    /* returns how many days old the tweet is  */
    if(days)
    {
        return [NSString stringWithFormat:@"%ldd",days];
    }
    /* returns how many hours old the tweet is  */
    if(hours)
    {
        return [NSString stringWithFormat:@"%ldh",hours];
    }
    /* returns how many minutes old the tweet is  */
    if(minutes)
    {
        return [NSString stringWithFormat:@"%ldm",minutes];
    }
    
    /* returns how many seconds old the tweet is  */
    
    return [NSString stringWithFormat:@"%lds",seconds];
}


-(void) configureProfileImage:(UIImage*) image
{
    //applies the rounded corners to the image
    self.profileImage = [image imageWithRoundedCornersSize:kRoundedCornerSize];
    self.profileImageDownloaded = YES;
}


@end
