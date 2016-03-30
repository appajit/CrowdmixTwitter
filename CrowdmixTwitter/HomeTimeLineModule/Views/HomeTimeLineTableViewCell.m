//
//  CMTimeLineTableViewCell.m
//  CrowdmixTwitter
//
//  Created by Appaji Tholeti on 28/03/2016.
//  Copyright © 2016 Tholeti. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "HomeTimeLineTableViewCell.h"
#import "UIImage+Utils.h"
#import "TweetViewModel.h"

static NSString * const kCellIdentifier = @"HomeTimeLineTableViewCell";

@interface HomeTimeLineTableViewCell ()

@property (weak, nonatomic,readwrite) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic,readwrite) IBOutlet UILabel     *nameLabel;
@property (weak, nonatomic,readwrite) IBOutlet UILabel     *screenNameLabel;
@property (weak, nonatomic,readwrite) IBOutlet UILabel     *tweetAgeLabel;
@property (weak, nonatomic,readwrite) IBOutlet UILabel     *tweetTextLabel;
@property (weak, nonatomic) IBOutlet UITextView *tweetTextView;

@end

@implementation HomeTimeLineTableViewCell

+(NSString*) cellIdentifier
{
    return kCellIdentifier;
}

-(void) awakeFromNib
{
    [super awakeFromNib];
    self.profileImageView.contentMode = UIViewContentModeScaleAspectFit;
}

-(void) configureWithTweetViewModel:(TweetViewModel*) tweetViewModel
{
    self.profileImageView.image = tweetViewModel.profileImage;
    self.tweetTextLabel.attributedText    = tweetViewModel.tweetText;
    self.tweetTextView.attributedText    = tweetViewModel.tweetText;
    self.nameLabel.text         = tweetViewModel.name;
    self.tweetAgeLabel.text     = tweetViewModel.tweetAge;
    self.screenNameLabel.text   = tweetViewModel.screenName;
}


-(void) updateProfileImage:(UIImage*) image
{
    self.profileImageView.image = image;
}

@end
