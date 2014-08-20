//
//  ViewController.m
//  Instagram
//
//  Created by Iván Mervich on 8/19/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import "LoginTypeSelectionViewController.h"
#import "UserCredentials.h"

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
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)userLoggedIn
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - IBActions

- (IBAction)onFacebookLoginButtonTapped:(UIButton *)sender
{
	NSLog(@"login with facebook");
    
    [self.model loginWithFacebook];
}

@end
