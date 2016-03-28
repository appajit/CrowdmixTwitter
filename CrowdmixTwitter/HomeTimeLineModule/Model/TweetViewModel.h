//
//  TweetViewModel.h
//  CrowdmixTwitter
//
//  Created by Appaji Tholeti on 28/03/2016.
//  Copyright © 2016 Tholeti. All rights reserved.
//

@class CrowdmixTweet;

/*
 * This model prepares all the required view data from the server data to display directly in the view.
 */

@interface TweetViewModel : NSObject

/* user profile image */
@property (copy, nonatomic)  UIImage  *profileImage;
/* tweet user name */
@property (copy, nonatomic)    NSString *name;
/* tweet user screen name in the format "@screen name" */
@property (copy, nonatomic)    NSString *screenName;

/* prepares the tweet age from the current data and tweet created data */
@property (copy, nonatomic)    NSString *tweetAge;
/* tweet text */
@property (copy, nonatomic)    NSAttributedString *tweetText;
/* tweet id */
@property (copy,nonatomic)     NSNumber *tweetId;
/* flag to know whether the profile image is downloaded from the image URL or not */
@property (nonatomic)          BOOL profileImageDownloaded;


/*
 * creates the view model form the server tweet model
 * @param crowdmixTweet  server tweet model
 * @return instance object
 */

+(instancetype) viewModelFromCrowdmixTweet:(CrowdmixTweet*) crowdmixTweet;

/*
 * updates model profile image with the rounded corner image
 * @param image   downloaded profile image
 */

-(void) configureProfileImage:(UIImage*) image;

@end
