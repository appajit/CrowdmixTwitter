//
//  ViewController.h
//  CrowdmixTwitter
//
//  Created by Appaji Tholeti on 28/03/2016.
//  Copyright © 2016 Tholeti. All rights reserved.
//

@protocol CrowdmixTwitterServicing;
typedef void(^LoginCompletionBlock)();


@interface LoginViewController : UIViewController

-(void) injectCrowdmixTwitterService:(id<CrowdmixTwitterServicing>) crowdMixTwitterService
                     completionBlock:(LoginCompletionBlock)completionBlock;

@end

