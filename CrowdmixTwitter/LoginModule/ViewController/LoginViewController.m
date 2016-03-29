//
//  ViewController.m
//  CrowdmixTwitter
//
//  Created by Appaji Tholeti on 28/03/2016.
//  Copyright © 2016 Tholeti. All rights reserved.
//

#import "LoginViewController.h"
#import "CrowdmixTwitterServicing.h"



@interface LoginViewController ()

@property (nonatomic,weak) id<CrowdmixTwitterServicing> crowdMixTwitterService;
@property (nonatomic,copy) LoginCompletionBlock completionBlock;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.activityIndicator stopAnimating];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) injectCrowdmixTwitterService:(id<CrowdmixTwitterServicing>) crowdMixTwitterService
                     completionBlock:(LoginCompletionBlock)completionBlock
{
    self.crowdMixTwitterService = crowdMixTwitterService;
    self.completionBlock = completionBlock;
}


- (IBAction)loginButtonTapped:(id)sender
{
    self.loginButton.enabled = NO;
    [self.activityIndicator startAnimating];
    
    __weak typeof(self)weakSelf = self;
    [self.crowdMixTwitterService loginWithCompletionBlock:^(BOOL success, NSError *error)
    {
        
        dispatch_async(dispatch_get_main_queue(), ^
        {
            LoginViewController *strongSelf = weakSelf;
            if(!strongSelf)
            {
                return;
            }
            
            [strongSelf.activityIndicator stopAnimating];
            strongSelf.loginButton.enabled = YES;
            
            if(success)
            {
                if(strongSelf.completionBlock)
                {
                    strongSelf.completionBlock();
                }
            }
            else
            {
                NSString *errorMessage = @"Unable to login.Please check the internet connection or try again later.";
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Login Failed" message:errorMessage preferredStyle:UIAlertControllerStyleAlert];
                
                [alert addAction:[UIAlertAction actionWithTitle:@"OK"
                                                          style:UIAlertActionStyleCancel
                                                        handler:nil]];
                [strongSelf presentViewController:alert animated:YES completion:nil];
            }
            
        });
        
    }];
}

@end
