//
//  HomeTimeLineViewController.h
//  CrowdmixTwitter
//
//  Created by Appaji Tholeti on 28/03/2016.
//  Copyright © 2016 Tholeti. All rights reserved.
//


@class HomeTimeLinePresenter;

typedef void(^HomeTimeLineCompletionBlock)();

@interface HomeTimeLineViewController : UITableViewController

/*
 * inject to the presenter which provides the data to display
 *
 * @param presenter home time line presenter object
 */

-(void) injectPresenter:(HomeTimeLinePresenter*) presenter;

@end
