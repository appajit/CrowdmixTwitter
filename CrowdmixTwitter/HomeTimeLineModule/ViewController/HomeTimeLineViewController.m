//
//  HomeTimeLineViewController.m
//  CrowdmixTwitter
//
//  Created by Appaji Tholeti on 28/03/2016.
//  Copyright © 2016 Tholeti. All rights reserved.
//

#import "HomeTimeLineViewController.h"
#import "HomeTimeLineTableViewCell.h"
#import "HomeTimeLinePresenter.h"
#import "TweetViewModel.h"

@interface HomeTimeLineViewController ()<UITableViewDataSource>

@property (nonatomic, strong) UIActivityIndicatorView   *activityIndicator;
@property (nonatomic,strong) HomeTimeLinePresenter      *presenter;
@property (nonatomic,strong) NSArray                    *tweetViewModels;

@end

@implementation HomeTimeLineViewController

-(void) injectPresenter:(HomeTimeLinePresenter*) presenter
{
    self.presenter = presenter;
}


-(void) viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.dataSource  = self;
    
    //set navigation title
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"twitter_blue"]];
    UIBarButtonItem *retryButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                                                                                 target:self
                                                                                 action:@selector(fetchHomeTimeLine)];
    
    //configure compose tweet and retry buttons on the navigation bar
    UIBarButtonItem *tweetButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose
                                                                                 target:self
                                                                                 action:@selector(composeTweet)];
    UIBarButtonItem *logoutButton = [[UIBarButtonItem alloc] initWithTitle:@"Logout"
                                                                     style:UIBarButtonItemStylePlain
                                                                    target:self
                                                                    action:@selector(logout)];
    
    //configure logout button on left handside of the navigation bar
    self.navigationItem.leftBarButtonItem = logoutButton;
    self.navigationItem.rightBarButtonItems = @[retryButton,tweetButton];
    
    
    //configure activity indicator to show the progress
    self.activityIndicator  = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.activityIndicator.color = [UIColor blueColor];
    self.activityIndicator.hidesWhenStopped = YES;
    [self.view addSubview: self.activityIndicator];
    
    //add center alignment constraints to the activity indicator
    [ self.activityIndicator setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.activityIndicator
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.activityIndicator
                                                          attribute:NSLayoutAttributeCenterY
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterY
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    [self.activityIndicator startAnimating];
    
    //initial estimated cell height
    self.tableView.estimatedRowHeight = 44.0;
    //self sizing cell property
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}


-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self fetchHomeTimeLine];
}

-(void) fetchHomeTimeLine
{
    __weak typeof(self)weakSelf = self;
    [self.presenter fetchHomeTimeLineDataWithCompletionHandler:^(NSArray *tweetViewModels, NSError *error)
     {
         HomeTimeLineViewController *strongSelf = weakSelf;
         if(strongSelf)
         {
             [strongSelf.activityIndicator stopAnimating];
             if(error)
             {
                 NSString *errorMessage = @"Unable to download the data. Please check the internet connection or try again later.";
                 UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Downdload Error" message:errorMessage preferredStyle:UIAlertControllerStyleAlert];
                 
                 [alert addAction:[UIAlertAction actionWithTitle:@"OK"
                            style:UIAlertActionStyleCancel
                          handler:nil]];
                 [strongSelf presentViewController:alert animated:YES completion:nil];
             }
             else
             {
                 strongSelf.tweetViewModels = tweetViewModels;
                 [strongSelf.tableView reloadData];
             }
         }
     }];
}


-(void) composeTweet
{
    __weak HomeTimeLineViewController *weakSelf = self;
    [self.presenter composeTweetFromViewController:self withCompletionHandler:^
    {
        /* as posting of tweet to server takes times, refresh the time line after 5 secs to make
         * sure that tweet has been sent to server
         */
        HomeTimeLineViewController *strongSelf = weakSelf;
        if(strongSelf)
        {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [strongSelf fetchHomeTimeLine];
            });
         }
    }];
}


-(void) logout
{
    [self.presenter logout];
}

#pragma mark - UITableViewDataSource delegat methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tweetViewModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = [HomeTimeLineTableViewCell cellIdentifier];
    HomeTimeLineTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier
                                                                      forIndexPath:indexPath];
    
    TweetViewModel *tweetViewModel = self.tweetViewModels[indexPath.row];
    [cell configureWithTweetViewModel:tweetViewModel];
    
    // defer new downloads until scrolling ends.Lazy loading of table view
    //images.
    if (!tweetViewModel.profileImageDownloaded)
    {
        if (self.tableView.dragging == NO && self.tableView.decelerating == NO)
        {
            [self getProfileImage:tweetViewModel forIndexPath:indexPath];
        }
    }
    
    return cell;
}

-(void) getProfileImage:(TweetViewModel *) tweetViewModel
           forIndexPath:(NSIndexPath *)indexPath
{
    __weak HomeTimeLineViewController *weakSelf = self;
    [self.presenter fetchProfileImageForViewModel:tweetViewModel
                            withCompletionHandler:^
     {
         HomeTimeLineViewController *strongSelf = weakSelf;
         if(strongSelf)
         {
             HomeTimeLineTableViewCell *cell = [strongSelf.tableView cellForRowAtIndexPath:indexPath];
             [cell updateProfileImage:tweetViewModel.profileImage];
         }
     }];
}


/*
 * For better user experience and app perofrmance, it downloads the only visible cell images rather than
 * downaloding all the images at a time.
 */
- (void)loadImagesForOnscreenRows
{
    if (self.tweetViewModels.count > 0)
    {
        NSArray *visiblePaths = [self.tableView indexPathsForVisibleRows];
        for (NSIndexPath *indexPath in visiblePaths)
        {
            TweetViewModel *tweetViewModel = self.tweetViewModels[indexPath.row];
            
            //if image is not downloaded trigger the download.
            if (!tweetViewModel.profileImageDownloaded)
            {
                [self getProfileImage:tweetViewModel forIndexPath:indexPath];
            }
        }
    }
}


/*
 * Handles  scrolling delegates in order to avoid downloading the images whiles user is scrolling
 * the table view for better app perofrmance.As soon as th scrolling ends it starts downloading images for all the visible cells
 */

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate)
    {
        [self loadImagesForOnscreenRows];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self loadImagesForOnscreenRows];
}

@end
