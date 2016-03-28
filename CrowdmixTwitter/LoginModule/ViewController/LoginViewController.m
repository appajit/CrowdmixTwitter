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
        [self.activityIndicator stopAnimating];
        LoginViewController *strongSelf = weakSelf;
        if(!strongSelf)
        {
            return;
        }
        
        if(success)
        {
            if(strongSelf.completionBlock)
            {
                strongSelf.completionBlock();
            }
        }
        else
        {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Login failed" message:error.description preferredStyle:UIAlertControllerStyleAlert];
            
            [strongSelf presentViewController:alert animated:YES completion:nil];
        }
    }];
}

@end
