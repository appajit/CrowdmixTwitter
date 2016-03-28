//
//  CMTimeLineTableViewCell.h
//  CrowdmixTwitter
//
//  Created by Appaji Tholeti on 28/03/2016.
//  Copyright © 2016 Tholeti. All rights reserved.
//

@class TweetViewModel;

@interface HomeTimeLineTableViewCell : UITableViewCell

@property (weak, nonatomic,readonly) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic,readonly) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic,readonly) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic,readonly) IBOutlet UILabel *tweetAgeLabel;
@property (weak, nonatomic,readonly) IBOutlet UILabel *tweetTextLabel;


/* cell identifier */
+(NSString*) cellIdentifier;

/* displays the profiles image
 * @param image downloaded profile image
 */
-(void) updateProfileImage:(UIImage*) image;

/*
 * configures the cell UI with the view model data
 *
 * @param tweetViewModel  view model to set it to cell UI elements
 */

-(void) configureWithTweetViewModel:(TweetViewModel*) tweetViewModel;

@end
