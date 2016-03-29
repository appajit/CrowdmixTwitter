//
//  HomeTimeLinePresenter.m
//  CrowdmixTwitter
//
//  Created by Appaji Tholeti on 28/03/2016.
//  Copyright © 2016 Tholeti. All rights reserved.
//

#import "HomeTimeLinePresenter.h"
#import "CrowdmixTwitterServicing.h"
#import "ProfileImageDownloading.h"
#import "TweetViewModel.h"
#import "CrowdmixTweet.h"
#import "CrowdmixTweetUser.h"

@interface HomeTimeLinePresenter ()

@property (nonatomic,weak) id<CrowdmixTwitterServicing> crowdMixTwitterService;
@property (nonatomic,weak) id<ProfileImageDownloading>  profileImageDownloadService;
@property (atomic,strong) NSMutableDictionary        *tweetsDictionary;
@property (nonatomic,copy) HomeTimeLineCompletionBlock  completionBlock;

@end

@implementation HomeTimeLinePresenter


-(instancetype) initWithCrowdmixTwitterService:(id<CrowdmixTwitterServicing>) crowdMixTwitterService
                         profileImageDownlader:(id<ProfileImageDownloading>) profileImageDownloadService
                               completionBlock:(HomeTimeLineCompletionBlock) completionBlock
{
    self = [super init];
    if(self)
    {
        _crowdMixTwitterService = crowdMixTwitterService;
        _profileImageDownloadService = profileImageDownloadService;
        _tweetsDictionary = [NSMutableDictionary dictionary];
        _completionBlock = completionBlock;
    }
    
    return self;
}

-(void) fetchHomeTimeLineDataWithCompletionHandler:(FetchHomeTimeLineDataCompletionHandler) completionHandler
{
    //delete the cache before refreshing of the data request */
    [self.tweetsDictionary removeAllObjects];
    
    __weak typeof(self)weakSelf = self;
    [self.crowdMixTwitterService downloadHomeTimeLineWithCompletionBlock:^(NSArray *tweets, NSError *error)
     {
         HomeTimeLinePresenter *strongSelf = weakSelf;
         if(strongSelf)
         {
             __block NSMutableArray *viewModelsArray;
             if(!error)
             {
                 //prepare the view models from the server data models
                 viewModelsArray = [NSMutableArray array];
                 [tweets enumerateObjectsUsingBlock:^(CrowdmixTweet * _Nonnull tweet, NSUInteger idx, BOOL * _Nonnull stop)
                 {
                     TweetViewModel *viewModel = [TweetViewModel viewModelFromCrowdmixTweet:tweet];
                     strongSelf.tweetsDictionary[tweet.tweetId] = tweet;
                     [viewModelsArray addObject:viewModel];
                 }];
             }
             //swiches from background thread to UI thread to allow view controller to set the view model data
             dispatch_async(dispatch_get_main_queue(), ^
             {
                 if(completionHandler)
                 {
                     completionHandler(viewModelsArray,error);
                 }
             });
         }
     }];
}

-(void) fetchProfileImageForViewModel:(TweetViewModel*) viewModel
                withCompletionHandler:(FetchProfileImageCompletionHandler) completionHandler
{
    //if iamge is already downloaded,just call the block immediatley.
    if(viewModel.profileImageDownloaded)
    {
        completionHandler();
        return;
    }
    
    CrowdmixTweet* tweet = self.tweetsDictionary[viewModel.tweetId];
    NSString *imageURL = tweet.tweetUser.profileImageURL;
    [self.profileImageDownloadService downloadProfileImageFromURL:imageURL
                                              withCompletionBlock:^(NSData *imageData)
    {
        UIImage *image =  [UIImage imageWithData:imageData];
        [viewModel configureProfileImage:image];
        
        //swiches from background thread to UI thread to allow view controller to set the view model data
        dispatch_async(dispatch_get_main_queue(), ^{
            if(completionHandler)
            {
                completionHandler();
            }
        });
    }];
}

-(void) composeTweetFromViewController:(UIViewController*) viewController
                 withCompletionHandler:(ComposeTweetCompletionHandler) completionHandler
{
    [self.crowdMixTwitterService composeTweetFromViewController:viewController
                                            withCompletionBlock:^
    {
        //swiches from background thread to UI thread to allow view controller to set the view model data
         dispatch_async(dispatch_get_main_queue(), ^
        {
            if(completionHandler)
            {
                completionHandler();
            }
         });
                        
    }];
}

-(void) logout
{
    [self.crowdMixTwitterService logout];
    if(self.completionBlock)
    {
        self.completionBlock();
    }
}


@end
