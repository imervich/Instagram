//
//  ViewController.m
//  Instagram
//
//  Created by Iván Mervich on 8/19/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import "LoginTypeSelectionViewController.h"
#import "UserCredentials.h"
#import "SignupViewController.h"
#import "LoginViewController.h"

@interface LoginTypeSelectionViewController () <userCredentialsDelegate>
@property UserCredentials *model;
@end

@implementation LoginTypeSelectionViewController

- (void)viewDidLoad
{
    self.model = [[UserCredentials alloc] init];
    self.model.delegate = self;
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	self.navigationController.navigationBarHidden = YES;
}

-(void)userIsNew
{
    NSLog(@"dismiss logintype");
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)userLoggedIn
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)requestGotError:(NSString *)error
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:error delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Dismiss", nil];
        [alert show];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showSignUpScreenSegue"]) {
        SignupViewController *destiny = segue.destinationViewController;
        destiny.model = self.model;
    }
    if ([segue.identifier isEqualToString:@"showLoginScreenSegue"]) {
        LoginViewController *destiny = segue.destinationViewController;
        destiny.model = self.model;
    }
}

#pragma mark - IBActions

- (IBAction)onFacebookLoginButtonTapped:(UIButton *)sender
{
	NSLog(@"login with facebook");
    
    [self.model loginWithFacebook];
}

@end
